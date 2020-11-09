CREATE TABLE orders(orderid int, num_people integer, order_amount decimal);

INSERT INTO orders VALUES(1,1,23);
INSERT INTO orders VALUES(2,3,157);
INSERT INTO orders VALUES(3,5,567.25);
INSERT INTO orders VALUES(4,1,100);

CREATE OR REPLACE FUNCTION tip_calculator(orders, integer) RETURNS decimal
AS $$
	if {$1(order_amount) > 0} {
		set tip [expr (double($1(order_amount) * $2)/100)/$1(num_people)]
		set tip [format "%.2f" $tip]
		return $tip
	}
	return 0;
$$ LANGUAGE pltcl;