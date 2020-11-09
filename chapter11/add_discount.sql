CREATE TABLE item (item_name varchar, item_price int, discount int);

INSERT INTO item(item_name, item_price) VALUES('macbook',1200);
INSERT INTO item(item_name, item_price) VALUES('pen',5);
INSERT INTO item(item_name, item_price) VALUES('fridge',1000);

CREATE OR REPLACE FUNCTION add_discount(item) RETURNS item
AS $$
	my $item = shift;
	if ($item->{item_price} >= 1000) {
		$item->{discount} = 10; 
	} else {
		$item->{discount} = 5; 	
	}

	return $item;
$$ LANGUAGE plperl;