CREATE OPERATOR ## (PROCEDURE=fib, LEFTARG=integer);

CREATE OPERATOR ## (PROCEDURE=fib, RIGHTARG=integer);


CREATE FUNCTION _final_median(anyarray) RETURNS float8 AS $$ 
  WITH q AS
  (
     SELECT val
     FROM unnest($1) val
     WHERE VAL IS NOT NULL
     ORDER BY 1
  ),
  cnt AS
  (
    SELECT COUNT(*) AS c FROM q
  )
  SELECT AVG(val)::float8
  FROM 
  (
    SELECT val FROM q
    LIMIT  2 - MOD((SELECT c FROM cnt), 2)
    OFFSET GREATEST(CEIL((SELECT c FROM cnt) / 2.0) - 1,0)  
  ) q2;
$$ LANGUAGE sql IMMUTABLE;

CREATE AGGREGATE median(anyelement) (
  SFUNC=array_append,
  STYPE=anyarray,
  FINALFUNC=_final_median,
  INITCOND='{}'
);

CREATE TABLE median_text(t integer);
INSERT INTO median_test VALUES(1);
INSERT INTO median_test VALUES(2);
INSERT INTO median_test VALUES(3);
INSERT INTO median_test VALUES(4);
INSERT INTO median_test VALUES(5);
INSERT INTO median_test VALUES(6);
INSERT INTO median_test VALUES(7);
INSERT INTO median_test VALUES(8);
INSERT INTO median_test VALUES(9);
INSERT INTO median_test VALUES(10);

CREATE FUNCTION final_median_arr(anyarray) RETURNS float8 AS $$ 
  WITH q AS
  (
     SELECT val
     FROM unnest($1) val
     WHERE VAL IS NOT NULL
     ORDER BY 1
  ),
  cnt AS
  (
    SELECT COUNT(*) AS c FROM q
  )
  SELECT AVG(val)::float8
  FROM 
  (
    SELECT val FROM q
    LIMIT  2 - MOD((SELECT c FROM cnt), 2)
    OFFSET GREATEST(CEIL((SELECT c FROM cnt) / 2.0) - 1,0)  
  ) q2;
$$ LANGUAGE sql IMMUTABLE;

CREATE TABLE test_ssn (ssn text);
 
INSERT INTO test_ssn VALUES ('222-11-020878');
INSERT INTO test_ssn VALUES ('111-11-020978');


CREATE OR REPLACE FUNCTION fix_ssn(text)
 RETURNS text AS $$
 BEGIN
 
        RETURN substring($1,8) || replace(substring($1,1,7),'-','');
 
END; 
$$LANGUAGE 'plpgsql' IMMUTABLE;

CREATE OR REPLACE FUNCTION ssn_compareTo(text, text)
RETURNS int AS
$$
 BEGIN
	IF fix_ssn($1) < fix_ssn($2)
    THEN
    	RETURN -1;
	ELSIF fix_ssn($1) > fix_ssn($2)
    THEN
    	RETURN +1;
   	ELSE
   		RETURN 0;
 	END IF;
 
END;
$$ LANGUAGE 'plpgsql' IMMUTABLE;

CREATE OPERATOR CLASS ssn_ops
FOR TYPE text USING btree
AS
OPERATOR        1       <  ,
OPERATOR        2       <= ,
OPERATOR        3       =  ,
OPERATOR        4       >= ,
OPERATOR        5       >  ,
FUNCTION        1       si_same(text, text);

CREATE FUNCTION _final_median(anyarray) RETURNS float8 AS $$ 
  WITH q AS
  (
     SELECT val
     FROM unnest($1) val
     WHERE VAL IS NOT NULL
     ORDER BY 1
  ),
  cnt AS
  (
    SELECT COUNT(*) AS c FROM q
  )
  SELECT AVG(val)::float8
  FROM 
  (
    SELECT val FROM q
    LIMIT  2 - MOD((SELECT c FROM cnt), 2)
    OFFSET GREATEST(CEIL((SELECT c FROM cnt) / 2.0) - 1,0)  
  ) q2;
$$ LANGUAGE sql IMMUTABLE;

CREATE AGGREGATE median(anyelement) (
  SFUNC=array_append,
  STYPE=anyarray,
  FINALFUNC=_final_median,
  INITCOND='{}'
);

CREATE TABLE median_test(t integer);

INSERT INTO median_test SELECT generate_series(1,10);

CREATE EXTENSION file_fdw;
CREATE SERVER file_server FOREIGN DATA WRAPPER file_fdw;

CREATE FOREIGN TABLE employee (
  emp_name  VARCHAR,
  job_title   VARCHAR,
  dept    VARCHAR,
  salary    INTEGER,
  sal_after_tax INTEGER
) SERVER file_server
OPTIONS (format 'csv',header 'false' , filename '/home/pgbook/14/testdata.csv', delimiter '|', null ''); 


