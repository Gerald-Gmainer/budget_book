CREATE TABLE migrations (
  id SERIAL PRIMARY KEY,
  file_name text,
  execution_date timestamp with time zone NOT NULL DEFAULT NOW()
);

CREATE TYPE category_type AS ENUM
  ('income', 'outcome');

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
-- AUTH 

CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS TRIGGER AS $$
DECLARE
  profile_id integer;
BEGIN
  INSERT INTO public.profiles (user_id, name)
  VALUES (new.id, 'Username')
  RETURNING id INTO profile_id;

  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY definer;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE PROCEDURE public.handle_new_user();

CREATE OR REPLACE FUNCTION auth.get_profile_id()
 RETURNS int
 LANGUAGE sql
 STABLE
AS $function$
  SELECT 
    CASE
      WHEN current_setting('request.jwt.claims', true) IS NOT NULL THEN
        COALESCE(
          nullif((nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'user_metadata')::jsonb ->> 'profile_id', '')::int,
          null
        )
      ELSE null
    END
$function$;

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
-- PUBLIC

CREATE TABLE profiles (
  id SERIAL PRIMARY KEY,
  user_id uuid REFERENCES auth.users(id) ON DELETE CASCADE,
  name text,
  avatar_url text
);
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

CREATE OR REPLACE FUNCTION setup_profile()
RETURNS TRIGGER AS $$
DECLARE
  _profile_id INT;
BEGIN
  _profile_id := NEW.id;
  RAISE LOG 'create profile_setting%', _profile_id;
  INSERT INTO profile_settings(profile_id) VALUES (_profile_id);  

  RAISE LOG 'update auth.users raw_user_meta_data, set profile_id: %', _profile_id;
  UPDATE auth.users
  SET raw_user_meta_data = jsonb_set(
    COALESCE(raw_user_meta_data, '{}'::jsonb),
    '{profile_id}',
    to_jsonb(_profile_id)
  )
  WHERE id = new.user_id;

  RAISE LOG 'create bookings_partition_%', _profile_id;
  BEGIN
    EXECUTE 'CREATE TABLE public.bookings_partition_' || _profile_id || ' PARTITION OF public.bookings FOR VALUES FROM (' || _profile_id || ') TO (' || (_profile_id + 1) || ')';
  EXCEPTION
    WHEN OTHERS THEN
      RAISE EXCEPTION 'Error creating bookings partition for profile %: %', _profile_id, SQLERRM;
  END;

  EXECUTE 'CREATE MATERIALIZED VIEW mat_view_suggestions_' || _profile_id || ' AS
    SELECT DISTINCT ON (b.description)
          b.id, b.description, (select c.type from categories c where c.id = b.category_id) as category_type
    FROM bookings b
    WHERE b.profile_id = ' || _profile_id || ' AND b.description IS NOT NULL';

  EXECUTE 'CREATE UNIQUE INDEX idx_suggestion_id_' || _profile_id || ' ON mat_view_suggestions_' || _profile_id || ' (id)';

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER trigger_setup_profile AFTER INSERT ON profiles
  FOR EACH ROW EXECUTE FUNCTION setup_profile();

CREATE OR REPLACE FUNCTION delete_profile()
RETURNS TRIGGER AS $$
BEGIN
  EXECUTE 'DROP TABLE IF EXISTS bookings_partition_' || OLD.id;
  DELETE FROM auth.users WHERE id = OLD.user_id;

  RETURN OLD;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER trigger_delete_profile BEFORE DELETE ON profiles
  FOR EACH ROW EXECUTE FUNCTION delete_profile();

----------------------------------------------------------------------------------------------------------------

CREATE TABLE currencies (
  id SERIAL PRIMARY KEY,
  name text NOT NULL,
  decimal_precision smallint NOT NULL,
  unit_position_front BOOLEAN DEFAULT TRUE,
  symbol text NOT NULL,
  ui_order int
);
ALTER TABLE currencies ENABLE ROW LEVEL SECURITY;

CREATE OR REPLACE VIEW view_currencies AS
  SELECT c.id, c.name, c.decimal_precision, c.unit_position_front, c.symbol
  FROM currencies c
  WHERE auth.role() = 'authenticated'
  ORDER BY c.ui_order;

----------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION get_default_currency()
RETURNS int AS
$$
  SELECT id FROM currencies WHERE name = 'Euro';
$$
LANGUAGE SQL;

CREATE TABLE profile_settings (
  id SERIAL PRIMARY KEY,
  profile_id int REFERENCES profiles(id) ON DELETE CASCADE,
  currency_id INT REFERENCES currencies(id) DEFAULT get_default_currency()
);
ALTER TABLE profile_settings ENABLE ROW LEVEL SECURITY;

CREATE OR REPLACE VIEW view_profile_settings AS
  SELECT p.id, p.currency_id,
    jsonb_build_object('id', c.id, 'name', c.name, 'decimal_precision', c.decimal_precision, 
      'symbol', c.symbol, 'unit_position_front', c.unit_position_front) AS currency
  FROM profile_settings p
  LEFT OUTER JOIN currencies c ON c.id = p.currency_id
  WHERE p.profile_id = (select pp.id from profiles pp where pp.user_id = auth.uid());

----------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE VIEW view_profiles AS
  SELECT p.id, p.name, auth.email() as email, p.avatar_url,
    s.currency_id,
    jsonb_build_object('id', c.id, 'name', c.name, 'decimal_precision', c.decimal_precision, 
      'symbol', c.symbol, 'unit_position_front', c.unit_position_front) AS currency
  FROM profiles p
  LEFT OUTER JOIN profile_settings s on s.profile_id = p.id
  LEFT OUTER JOIN currencies c ON c.id = s.currency_id
  WHERE p.user_id = auth.uid();


----------------------------------------------------------------------------------------------------------------

CREATE TABLE account_icons (
  id SERIAL PRIMARY KEY,
  name text NOT NULL,
  ui_order int
);
ALTER TABLE account_icons ENABLE ROW LEVEL SECURITY;

CREATE TABLE account_colors (
  id SERIAL PRIMARY KEY,
  code text NOT NULL,
  ui_order int
);
ALTER TABLE account_colors ENABLE ROW LEVEL SECURITY;

CREATE TABLE accounts (
  id SERIAL PRIMARY KEY,
  profile_id int REFERENCES profiles(id) ON DELETE CASCADE,
  name text NOT NULL,
  icon_id int references account_icons(id) NOT NULL,
  color_id int references account_colors(id) NOT NULL
  -- init_balance_amount numeric(12, 3) DEFAULT 0,
  -- init_balance_date timestamp  NOT NULL,
  -- include_in_balance boolean DEFAULT TRUE
);
CREATE INDEX accounts_profile_id_index ON accounts (profile_id);
ALTER TABLE accounts ENABLE ROW LEVEL SECURITY;

CREATE OR REPLACE VIEW view_accounts AS
  SELECT a.id, a.name
  FROM accounts a
  WHERE a.profile_id = (select p.id from profiles p where p.user_id = auth.uid())
  ORDER BY a.name;

CREATE OR REPLACE VIEW view_account_icons AS
  SELECT c.id, c.name
  FROM account_icons c
  ORDER BY c.ui_order;

CREATE OR REPLACE VIEW view_account_colors AS
  SELECT c.id, c.code
  FROM account_colors c
  ORDER BY c.ui_order;

----------------------------------------------------------------------------------------------------------------

CREATE TABLE category_icons (
  id SERIAL PRIMARY KEY,
  name text NOT NULL,
  ui_order int
);
ALTER TABLE category_icons ENABLE ROW LEVEL SECURITY;

CREATE TABLE category_colors (
  id SERIAL PRIMARY KEY,
  code text NOT NULL,
  ui_order int
);
ALTER TABLE accounts ENABLE ROW LEVEL SECURITY;

CREATE TABLE categories (
  id SERIAL PRIMARY KEY,
  profile_id int REFERENCES profiles(id) ON DELETE CASCADE,
  name text  NOT NULL,
  icon_id int references category_icons(id) NOT NULL,
  color_id int references category_colors(id) NOT NULL,
  type category_type  NOT NULL
);
CREATE INDEX categories_profile_id_index ON categories (profile_id);
ALTER TABLE category_icons ENABLE ROW LEVEL SECURITY;

CREATE OR REPLACE FUNCTION create_category(p_category jsonb) RETURNS INTEGER AS $$
DECLARE
  category_id INTEGER;
BEGIN
  IF auth.uid() IS NULL THEN
    RAISE EXCEPTION 'User is not logged in. Please log in';
  END IF;

  INSERT INTO categories (profile_id, name, icon_id, color_id, type)
  SELECT 
    (select p.id from profiles p where p.user_id = auth.uid()), 
    p_category->>'name', 
    (p_category->>'icon_id')::int, 
    (p_category->>'color_id')::int, 
    (p_category->>'type')::category_type
    RETURNING id INTO category_id;

  RETURN category_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE OR REPLACE FUNCTION update_category(p_category JSON) RETURNS INTEGER AS $$
DECLARE
  _profile_id INTEGER;
BEGIN
  IF auth.uid() IS NULL THEN
    RAISE EXCEPTION 'User is not logged in.';
  END IF;

  SELECT auth.get_profile_id() INTO _profile_id;
  RAISE LOG 'update category for profile_id: %', _profile_id;

  UPDATE categories
  SET
    name = (p_category->>'name')::TEXT,
    icon_id = (p_category->>'icon_id')::INTEGER,
    color_id = (p_category->>'color_id')::INTEGER,
    type = (p_category->>'type')::category_type
  WHERE id = (p_category->>'id')::INTEGER 
  AND profile_id = _profile_id;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'Category not found';
  END IF;

  RETURN (p_category->>'id')::INTEGER;
END;
$$ LANGUAGE plpgsql SECURITY definer;

CREATE OR REPLACE FUNCTION delete_category(p_id int)
RETURNS void
AS $$
DECLARE
  _profile_id int;
BEGIN
 IF auth.uid() IS NULL THEN
    RAISE EXCEPTION 'User is not logged in. Please log in';
  END IF;

  SELECT auth.get_profile_id() INTO _profile_id;
  
  DELETE FROM categories
  WHERE id = p_id
  AND profile_id = _profile_id;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'Category not found';
  END IF;
END;
$$ LANGUAGE plpgsql SECURITY definer;


CREATE OR REPLACE VIEW view_categories AS
  SELECT c.id, c.name, c.icon_id, c.color_id, c.type
  FROM categories c
  WHERE c.profile_id = (select p.id from profiles p where p.user_id = auth.uid())
  ORDER BY c.name;

CREATE OR REPLACE VIEW view_category_icons AS
  SELECT c.id, c.name
  FROM category_icons c
  ORDER BY c.ui_order;

CREATE OR REPLACE VIEW view_category_colors AS
  SELECT c.id, c.code
  FROM category_colors c
  ORDER BY c.ui_order;

----------------------------------------------------------------------------------------------------------------

CREATE TABLE bookings (
  id SERIAL,
  profile_id int REFERENCES profiles(id) ON DELETE CASCADE,
  booking_date date NOT NULL,
  description varchar(20),
  amount numeric(12, 3) DEFAULT 0 NOT NULL,
  category_id int REFERENCES categories(id) NOT NULL,
  account_id int REFERENCES accounts(id) NOT NULL,
  is_deleted boolean DEFAULT FALSE,
  updated_at timestamp DEFAULT now(),
  PRIMARY KEY (id, profile_id)
) PARTITION BY RANGE (profile_id);
CREATE INDEX bookings_profile_id_index ON bookings (profile_id);
ALTER TABLE bookings ENABLE ROW LEVEL SECURITY;

CREATE OR REPLACE VIEW view_bookings AS
  SELECT b.id, b.booking_date, b.description, b.amount, b.category_id, b.account_id, b.is_deleted
  FROM bookings b
  WHERE b.profile_id = (select p.id from profiles p where p.user_id = auth.uid());

CREATE OR REPLACE FUNCTION create_booking(p_booking JSON) RETURNS INTEGER AS $$
DECLARE
  _new_booking_id INTEGER;
  _profile_id int;
BEGIN
  IF auth.uid() IS NULL THEN
    RAISE EXCEPTION 'User is not logged in. Please log in to create a booking.';
  END IF;

  SELECT auth.get_profile_id() INTO _profile_id;
  RAISE LOG 'create booking for profile_id: %', _profile_id;

  INSERT INTO bookings (profile_id, booking_date, description, amount, category_id, account_id)
  SELECT
    _profile_id,
    (p_booking->>'booking_date')::DATE,
    p_booking->>'description'::TEXT,
    (p_booking->>'amount')::NUMERIC,
    (p_booking->>'category_id')::INTEGER,
    -- (p_booking->>'account_id')::INTEGER
    1
  RETURNING id INTO _new_booking_id;

  RETURN _new_booking_id;
END;
$$ LANGUAGE plpgsql SECURITY definer;

CREATE OR REPLACE FUNCTION update_booking(p_booking JSON) RETURNS INTEGER AS $$
DECLARE
  _profile_id INTEGER;
BEGIN
  IF auth.uid() IS NULL THEN
    RAISE EXCEPTION 'User is not logged in. Please log in to update a booking.';
  END IF;

  SELECT auth.get_profile_id() INTO _profile_id;
  RAISE LOG 'update booking for profile_id: %', _profile_id;

  UPDATE bookings
  SET
    booking_date = (p_booking->>'booking_date')::DATE,
    description = p_booking->>'description'::TEXT,
    amount = (p_booking->>'amount')::NUMERIC,
    category_id = (p_booking->>'category_id')::INTEGER,
    -- account_id = (p_booking->>'account_id')::INTEGER
    account_id=1
  WHERE id = (p_booking->>'id')::INTEGER 
  AND profile_id = _profile_id;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'Booking not found';
  END IF;

  RETURN (p_booking->>'category_id')::INTEGER;
END;
$$ LANGUAGE plpgsql SECURITY definer;

CREATE OR REPLACE FUNCTION delete_booking(p_id int)
RETURNS void
AS $$
DECLARE
  _profile_id int;
BEGIN
 IF auth.uid() IS NULL THEN
    RAISE EXCEPTION 'User is not logged in. Please log in';
  END IF;

  SELECT auth.get_profile_id() INTO _profile_id;
  
  DELETE FROM bookings
  WHERE id = p_id
  AND profile_id = _profile_id;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'Booking not found';
  END IF;
END;
$$ LANGUAGE plpgsql SECURITY definer;


CREATE OR REPLACE FUNCTION refresh_mat_view_suggestions()
RETURNS TRIGGER AS $$
DECLARE
  _profile_id INT;
BEGIN
  IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
    _profile_id := NEW.profile_id;
  ELSIF TG_OP = 'DELETE' THEN
    _profile_id := OLD.profile_id;
  END IF;
  
  RAISE LOG 'refresh mat_view_suggestions for Profile ID: %', _profile_id;

  EXECUTE 'REFRESH MATERIALIZED VIEW CONCURRENTLY mat_view_suggestions_' || _profile_id;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_refresh_mat_view_suggestions AFTER INSERT OR UPDATE OR DELETE ON bookings
  FOR EACH ROW EXECUTE FUNCTION refresh_mat_view_suggestions();



----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
-- show all bookings partitions

-- SELECT
--   n.nspname AS schema_name, p.relname AS parent_table, c.relname AS partition_name, p.relispartition AS is_partition,
--   pg_get_expr(p.relpartbound, p.oid) AS partition_bound
-- FROM pg_inherits i
-- INNER JOIN pg_class p ON i.inhrelid = p.oid
-- INNER JOIN pg_namespace n ON p.relnamespace = n.oid
-- LEFT JOIN pg_class c ON i.inhparent = c.oid
-- WHERE n.nspname = 'public'   AND c.relname = 'bookings' 
-- ORDER BY p.relname;



-- functions
-- create_account

-- edit_profile
-- edit_account
-- edit_category
-- edit_booking
-- edit_profile_setting

-- delete_account
-- delete_category
-- delete_booking




-- CREATE TABLE balances (
--   id SERIAL PRIMARY KEY,
--   year int NOT NULL,
--   month int NOT NULL,
--   amount numeric(12, 3) DEFAULT 0
-- );
--
-- CREATE TABLE balance_account_links (
--   id SERIAL PRIMARY KEY,
--   account_id accounts(id)  NOT NULL,
--   balance_id balances(id)  NOT NULL
-- );

-- CREATE TABLE settings (
--   id SERIAL PRIMARY KEY
-- );

