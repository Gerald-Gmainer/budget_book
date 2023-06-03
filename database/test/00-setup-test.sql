begin;
select plan( 1 );

select has_table( 'profiles' );

select * from finish();
rollback;