CREATE TYPE some_type AS (f1 integer, f2 integer, f3 integer);

CREATE OR REPLACE FUNCTION return_select(integer, integer)
RETURNS SETOF some_type
AS
'$libdir/libfunctions','return_select'
LANGUAGE C IMMUTABLE STRICT;
