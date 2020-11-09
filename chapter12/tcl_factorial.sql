CREATE OR REPLACE FUNCTION tcl_factorial(integer) RETURNS integer
AS $$
	set i 1; set fact 1
	while {$i <= $1} {
		set fact [expr $fact * $i]
		incr i
	}
	return $fact
$$ LANGUAGE pltcl STRICT;