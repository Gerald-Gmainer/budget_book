-- For the category_colors table
INSERT INTO category_colors (code, ui_order) VALUES
  ('#FF5733', 1),  -- Red
  ('#33FF57', 2),  -- Green
  ('#3366FF', 3),  -- Blue
  ('#FFFF33', 4),  -- Yellow
  ('#FF33FF', 5),  -- Pink
  ('#FF6633', 6),  -- Orange
  ('#9933FF', 7),  -- Purple
  ('#33FFFF', 8),  -- Cyan
  ('#99FF33', 9),  -- Lime Green
  ('#FF9966', 10);  -- Peach

INSERT INTO category_icons (name, ui_order) VALUES
  ('account', 1),
  ('airplane', 2),
  ('book', 3),
  ('car', 4),
  ('cash-multiple', 5),
  ('credit-card', 6),
  ('food', 7),
  ('gift', 8),
  ('home', 9),
  ('lightbulb-outline', 10),
  ('movie', 11),
  ('music', 12),
  ('phone', 13),
  ('rocket', 14),
  ('school', 15),
  ('shopping', 16),
  ('train', 17),
  ('umbrella', 18),
  ('wallet-giftcard', 19),
  ('water', 20),
  ('wallet-membership', 21),
  ('umbrella-outline', 22),
  ('ticket-account', 23),
  ('shopping-music', 24);

INSERT INTO currencies (name, decimal_precision, symbol, unit_position_front, ui_order)
  VALUES ('Euro', 2, '€', false, 1);
INSERT INTO currencies (name, decimal_precision, symbol, ui_order)
  VALUES ('Japanese Yen', 0, '¥', 2);
INSERT INTO currencies (name, decimal_precision, symbol, ui_order)
  VALUES ('US Dollar', 2, '$', 3);


----------------------------------------------------------------------------------------------------------------

insert into profiles (user_id, name)
  select u.id, 'Gerald Gmainer' 
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

WITH user_data AS ( SELECT u.id AS user_id FROM auth.users u WHERE u.email = 'gerald_gmainer@designium.jp')
INSERT INTO categories (user_id, name, type, icon_id, color_id)
SELECT ud.user_id,  'baby', 'outcome'::category_type,
  (SELECT id FROM category_icons WHERE name = 'school'),  
  (SELECT id FROM category_colors WHERE code = '#FF6633')
FROM user_data ud;

WITH user_data AS ( SELECT u.id AS user_id FROM auth.users u WHERE u.email = 'gerald_gmainer@designium.jp')
INSERT INTO categories (user_id, name, type, icon_id, color_id)
SELECT ud.user_id,  'entertainment', 'outcome'::category_type,
  (SELECT id FROM category_icons WHERE name = 'music'),  
  (SELECT id FROM category_colors WHERE code = '#9933FF')
FROM user_data ud;

WITH user_data AS ( SELECT u.id AS user_id FROM auth.users u WHERE u.email = 'gerald_gmainer@designium.jp')
INSERT INTO categories (user_id, name, type, icon_id, color_id)
SELECT ud.user_id,  'gift', 'outcome'::category_type,
  (SELECT id FROM category_icons WHERE name = 'gift'),  
  (SELECT id FROM category_colors WHERE code = '#33FFFF')
FROM user_data ud;

WITH user_data AS ( SELECT u.id AS user_id FROM auth.users u WHERE u.email = 'gerald_gmainer@designium.jp')
INSERT INTO categories (user_id, name, type, icon_id, color_id)
SELECT ud.user_id,  'eating out', 'outcome'::category_type,
  (SELECT id FROM category_icons WHERE name = 'food'),  
  (SELECT id FROM category_colors WHERE code = '#FF9966')
FROM user_data ud;

WITH user_data AS ( SELECT u.id AS user_id FROM auth.users u WHERE u.email = 'gerald_gmainer@designium.jp')
INSERT INTO categories (user_id, name, type, icon_id, color_id)
SELECT ud.user_id,  'other', 'outcome'::category_type,
  (SELECT id FROM category_icons WHERE name = 'umbrella-outline'),  
  (SELECT id FROM category_colors WHERE code = '#99FF33')
FROM user_data ud;

SELECT insert_test_data_month('gerald_gmainer@designium.jp', '2022-12');
SELECT insert_test_data_month('gerald_gmainer@designium.jp', '2023-01');
SELECT insert_test_data_month('gerald_gmainer@designium.jp', '2023-02');
SELECT insert_test_data_month('gerald_gmainer@designium.jp', '2023-03');
SELECT insert_test_data_month('gerald_gmainer@designium.jp', '2023-04');
SELECT insert_test_data_month('gerald_gmainer@designium.jp', '2023-05');
SELECT insert_test_data_month('gerald_gmainer@designium.jp', '2023-06');
SELECT insert_test_data_month('gerald_gmainer@designium.jp', '2023-07');
SELECT insert_test_data_month('gerald_gmainer@designium.jp', '2023-08');
SELECT insert_test_data_month('gerald_gmainer@designium.jp', '2023-09');
SELECT insert_test_data_month('gerald_gmainer@designium.jp', '2023-10');