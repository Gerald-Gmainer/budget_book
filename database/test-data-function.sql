
DROP FUNCTION IF EXISTS insert_test_data_booking;
CREATE OR REPLACE FUNCTION insert_test_data_booking(
    _user_id uuid,
    _date text,
    _amount numeric,
    _category_name text,
    _account_name text,
    _description text
) RETURNS void AS $$
BEGIN
    INSERT INTO bookings (user_id, booking_date, amount, category_id, account_id, description)
    SELECT _user_id, TO_TIMESTAMP(_date, 'YYYY-MM-DD'), _amount, c.id, a.id, _description
    FROM categories c
    JOIN accounts a ON a.name = _account_name AND a.user_id = _user_id
    WHERE c.name = _category_name AND c.user_id = _user_id;
END;
$$ LANGUAGE plpgsql;



DROP FUNCTION IF EXISTS insert_test_data_month;
CREATE OR REPLACE FUNCTION insert_test_data_month(email_param text, month_param text) 
RETURNS text AS $$
DECLARE
    _user_id uuid;
    _inserted_rows integer := 0;
    _day integer;
    _random_amount numeric;
BEGIN
    SELECT u.id INTO _user_id
    FROM auth.users u
    WHERE u.email = email_param;

    PERFORM insert_test_data_booking(_user_id, month_param || '-10', 2400, 'work', 'cash', 'salary');
    _inserted_rows := _inserted_rows + 1;

    IF random() < 0.5 THEN
        PERFORM insert_test_data_booking(_user_id, month_param || '-14', 500, 'saving', 'cash', 'saved money');
        _inserted_rows := _inserted_rows + 1;
    END IF;

    PERFORM insert_test_data_booking(_user_id, month_param || '-10', 800, 'house', 'cash', 'montly rent');
    _inserted_rows := _inserted_rows + 1;
    PERFORM insert_test_data_booking(_user_id, month_param || '-11', 55.4, 'house', 'cash', 'heating costs');
    _inserted_rows := _inserted_rows + 1;
    PERFORM insert_test_data_booking(_user_id, month_param || '-12', 94.21, 'house', 'cash', 'power costs');
    _inserted_rows := _inserted_rows + 1;

    PERFORM insert_test_data_booking(_user_id, month_param || '-15', 112.12, 'car', 'cash', '12345678901234567890');
    _inserted_rows := _inserted_rows + 1;

    FOR i IN 1..3 LOOP
        _day := floor(random() * 28) + 1;
        _random_amount := (random() * (50 - 30) + 50)::numeric;
        
        PERFORM insert_test_data_booking(_user_id, month_param || '-' || _day, round(_random_amount, 2), 'car', 'cash', 'gas');
        _inserted_rows := _inserted_rows + 1;
    END LOOP;

    FOR i IN 1..2 LOOP
        _day := floor(random() * 28) + 1;
        _random_amount := (random() * (10 - 5) + 50)::numeric;
        
        PERFORM insert_test_data_booking(_user_id, month_param || '-' || _day, round(_random_amount, 2), 'baby', 'cash', 'diaper');
        _inserted_rows := _inserted_rows + 1;
        _random_amount := (random() * (12 - 6) + 50)::numeric;
        PERFORM insert_test_data_booking(_user_id, month_param || '-' || _day, round(_random_amount, 2), 'baby', 'cash', 'cloth');
        _inserted_rows := _inserted_rows + 1;
    END LOOP;

    FOR i IN 1..2 LOOP
        _day := floor(random() * 28) + 1;
        _random_amount := (random() * (50 - 40) + 50)::numeric;
        
        PERFORM insert_test_data_booking(_user_id, month_param || '-' || _day, round(_random_amount, 2), 'entertainment', 'cash', 'cinema');
        _inserted_rows := _inserted_rows + 1;
    END LOOP;

    FOR i IN 1..2 LOOP
        _day := floor(random() * 28) + 1;
        _random_amount := (random() * (30 - 20) + 50)::numeric;
        
        PERFORM insert_test_data_booking(_user_id, month_param || '-' || _day, round(_random_amount, 2), 'gift', 'cash', 'birthday');
        _inserted_rows := _inserted_rows + 1;
    END LOOP;

    FOR i IN 1..50 LOOP
        _day := floor(random() * 28) + 1;
        _random_amount := (random() * 14 + 1)::numeric;
        
        PERFORM insert_test_data_booking(_user_id, month_param || '-' || _day, round(_random_amount, 2), 'food', 'cash', 'food');
        _inserted_rows := _inserted_rows + 1;
    END LOOP;

    FOR i IN 1..2 LOOP
        _day := floor(random() * 28) + 1;
        _random_amount := (random() * (50 - 25) + 50)::numeric;
        
        PERFORM insert_test_data_booking(_user_id, month_param || '-' || _day, round(_random_amount, 2), 'eating out', 'cash', 'restaurant');
        _inserted_rows := _inserted_rows + 1;
    END LOOP;

    FOR i IN 1..5 LOOP
        _day := floor(random() * 28) + 1;
        _random_amount := (random() * (5 - 2) + 50)::numeric;
        
        PERFORM insert_test_data_booking(_user_id, month_param || '-' || _day, round(_random_amount, 2), 'other', 'cash', 'minor thing');
        _inserted_rows := _inserted_rows + 1;
    END LOOP;

    RETURN 'Inserted ' || _inserted_rows || ' rows into bookings table';
END;
$$ LANGUAGE plpgsql;
