INSERT INTO category_colors (code, name, ui_order) VALUES
  ('#FF5733', 'red', 1), 
  ('#33FF57', 'green', 2), 
  ('#3366FF', 'blue', 3),  
  ('#c2c226', 'yellow', 4), 
  ('#FF33FF', 'pink', 5), 
  ('#FF6633', 'orange', 6),  
  ('#9933FF', 'purple', 7),  
  ('#33FFFF', 'cyan', 8), 
  ('#6cb622', 'lime_green', 9), 
  ('#FF9966', 'peach', 10),  
  ('#3399CC', 'teal', 11),  
  ('#808080', 'gray', 12); 

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
  ('shopping-music', 24),
  ('dots', 25),
  ('briefcase', 26),
  ('camera', 27),
  ('guitar', 28),
  ('medical-bag', 29),
  ('t-shirt-crew-outline', 30),
  ('food-apple', 31),
  ('palette', 32),
  ('watch', 33),
  ('train-car', 34),
  ('basketball', 35);

INSERT INTO account_colors (code, name, ui_order) VALUES
  ('#FF5733', 'red', 1), 
  ('#33FF57', 'green', 2), 
  ('#3366FF', 'blue', 3),  
  ('#c2c226', 'yellow', 4), 
  ('#FF33FF', 'pink', 5), 
  ('#FF6633', 'orange', 6),  
  ('#9933FF', 'purple', 7),  
  ('#33FFFF', 'cyan', 8), 
  ('#6cb622', 'lime_green', 9), 
  ('#FF9966', 'peach', 10),  
  ('#3399CC', 'teal', 11),  
  ('#808080', 'gray', 12); 

INSERT INTO account_icons (name, ui_order) VALUES
  ('cash-multiple', 1),
  ('wallet-giftcard', 2),
  ('credit-card-outline', 3),
  ('bank', 4),
  ('coin', 5),
  ('credit-card-plus', 6),
  ('wallet', 7),
  ('shopping', 8),
  ('credit-card-clock', 9),
  ('atm', 10);

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

SELECT insert_test_data_account('Gerald Gmainer', 'debit card', 'wallet-giftcard', '#FF6633');    

SELECT insert_test_data_month('Gerald Gmainer', '2022-12', 'cash');
SELECT insert_test_data_month('Gerald Gmainer', '2023-01', 'cash');
SELECT insert_test_data_month('Gerald Gmainer', '2023-02', 'cash');
SELECT insert_test_data_month('Gerald Gmainer', '2023-03', 'cash');
SELECT insert_test_data_month('Gerald Gmainer', '2023-04', 'cash');
SELECT insert_test_data_month('Gerald Gmainer', '2023-05', 'cash');
SELECT insert_test_data_month('Gerald Gmainer', '2023-06', 'cash');
SELECT insert_test_data_month('Gerald Gmainer', '2023-07', 'cash');
SELECT insert_test_data_month('Gerald Gmainer', '2023-08', 'cash');
SELECT insert_test_data_month('Gerald Gmainer', '2023-09', 'cash');


SELECT insert_test_data_month('Username', '2023-09', 'Cash');

----------------------------------------------------------------------------------------------------------------

insert into profiles (user_id, name)
  select u.id, 'Max Mustermann' 
  from auth.users u where u.email='max_mustermann@mustermann.com';      
-- PW: aaaaaaA1

SELECT insert_test_data_account('Max Mustermann', 'cash', 'cash-multiple', '#33FF57');    

SELECT insert_test_data_month('Max Mustermann', '2022-12', 'cash');
SELECT insert_test_data_month('Max Mustermann', '2023-01', 'cash');
SELECT insert_test_data_month('Max Mustermann', '2023-02', 'cash');
SELECT insert_test_data_month('Max Mustermann', '2023-03', 'cash');
SELECT insert_test_data_month('Max Mustermann', '2023-04', 'cash');
SELECT insert_test_data_month('Max Mustermann', '2023-05', 'cash');
SELECT insert_test_data_month('Max Mustermann', '2023-06', 'cash');
SELECT insert_test_data_month('Max Mustermann', '2023-07', 'cash');
SELECT insert_test_data_month('Max Mustermann', '2023-08', 'cash');
SELECT insert_test_data_month('Max Mustermann', '2023-09', 'cash');
