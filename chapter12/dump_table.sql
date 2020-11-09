CREATE OR REPLACE FUNCTION dump_table(text, text) RETURNS int
AS $$
	set filename $1
    set fileId [open $filename "w"]
	spi_exec -array emp "SELECT * FROM $2" {
		set row [format "%d,%.2f,%.2f,%.2f" $emp(empid) $emp(sales_amnt) $emp(comm_perc) $emp(comm_amnt)]
        puts $fileId $row
    }
    close $fileId
    return 0;
 $$ LANGUAGE pltclu STRICT;