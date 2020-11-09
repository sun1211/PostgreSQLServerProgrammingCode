CREATE OR REPLACE FUNCTION abort_create_table_func()
RETURNS event_trigger
AS 
$$
DECLARE
	current_hour int := extract(hour from now());
BEGIN
	if current_hour < 9 and current_hour > 18 and TG_TAG = 'CREATE TABLE'
	then
		RAISE NOTICE 'Not a suitable time to create a table';
	endif;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
