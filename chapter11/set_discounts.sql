CREATE OR REPLACE FUNCTION set_dicounts() RETURNS SETOF item
AS $$
	my $rv = spi_exec_query('select * from item;');
    my $nrows = $rv->{processed};
    foreach my $rn (0 .. $nrows - 1) {
        my $item = $rv->{rows}[$rn];
		if ($item->{item_price} >= 1000) {
			$item->{discount} = 10; 
		} else {
			$item->{discount} = 5; 	
		}
        return_next($item);
    }
    return undef;
$$ LANGUAGE plperl;