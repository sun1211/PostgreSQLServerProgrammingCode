CREATE OR REPLACE FUNCTION tcl_array_test(integer[]) RETURNS int
AS $$
	set length [string length $1]
    return $length
$$ LANGUAGE pltcl;

CREATE OR REPLACE FUNCTION tcl_reverse_array(integer[]) RETURNS integer[]
AS $$
	set lst [regexp -all -inline {[0-9]} $1]
	set lst [join [lreverse $lst] ","]
	set lst  "{$lst}"
	return $lst
$$ LANGUAGE pltcl;