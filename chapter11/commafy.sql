CREATE OR REPLACE FUNCTION commafy (integer) RETURNS text 
AS $$
	local $_  = shift;
	1 while s/^([-+]?\d+)(\d{3})/$1,$2/;
	return $_;
$$ LANGUAGE plperl;