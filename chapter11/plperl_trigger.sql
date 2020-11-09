CREATE OR REPLACE FUNCTION notify_trigger_plperl() RETURNS TRIGGER 
AS $$ 
	$result = sprintf('Hi, I got %s invoked FOR %s %s %s on %s', 
                               $_TD->{name}, 
                               $_TD->{level}, 
                               $_TD->{when}, 
                               $_TD->{event}, 
                               $_TD->{table_name}
						);
		if(($_TD->{event} cmp 'UPDATE') == 0){
			$result .= sprintf(' OLD = %s AND NEW=%s', $_TD->{old}{i}, $_TD->{new}{i});
			$_TD->{new}{i} = $_TD->{old}{i} + $_TD->{new}{i};
			elog(NOTICE, $result);			
			return ;
		} elsif(($_TD->{event} cmp 'DELETE') == 0){
			elog(NOTICE, "Skipping Delete");
			return "SKIP";
		}


	elog(NOTICE, $result);
$$ LANGUAGE plperl;

CREATE TABLE notify_test_plperl(i int);

CREATE  TRIGGER notify_insert_plperl_trigger
  BEFORE INSERT OR UPDATE OR DELETE ON notify_test_plperl
  FOR EACH ROW
EXECUTE PROCEDURE notify_trigger_plperl();