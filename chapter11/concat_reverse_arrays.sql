CREATE OR REPLACE FUNCTION concat_reverse_arrays(int[], int[]) RETURNS int[] 
AS $$
	my $arr1 = $_[0];
	my $arr2 = $_[1];

	push(@{$arr1}, @{$arr2});

	my @reverse = reverse @{$arr1};
	return \@reverse;
$$ LANGUAGE plperl;