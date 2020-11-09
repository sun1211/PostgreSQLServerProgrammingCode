
CREATE OR REPLACE FUNCTION tcl_factorial_ns(integer) RETURNS integer
AS $$
   if {[argisnull 1]} {
   		elog NOTICE "input is null"
        return -1
    } 
	set i 1; set fact 1
	while {$i <= $1} {
		set fact [expr $fact * $i]
		incr i
	}
	return $fact
$$ LANGUAGE pltcl