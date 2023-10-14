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

CREATE FUNCTION handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO profiles (id, email, username, full_name, avatar_url)
  VALUES (new.id);

  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY definer;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE PROCEDURE public.handle_new_user();

-- TODO create test data on create, like category, etc

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

CREATE OR REPLACE VIEW view_profiles AS
  SELECT p.id, p.name, p.avatar_url
  FROM profiles p
  WHERE p.user_id = auth.uid();

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
  user_id uuid REFERENCES auth.users(id) ON DELETE CASCADE,
  currency_id INT REFERENCES currencies(id) DEFAULT get_default_currency()
);
ALTER TABLE profile_settings ENABLE ROW LEVEL SECURITY;

CREATE OR REPLACE VIEW view_profile_settings AS
  SELECT p.id, p.currency_id
  FROM profile_settings p
  WHERE p.user_id = auth.uid();

----------------------------------------------------------------------------------------------------------------

CREATE TABLE accounts (
  id SERIAL PRIMARY KEY,
  user_id uuid REFERENCES auth.users(id) ON DELETE CASCADE,
  name text NOT NULL,
  -- icon int references account_icons(id) NOT NULL,
  init_balance_amount numeric(12, 3) DEFAULT 0,
  init_balance_date timestamp  NOT NULL,
  include_in_balance boolean DEFAULT TRUE
);
ALTER TABLE accounts ENABLE ROW LEVEL SECURITY;

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
  user_id uuid REFERENCES auth.users(id) ON DELETE CASCADE,
  name text  NOT NULL,
  icon_id int references category_icons(id) NOT NULL,
  color_id int references category_colors(id) NOT NULL,
  type category_type  NOT NULL
);
ALTER TABLE category_icons ENABLE ROW LEVEL SECURITY;

CREATE OR REPLACE FUNCTION create_category(p_category jsonb) RETURNS INTEGER AS $$
DECLARE
  category_id INTEGER;
BEGIN
  IF auth.uid() IS NULL THEN
    RAISE EXCEPTION 'User is not logged in. Please log in';
  END IF;

  INSERT INTO categories (user_id, name, icon_id, color_id, type)
  SELECT 
    auth.uid(), 
    p_category->>'name', 
    (p_category->>'icon_id')::int, 
    (p_category->>'color_id')::int, 
    (p_category->>'type')::category_type
    RETURNING id INTO category_id;

  RETURN category_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE OR REPLACE VIEW view_categories AS
  SELECT c.id, c.name, c.icon_id, c.color_id, c.type
  FROM categories c
  WHERE c.user_id = auth.uid()
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
  id SERIAL PRIMARY KEY,
  user_id uuid REFERENCES auth.users(id) ON DELETE CASCADE,
  booking_date date NOT NULL,
  description text,
  amount numeric(12, 3) DEFAULT 0 NOT NULL,
  category_id int REFERENCES categories(id) NOT NULL,
  account_id int REFERENCES accounts(id) NOT NULL,
  is_deleted boolean DEFAULT FALSE,
  updated_at timestamp DEFAULT now()
);
ALTER TABLE bookings ENABLE ROW LEVEL SECURITY;

CREATE OR REPLACE VIEW view_bookings AS
  SELECT b.id, b.booking_date, b.description, b.amount, b.category_id, b.account_id, b.is_deleted
  FROM bookings b
  WHERE b.user_id = auth.uid();

CREATE OR REPLACE FUNCTION create_booking(p_booking JSON) RETURNS INTEGER AS $$
DECLARE
  _new_booking_id INTEGER;
  _user_id uuid;
BEGIN
  SELECT auth.uid() INTO _user_id;
  RAISE LOG 'create booking by user_id: %', _user_id;
  RAISE LOG '%', p_booking;

  IF auth.uid() IS NULL THEN
    RAISE EXCEPTION 'User is not logged in. Please log in to create a booking.';
  END IF;

  INSERT INTO bookings (user_id, booking_date, description, amount, category_id, account_id)
  SELECT
    _user_id,
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




-- 



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

