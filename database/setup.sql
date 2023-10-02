CREATE TABLE migrations (
  id SERIAL PRIMARY KEY,
  file_name text,
  execution_date timestamp with time zone NOT NULL DEFAULT NOW()
);

CREATE TYPE category_type AS ENUM
  ('income', 'outcome');

CREATE TYPE currencies AS ENUM 
  ('eur', 'yen');


-- TODO create type for icons
--

CREATE TABLE profiles (
  id SERIAL PRIMARY KEY,
  user_id uuid REFERENCES auth.users(id) ON DELETE CASCADE,
  name text,
  avatar_url text
);

ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Nobody can view profiles" ON profiles FOR SELECT USING (false);
CREATE POLICY "Nobody can insert profiles" ON profiles FOR INSERT WITH CHECK (false);
CREATE POLICY "Nobody can update profiles" ON profiles FOR UPDATE USING (false);
CREATE POLICY "Nobody can delete their profile" ON profiles FOR DELETE USING (false);

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

--

CREATE TABLE accounts (
  id SERIAL PRIMARY KEY,
  user_id uuid REFERENCES auth.users(id) ON DELETE CASCADE,
  name text NOT NULL,
   currency currencies NOT NULL,
  -- icon int references account_icons(id) NOT NULL,
  init_balance_amount numeric(12, 3) DEFAULT 0,
  init_balance_date timestamp  NOT NULL,
  include_in_balance boolean DEFAULT TRUE
);

CREATE TABLE categories (
  id SERIAL PRIMARY KEY,
  user_id uuid REFERENCES auth.users(id) ON DELETE CASCADE,
  name text  NOT NULL,
  -- icon int references category_icons(id)  NOT NULL,
  type category_type  NOT NULL
);

--

CREATE TABLE bookings (
  id SERIAL PRIMARY KEY,
  user_id uuid REFERENCES auth.users(id) ON DELETE CASCADE,
  booking_date date NOT NULL,
  description text,
  amount numeric(12, 3) DEFAULT 0 NOT NULL,
  category_id int references categories(id) NOT NULL,
  account_id int references accounts(id) NOT NULL,
  is_deleted boolean DEFAULT FALSE,
  updated_at timestamp DEFAULT now()
);

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

ALTER TABLE bookings ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Nobody can view bookings" ON bookings FOR SELECT USING (false);
CREATE POLICY "Nobody can insert bookings" ON bookings FOR INSERT WITH CHECK (false);
CREATE POLICY "Nobody can update bookings" ON bookings FOR UPDATE USING (false);
CREATE POLICY "Nobody can delete bookings" ON bookings FOR DELETE USING (false);


-- 



-- functions
-- create_profile
-- create_account
-- create_category

-- edit_profile
-- edit_account
-- edit_category
-- edit_booking

-- delete_account
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
