CREATE OR REPLACE FUNCTION notify_trigger_pltcl() RETURNS TRIGGER 
AS $$ 
	set result [format "Hi, I got %s invoked FOR %s %s %s on %s" $TG_name $TG_level $TG_when $TG_op $TG_table_name]
	if {$TG_op == "UPDATE"} { 
		append result [format " OLD = %s AND NEW=%s" $OLD(i) $NEW(i)]
			set NEW(i) [expr $OLD(i) + $NEW(i)]
			elog NOTICE $result			
			return [array get NEW]
		} elseif {$TG_op == "DELETE"} {
			elog NOTICE "DELETE"
			return SKIP
		}

	elog NOTICE $result
	return OK		
$$ LANGUAGE pltcl;

CREATE TABLE notify_test_pltcl(i int);

CREATE  TRIGGER notify_insert_pltcl_trigger
  BEFORE INSERT OR UPDATE OR DELETE ON notify_test_pltcl
  FOR EACH ROW
EXECUTE PROCEDURE notify_trigger_pltcl();