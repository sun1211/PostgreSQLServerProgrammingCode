CREATE OR REPLACE FUNCTION list_folder_plperl(directory VARCHAR) RETURNS SETOF TEXT
AS $$
	my $d = shift;
	opendir(D, "$d") || elog (ERROR,'Cant open directory '.$d) ;
	my @list = readdir(D);
	closedir(D);

	foreach my $f (@list) {
	return_next($f);
	}
	return undef;
$$ LANGUAGE plperl;
