CREATE TYPE some_type AS (f1 integer, f2 integer, f3 integer);

DROP FUNCTION IF EXISTS return_select;

CREATE OR REPLACE FUNCTION return_select(integer, integer)
RETURNS TABLE (f1 INT, f2 INT, f3 INT)
AS
'$libdir/libfunctions','return_select'
LANGUAGE C IMMUTABLE STRICT;
