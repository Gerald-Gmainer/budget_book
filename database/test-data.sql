INSERT INTO category_colors (code) VALUES
  ('#FF5733'),  -- Red
  ('#33FF57'),  -- Green
  ('#3366FF'),  -- Blue
  ('#FFFF33'),  -- Yellow
  ('#FF33FF'),  -- Pink
  ('#FF6633'),  -- Orange
  ('#9933FF'),  -- Purple
  ('#33FFFF'),  -- Cyan
  ('#99FF33'),  -- Lime Green
  ('#FF9966');  -- Peach

INSERT INTO category_icons (name) VALUES
  ('account'),
  ('airplane'),
  ('book'),
  ('car'),
  ('cash-multiple'),
  ('credit-card'),
  ('food'),
  ('gift'),
  ('home'),
  ('lightbulb-outline'),
  ('movie'),
  ('music'),
  ('phone'),
  ('rocket'),
  ('school'),
  ('shopping'),
  ('train'),
  ('umbrella'),
  ('wallet-giftcard'),
  ('water'),
  ('wallet-membership'),
  ('umbrella-outline'),
  ('ticket-account'),
  ('shopping-music');

INSERT INTO currencies (name, decimal_precision, symbol, unit_position_front)
  VALUES ('Euro', 2, '€', false);
INSERT INTO currencies (name, decimal_precision, symbol)
  VALUES ('Japanese Yen', 0, '¥');
INSERT INTO currencies (name, decimal_precision, symbol)
  VALUES ('US Dollar', 2, '$');


----------------------------------------------------------------------------------------------------------------

insert into profiles (user_id, name)
  select u.id, 'test name' 
  from auth.users u where u.email='gerald_gmainer@designium.jp';      
-- PW: aaaaaaA1

insert into profile_settings(user_id)
  select u.id
  from auth.users u where u.email='gerald_gmainer@designium.jp';      

insert into accounts(user_id, name, init_balance_amount, init_balance_date, include_in_balance)
select u.id, 'cash', 0, now(), true
from auth.users u 
where u.email='gerald_gmainer@designium.jp';

WITH user_data AS ( SELECT u.id AS user_id FROM auth.users u WHERE u.email = 'gerald_gmainer@designium.jp')
INSERT INTO categories (user_id, name, type, icon_id, color_id)
SELECT ud.user_id, 'work', 'income'::category_type,
  (SELECT id FROM category_icons WHERE name = 'book'),
  (SELECT id FROM category_colors WHERE code = '#FF5733') 
FROM user_data ud;

WITH user_data AS ( SELECT u.id AS user_id FROM auth.users u WHERE u.email = 'gerald_gmainer@designium.jp')
INSERT INTO categories (user_id, name, type, icon_id, color_id)
SELECT
  ud.user_id, 'saving', 'income'::category_type,
  (SELECT id FROM category_icons WHERE name = 'wallet-giftcard'),  
  (SELECT id FROM category_colors WHERE code = '#33FF57')
FROM user_data ud;

WITH user_data AS ( SELECT u.id AS user_id FROM auth.users u WHERE u.email = 'gerald_gmainer@designium.jp')
INSERT INTO categories (user_id, name, type, icon_id, color_id)
SELECT ud.user_id, 'house', 'outcome'::category_type, 
  (SELECT id FROM category_icons WHERE name = 'home'),  
  (SELECT id FROM category_colors WHERE code = '#3366FF')
FROM user_data ud;

WITH user_data AS ( SELECT u.id AS user_id FROM auth.users u WHERE u.email = 'gerald_gmainer@designium.jp')
INSERT INTO categories (user_id, name, type, icon_id, color_id)
SELECT ud.user_id, 'car', 'outcome'::category_type,
  (SELECT id FROM category_icons WHERE name = 'car'),  
  (SELECT id FROM category_colors WHERE code = '#FFFF33')
FROM user_data ud;

WITH user_data AS ( SELECT u.id AS user_id FROM auth.users u WHERE u.email = 'gerald_gmainer@designium.jp')
INSERT INTO categories (user_id, name, type, icon_id, color_id)
SELECT ud.user_id,  'food', 'outcome'::category_type,
  (SELECT id FROM category_icons WHERE name = 'food'),  
  (SELECT id FROM category_colors WHERE code = '#FF33FF')
FROM user_data ud;



-- April 2023
WITH user_data AS ( SELECT u.id AS user_id FROM auth.users u WHERE u.email = 'gerald_gmainer@designium.jp')
INSERT INTO bookings (user_id, booking_date, amount, category_id, account_id)
SELECT  ud.user_id,  TO_TIMESTAMP('2023-04-14', 'YYYY-MM-DD'), 800, c.id, a.id
FROM  user_data ud
JOIN categories c ON c.name = 'house' AND c.user_id = ud.user_id
JOIN accounts a ON a.name = 'cash' AND a.user_id = ud.user_id;

-- May 2023
WITH user_data AS ( SELECT u.id AS user_id FROM auth.users u WHERE u.email = 'gerald_gmainer@designium.jp')
INSERT INTO bookings (user_id, booking_date, amount, category_id, account_id)
SELECT ud.user_id,  TO_TIMESTAMP('2023-05-10', 'YYYY-MM-DD'), 2300, c.id, a.id
FROM user_data ud
JOIN categories c ON c.name = 'work' AND c.user_id = ud.user_id
JOIN accounts a ON a.name = 'cash' AND a.user_id = ud.user_id;

WITH user_data AS ( SELECT u.id AS user_id FROM auth.users u WHERE u.email = 'gerald_gmainer@designium.jp')
INSERT INTO bookings (user_id, booking_date, amount, category_id, account_id)
SELECT ud.user_id, TO_TIMESTAMP('2023-05-10', 'YYYY-MM-DD'), 800, c.id, a.id
FROM user_data ud
JOIN categories c ON c.name = 'house' AND c.user_id = ud.user_id
JOIN accounts a ON a.name = 'cash' AND a.user_id = ud.user_id;

WITH user_data AS ( SELECT u.id AS user_id FROM auth.users u WHERE u.email = 'gerald_gmainer@designium.jp')
INSERT INTO bookings (user_id, booking_date, amount, category_id, account_id)
SELECT  ud.user_id, TO_TIMESTAMP('2023-05-28', 'YYYY-MM-DD'), 195.12, c.id, a.id
FROM user_data ud
JOIN categories c ON c.name = 'car' AND c.user_id = ud.user_id
JOIN accounts a ON a.name = 'cash' AND a.user_id = ud.user_id;

WITH user_data AS ( SELECT u.id AS user_id FROM auth.users u WHERE u.email = 'gerald_gmainer@designium.jp')
INSERT INTO bookings (user_id, booking_date, amount, category_id, account_id)
SELECT ud.user_id, TO_TIMESTAMP('2023-05-01', 'YYYY-MM-DD'), 3000, c.id, a.id
FROM user_data ud
JOIN categories c ON c.name = 'food' AND c.user_id = ud.user_id
JOIN accounts a ON a.name = 'cash' AND a.user_id = ud.user_id;

WITH user_data AS ( SELECT u.id AS user_id FROM auth.users u WHERE u.email = 'gerald_gmainer@designium.jp')
INSERT INTO bookings (user_id, booking_date, amount, category_id, account_id)
SELECT ud.user_id, TO_TIMESTAMP('2023-05-15', 'YYYY-MM-DD'), 43.55, c.id, a.id
FROM user_data ud
JOIN categories c ON c.name = 'food' AND c.user_id = ud.user_id
JOIN accounts a ON a.name = 'cash' AND a.user_id = ud.user_id;

-- June 2023
WITH user_data AS ( SELECT u.id AS user_id FROM auth.users u WHERE u.email = 'gerald_gmainer@designium.jp')
INSERT INTO bookings (user_id, booking_date, amount, category_id, account_id)
SELECT ud.user_id, TO_TIMESTAMP('2023-06-10', 'YYYY-MM-DD'), 2300, c.id, a.id
FROM user_data ud
  JOIN categories c ON c.name = 'work' AND c.user_id = ud.user_id
  JOIN accounts a ON a.name = 'cash' AND a.user_id = ud.user_id;

WITH user_data AS ( SELECT u.id AS user_id FROM auth.users u WHERE u.email = 'gerald_gmainer@designium.jp')
INSERT INTO bookings (user_id, booking_date, amount, category_id, account_id)
SELECT ud.user_id, TO_TIMESTAMP('2023-06-10', 'YYYY-MM-DD'), 800, c.id, a.id
FROM user_data ud
JOIN categories c ON c.name = 'house' AND c.user_id = ud.user_id
JOIN accounts a ON a.name = 'cash' AND a.user_id = ud.user_id;

WITH user_data AS ( SELECT u.id AS user_id FROM auth.users u WHERE u.email = 'gerald_gmainer@designium.jp')
INSERT INTO bookings (user_id, booking_date, amount, category_id, account_id)
SELECT ud.user_id, TO_TIMESTAMP('2023-06-28', 'YYYY-MM-DD'), 195.12, c.id, a.id
FROM user_data ud
JOIN categories c ON c.name = 'car'
JOIN accounts a ON a.name = 'cash';

WITH user_data AS ( SELECT u.id AS user_id FROM auth.users u WHERE u.email = 'gerald_gmainer@designium.jp')
INSERT INTO bookings (user_id, booking_date, amount, category_id, account_id)
SELECT ud.user_id, TO_TIMESTAMP('2023-06-01', 'YYYY-MM-DD'), 78.21, c.id, a.id
FROM user_data ud
JOIN categories c ON c.name = 'food'
JOIN accounts a ON a.name = 'cash';

WITH user_data AS ( SELECT u.id AS user_id FROM auth.users u WHERE u.email = 'gerald_gmainer@designium.jp')
INSERT INTO bookings (user_id, booking_date, amount, category_id, account_id)
SELECT ud.user_id, TO_TIMESTAMP('2023-06-02', 'YYYY-MM-DD'), 4.1, c.id,  a.id
FROM user_data ud
JOIN categories c ON c.name = 'food'
JOIN accounts a ON a.name = 'cash';

WITH user_data AS ( SELECT u.id AS user_id FROM auth.users u WHERE u.email = 'gerald_gmainer@designium.jp')
INSERT INTO bookings (user_id, booking_date, amount, category_id, account_id)
SELECT ud.user_id, TO_TIMESTAMP('2023-06-1', 'YYYY-MM-DD'), 321, c.id, a.id
FROM user_data ud
JOIN categories c ON c.name = 'saving'
JOIN accounts a ON a.name = 'cash';
