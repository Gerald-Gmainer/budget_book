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

insert into accounts(profile_id, name, init_balance_amount, init_balance_date, include_in_balance)
  select p.id, 'cash', 0, now(), true
  from profiles p where p.name='Gerald Gmainer';     


SELECT insert_test_data_category('Gerald Gmainer', 'work', 'income'::category_type, 'book', '#FF5733');
SELECT insert_test_data_category('Gerald Gmainer', 'saving', 'income'::category_type, 'wallet-giftcard', '#33FF57');
SELECT insert_test_data_category('Gerald Gmainer', 'house', 'outcome'::category_type, 'home', '#3366FF');
SELECT insert_test_data_category('Gerald Gmainer', 'car', 'outcome'::category_type, 'car', '#FFFF33');
SELECT insert_test_data_category('Gerald Gmainer', 'food', 'outcome'::category_type, 'food', '#FF33FF');
SELECT insert_test_data_category('Gerald Gmainer', 'baby', 'outcome'::category_type, 'school', '#FF6633');
SELECT insert_test_data_category('Gerald Gmainer', 'entertainment', 'outcome'::category_type, 'music', '#9933FF');
SELECT insert_test_data_category('Gerald Gmainer', 'eating out', 'outcome'::category_type, 'food', '#FF9966');
SELECT insert_test_data_category('Gerald Gmainer', 'other', 'outcome'::category_type, 'umbrella-outline', '#99FF33');

SELECT insert_test_data_month('Gerald Gmainer', '2022-12');
SELECT insert_test_data_month('Gerald Gmainer', '2023-01');
SELECT insert_test_data_month('Gerald Gmainer', '2023-02');
SELECT insert_test_data_month('Gerald Gmainer', '2023-03');
SELECT insert_test_data_month('Gerald Gmainer', '2023-04');
SELECT insert_test_data_month('Gerald Gmainer', '2023-05');
SELECT insert_test_data_month('Gerald Gmainer', '2023-06');
SELECT insert_test_data_month('Gerald Gmainer', '2023-07');
SELECT insert_test_data_month('Gerald Gmainer', '2023-08');
SELECT insert_test_data_month('Gerald Gmainer', '2023-09');



----------------------------------------------------------------------------------------------------------------

insert into profiles (user_id, name)
  select u.id, 'Max Mustermann' 
  from auth.users u where u.email='max_mustermann@mustermann.com';      
-- PW: aaaaaaA1

insert into accounts(profile_id, name, init_balance_amount, init_balance_date, include_in_balance)
  select p.id, 'cash', 0, now(), true
  from profiles p where p.name='Max Mustermann';     


SELECT insert_test_data_category('Max Mustermann', 'work', 'income'::category_type, 'book', '#FF5733');
SELECT insert_test_data_category('Max Mustermann', 'saving', 'income'::category_type, 'wallet-giftcard', '#33FF57');
SELECT insert_test_data_category('Max Mustermann', 'house', 'outcome'::category_type, 'home', '#3366FF');
SELECT insert_test_data_category('Max Mustermann', 'car', 'outcome'::category_type, 'car', '#FFFF33');
SELECT insert_test_data_category('Max Mustermann', 'food', 'outcome'::category_type, 'food', '#FF33FF');
SELECT insert_test_data_category('Max Mustermann', 'baby', 'outcome'::category_type, 'school', '#FF6633');
SELECT insert_test_data_category('Max Mustermann', 'entertainment', 'outcome'::category_type, 'music', '#9933FF');
SELECT insert_test_data_category('Max Mustermann', 'eating out', 'outcome'::category_type, 'food', '#FF9966');
SELECT insert_test_data_category('Max Mustermann', 'other', 'outcome'::category_type, 'umbrella-outline', '#99FF33');

SELECT insert_test_data_month('Max Mustermann', '2022-12');
SELECT insert_test_data_month('Max Mustermann', '2023-01');
SELECT insert_test_data_month('Max Mustermann', '2023-02');
SELECT insert_test_data_month('Max Mustermann', '2023-03');
SELECT insert_test_data_month('Max Mustermann', '2023-04');
SELECT insert_test_data_month('Max Mustermann', '2023-05');
SELECT insert_test_data_month('Max Mustermann', '2023-06');
SELECT insert_test_data_month('Max Mustermann', '2023-07');
SELECT insert_test_data_month('Max Mustermann', '2023-08');
SELECT insert_test_data_month('Max Mustermann', '2023-09');
