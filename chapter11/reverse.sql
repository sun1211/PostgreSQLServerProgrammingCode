
CREATE OR REPLACE FUNCTION reverse(int[]) RETURNS int[]
AS $$
	my $arg = shift; # get the reference of the argument
	my @rev = reverse @{$arg}; # reverse the array
	return \@rev # return the array reference
$$ LANGUAGE plperl;