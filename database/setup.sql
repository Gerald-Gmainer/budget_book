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
CREATE POLICY "Owners can view their profile" ON profiles FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Nobody can insert profiles" ON profiles FOR INSERT WITH CHECK (false);
CREATE POLICY "Nody can update profiles" ON profiles FOR UPDATE USING (false);
CREATE POLICY "Owners can delete their profile" ON profiles FOR DELETE USING (auth.uid() = user_id);

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

-- 

CREATE OR REPLACE VIEW view_bookings AS
  SELECT b.id, b.booking_date, b.description, b.amount, b.category_id, b.account_id, b.is_deleted
  FROM bookings b
  WHERE b.user_id = auth.uid();

-- functions
-- create_profile
-- create_account
-- create_category
-- create_booking

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

drop table bookings;
drop table categories;
drop table accounts;
drop trigger on_auth_user_created on auth.users;
drop function handle_new_user;
drop table profiles;
drop type category_type;
drop type currencies;