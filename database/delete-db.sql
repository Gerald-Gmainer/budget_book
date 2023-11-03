
DROP VIEW view_bookings;
DROP VIEW view_categories;
DROP VIEW view_category_icons;
DROP VIEW view_category_colors;
DROP VIEW view_account_icons;
DROP VIEW view_account_colors;
DROP VIEW view_currencies;
DROP VIEW view_profiles;
DROP VIEW view_profile_settings;
DROP VIEW view_accounts;

DROP TABLE bookings CASCADE;
DROP TABLE categories;
DROP TABLE accounts;
DROP TABLE profile_settings;
DROP TABLE profiles;

DROP TABLE currencies;
DROP TABLE category_colors;
DROP TABLE category_icons;
DROP TABLE account_colors;
DROP TABLE account_icons;

DROP FUNCTION create_booking;
DROP FUNCTION create_category;
DROP FUNCTION get_default_currency;
DROP FUNCTION delete_profile;
DROP FUNCTION setup_profile;
DROP FUNCTION refresh_mat_view_suggestions;
