

DROP FUNCTION IF EXISTS insert_test_data_category;
CREATE OR REPLACE FUNCTION insert_test_data_category(
    _profile_name text,
    _name text,
    _category_type category_type,
    _icon_name text,
    _icon_code text
) RETURNS void AS $$
BEGIN
    WITH profile_data AS ( SELECT p.id AS profile_id FROM profiles p WHERE p.name = _profile_name)
        INSERT INTO categories (profile_id, name, type, icon_id, color_id)
        SELECT pd.profile_id, _name, _category_type,
        (SELECT id FROM category_icons WHERE name = _icon_name),
        (SELECT id FROM category_colors WHERE code = _icon_code) 
FROM profile_data pd;
END;
$$ LANGUAGE plpgsql;


DROP FUNCTION IF EXISTS insert_test_data_booking;
CREATE OR REPLACE FUNCTION insert_test_data_booking(
    _profile_id int,
    _date text,
    _amount numeric,
    _category_name text,
    _account_name text,
    _description text
) RETURNS void AS $$
BEGIN
    INSERT INTO bookings (profile_id, booking_date, amount, category_id, account_id, description)
    SELECT _profile_id, TO_TIMESTAMP(_date, 'YYYY-MM-DD'), _amount, c.id, a.id, _description
    FROM categories c
    JOIN accounts a ON a.name = _account_name AND a.profile_id = _profile_id
    WHERE c.name = _category_name AND c.profile_id = _profile_id;
END;
$$ LANGUAGE plpgsql;



DROP FUNCTION IF EXISTS insert_test_data_month;
CREATE OR REPLACE FUNCTION insert_test_data_month(name_param text, month_param text) 
RETURNS text AS $$
DECLARE
    _profile_id int;
    _inserted_rows integer := 0;
    _day integer;
    _random_amount numeric;
BEGIN
    SELECT p.id INTO _profile_id
    FROM profiles p WHERE p.name = name_param;

    PERFORM insert_test_data_booking(_profile_id, month_param || '-10', 2400, 'work', 'cash', 'salary');
    _inserted_rows := _inserted_rows + 1;

    IF random() < 0.5 THEN
        PERFORM insert_test_data_booking(_profile_id, month_param || '-14', 500, 'saving', 'cash', 'saved money');
        _inserted_rows := _inserted_rows + 1;
    END IF;

    PERFORM insert_test_data_booking(_profile_id, month_param || '-10', 800, 'house', 'cash', 'montly rent');
    _inserted_rows := _inserted_rows + 1;
    PERFORM insert_test_data_booking(_profile_id, month_param || '-11', 55.4, 'house', 'cash', 'heating costs');
    _inserted_rows := _inserted_rows + 1;
    PERFORM insert_test_data_booking(_profile_id, month_param || '-12', 94.21, 'house', 'cash', 'power costs');
    _inserted_rows := _inserted_rows + 1;

    PERFORM insert_test_data_booking(_profile_id, month_param || '-15', 112.12, 'car', 'cash', '12345678901234567890');
    _inserted_rows := _inserted_rows + 1;

    FOR i IN 1..3 LOOP
        _day := floor(random() * 28) + 1;
        _random_amount := (random() * (50 - 30) + 50)::numeric;
        
        PERFORM insert_test_data_booking(_profile_id, month_param || '-' || _day, round(_random_amount, 2), 'car', 'cash', 'gas');
        _inserted_rows := _inserted_rows + 1;
    END LOOP;

    FOR i IN 1..2 LOOP
        _day := floor(random() * 28) + 1;
        _random_amount := (random() * (10 - 5) + 50)::numeric;
        
        PERFORM insert_test_data_booking(_profile_id, month_param || '-' || _day, round(_random_amount, 2), 'baby', 'cash', 'diaper');
        _inserted_rows := _inserted_rows + 1;
        _random_amount := (random() * (12 - 6) + 50)::numeric;
        PERFORM insert_test_data_booking(_profile_id, month_param || '-' || _day, round(_random_amount, 2), 'baby', 'cash', 'cloth');
        _inserted_rows := _inserted_rows + 1;
    END LOOP;

    FOR i IN 1..2 LOOP
        _day := floor(random() * 28) + 1;
        _random_amount := (random() * (50 - 40) + 50)::numeric;
        
        PERFORM insert_test_data_booking(_profile_id, month_param || '-' || _day, round(_random_amount, 2), 'entertainment', 'cash', 'cinema');
        _inserted_rows := _inserted_rows + 1;
    END LOOP;

    FOR i IN 1..2 LOOP
        _day := floor(random() * 28) + 1;
        _random_amount := (random() * (30 - 20) + 50)::numeric;
        
        PERFORM insert_test_data_booking(_profile_id, month_param || '-' || _day, round(_random_amount, 2), 'gift', 'cash', 'birthday');
        _inserted_rows := _inserted_rows + 1;
    END LOOP;

    FOR i IN 1..50 LOOP
        _day := floor(random() * 28) + 1;
        _random_amount := (random() * 14 + 1)::numeric;
        
        PERFORM insert_test_data_booking(_profile_id, month_param || '-' || _day, round(_random_amount, 2), 'food', 'cash', 'food');
        _inserted_rows := _inserted_rows + 1;
    END LOOP;

    FOR i IN 1..2 LOOP
        _day := floor(random() * 28) + 1;
        _random_amount := (random() * (50 - 25) + 50)::numeric;
        
        PERFORM insert_test_data_booking(_profile_id, month_param || '-' || _day, round(_random_amount, 2), 'eating out', 'cash', 'restaurant');
        _inserted_rows := _inserted_rows + 1;
    END LOOP;

    FOR i IN 1..5 LOOP
        _day := floor(random() * 28) + 1;
        _random_amount := (random() * (5 - 2) + 50)::numeric;
        
        PERFORM insert_test_data_booking(_profile_id, month_param || '-' || _day, round(_random_amount, 2), 'other', 'cash', 'minor thing');
        _inserted_rows := _inserted_rows + 1;
    END LOOP;

    RETURN 'Inserted ' || _inserted_rows || ' rows into bookings table';
END;
$$ LANGUAGE plpgsql;
