insert into profiles (user_id, name)
select u.id, 'test name' 
from auth.users u where u.email='gerald_gmainer@designium.jp';

insert into accounts(user_id, name, currency, init_balance_amount, init_balance_date, include_in_balance)
select u.id, 'cash', 'yen'::currencies, 0, now(), true
from auth.users u where u.email='gerald_gmainer@designium.jp';

insert into categories(user_id, name, type)
select u.id, 'work', 'income'::category_type
from auth.users u where u.email='gerald_gmainer@designium.jp';
insert into categories(user_id, name, type)
select u.id, 'house', 'outcome'::category_type
from auth.users u where u.email='gerald_gmainer@designium.jp';
insert into categories(user_id, name, type)
select u.id, 'car', 'outcome'::category_type
from auth.users u where u.email='gerald_gmainer@designium.jp';
insert into categories(user_id, name, type)
select u.id, 'food', 'outcome'::category_type
from auth.users u where u.email='gerald_gmainer@designium.jp';

-- 

-- may 2023

insert into bookings(user_id, booking_date, amount, category_id, account_id)
    select u.id, TO_TIMESTAMP('2023-05-10', 'YYYY-MM-DD'), 300000, 
    (select c.id from categories c where c.name = 'work'), 
    (select a.id from accounts a where a.name = 'cash')
    from auth.users u where u.email='gerald_gmainer@designium.jp';

insert into bookings(user_id, booking_date, amount, category_id, account_id)
    select u.id, TO_TIMESTAMP('2023-05-10', 'YYYY-MM-DD'), 70000, 
    (select c.id from categories c where c.name = 'house'), 
    (select a.id from accounts a where a.name = 'cash')
    from auth.users u where u.email='gerald_gmainer@designium.jp';
insert into bookings(user_id, booking_date, amount, category_id, account_id)
    select u.id, TO_TIMESTAMP('2023-05-28', 'YYYY-MM-DD'), 10000, 
    (select c.id from categories c where c.name = 'car'), 
    (select a.id from accounts a where a.name = 'cash')
    from auth.users u where u.email='gerald_gmainer@designium.jp';
insert into bookings(user_id, booking_date, amount, category_id, account_id)
    select u.id, TO_TIMESTAMP('2023-05-01', 'YYYY-MM-DD'), 3000, 
    (select c.id from categories c where c.name = 'food'), 
    (select a.id from accounts a where a.name = 'cash')
    from auth.users u where u.email='gerald_gmainer@designium.jp';
insert into bookings(user_id, booking_date, amount, category_id, account_id)
    select u.id, TO_TIMESTAMP('2023-05-15', 'YYYY-MM-DD'), 2500, 
    (select c.id from categories c where c.name = 'food'), 
    (select a.id from accounts a where a.name = 'cash')
    from auth.users u where u.email='gerald_gmainer@designium.jp';

-- june 2023

insert into bookings(user_id, booking_date, amount, category_id, account_id)
    select u.id, TO_TIMESTAMP('2023-06-10', 'YYYY-MM-DD'), 300000, 
    (select c.id from categories c where c.name = 'work'), 
    (select a.id from accounts a where a.name = 'cash')
    from auth.users u where u.email='gerald_gmainer@designium.jp';

insert into bookings(user_id, booking_date, amount, category_id, account_id)
    select u.id, TO_TIMESTAMP('2023-06-10', 'YYYY-MM-DD'), 70000, 
    (select c.id from categories c where c.name = 'house'), 
    (select a.id from accounts a where a.name = 'cash')
    from auth.users u where u.email='gerald_gmainer@designium.jp';
insert into bookings(user_id, booking_date, amount, category_id, account_id)
    select u.id, TO_TIMESTAMP('2023-06-28', 'YYYY-MM-DD'), 10000, 
    (select c.id from categories c where c.name = 'car'), 
    (select a.id from accounts a where a.name = 'cash')
    from auth.users u where u.email='gerald_gmainer@designium.jp';
insert into bookings(user_id, booking_date, amount, category_id, account_id)
    select u.id, TO_TIMESTAMP('2023-06-01', 'YYYY-MM-DD'), 1005, 
    (select c.id from categories c where c.name = 'food'), 
    (select a.id from accounts a where a.name = 'cash')
    from auth.users u where u.email='gerald_gmainer@designium.jp';
insert into bookings(user_id, booking_date, amount, category_id, account_id)
    select u.id, TO_TIMESTAMP('2023-06-02', 'YYYY-MM-DD'), 100, 
    (select c.id from categories c where c.name = 'food'), 
    (select a.id from accounts a where a.name = 'cash')
    from auth.users u where u.email='gerald_gmainer@designium.jp';