CREATE TABLE emp_sales(empid int PRIMARY KEY, sales_amnt decimal, comm_perc decimal, comm_amnt decimal);

INSERT INTO emp_sales VALUES (1,32000, 5, NULL);
INSERT INTO emp_sales VALUES (2,5231.23, 3, NULL);
INSERT INTO emp_sales VALUES (3,64890, 7.5, NULL);


CREATE OR REPLACE FUNCTION tcl_calc_comm() RETURNS int 
AS $$
	spi_exec -array C "SELECT * FROM emp_sales" {
		set camnt [ expr ($C(sales_amnt) * $C(comm_perc))/100 ]
    	spi_exec "update emp_sales
    		set comm_amnt = [format "%.2f" $camnt]
    		where empid = $C(empid)"
}
$$ LANGUAGE pltcl;