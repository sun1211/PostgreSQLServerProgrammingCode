CREATE TABLE track_ddl
(
  event text, 
  command text, 
  ddl_time timestamp, 
  usr text
);

CREATE OR REPLACE FUNCTION track_ddl_function()
RETURNS event_trigger
AS
$$
BEGIN
  INSERT INTO track_ddl values(tg_tag, tg_event, now(), session_user);
  RAISE NOTICE 'DDL logged';
END
$$ LANGUAGE plpgsql;

CREATE EVENT TRIGGER track_ddl_event ON ddl_command_start
WHEN TAG IN ('CREATE TABLE', 'DROP TABLE', 'ALTER TABLE')
EXECUTE PROCEDURE track_ddl_function();