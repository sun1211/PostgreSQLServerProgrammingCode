
CREATE OR REPLACE FUNCTION read_file(text) RETURNS text
AS $$
	set f [open $1]
	set file_data [read $f]
	close $f
	return $file_data
$$ LANGUAGE pltclu;