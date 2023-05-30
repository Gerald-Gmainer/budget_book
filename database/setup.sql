CREATE TABLE migrations (
  id SERIAL PRIMARY KEY,
  file_name text,
  execution_date timestamp with time zone NOT NULL DEFAULT NOW()
);

CREATE TYPE category_type AS ENUM
  ('INCOME', 'OUTCOME');

CREATE TABLE category_icons (
  id SERIAL PRIMARY KEY,
  icon_path text NOT NULL,
  color text DEFAULT '#FFFFFF'
);

CREATE TABLE account_icons (
  id SERIAL PRIMARY KEY,
  icon_path text NOT NULL,
  color text DEFAULT '#FFFFFF'
);

CREATE TABLE currencies (
  id SERIAL PRIMARY KEY,
  name text  NOT NULL,
  precesion int default 2
);

--

CREATE TABLE profiles (
  id SERIAL PRIMARY KEY,
  user_id uuid REFERENCES auth.users(id) ON DELETE CASCADE,
  name text
);

CREATE TABLE accounts (
  id SERIAL PRIMARY KEY,
  profile_id INT REFERENCES profiles(id) ON DELETE CASCADE,
  name text NOT NULL,
  icon int references account_icons(id) NOT NULL,
  init_balance_amount numeric(12, 3) DEFAULT 0,
  init_balance_date timestamp  NOT NULL,
  include_in_balance boolean DEFAULT TRUE
);

CREATE TABLE categories (
  id SERIAL PRIMARY KEY,
  profile_id INT REFERENCES profiles(id) ON DELETE CASCADE,
  name text  NOT NULL,
  icon int references category_icons(id)  NOT NULL,
  type category_type  NOT NULL
);

CREATE TABLE bookings (
  id SERIAL PRIMARY KEY,
  profile_id INT REFERENCES profiles(id) ON DELETE CASCADE,
  booking_date date NOT NULL,
  description text,
  amount numeric(12, 3) DEFAULT 0 NOT NULL,
  category_id int references categories(id) NOT NULL,
  account_id int references accounts(id) NOT NULL,
  currency_id int references currencies(id) NOT NULL
);


--

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
