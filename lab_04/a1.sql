CREATE OR REPLACE FUNCTION find_string_length(string VARCHAR(150))
RETURNS INT
AS
'$libdir/libfunctions','find_string_length'
LANGUAGE C STRICT;
