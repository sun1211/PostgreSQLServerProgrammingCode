CREATE OR REPLACE FUNCTION list_directory(text) RETURNS text
AS $$
	set dirList [glob -nocomplain -directory $1 *]
	return $dirList
$$ LANGUAGE pltclu;