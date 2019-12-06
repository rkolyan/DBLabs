--Пользовательский тип данных
DROP TABLE IF EXISTS some_table;
DROP FUNCTION IF EXISTS merge_info_input CASCADE;
DROP FUNCTION IF EXISTS merge_info_output CASCADE ;

DROP TYPE IF EXISTS merge_info CASCADE;

CREATE TYPE merge_info;

CREATE OR REPLACE FUNCTION merge_info_input(cstring)
RETURNS merge_info
AS '$libdir/libfunctions','merge_info_input'
LANGUAGE C IMMUTABLE STRICT;

CREATE OR REPLACE FUNCTION merge_info_output(merge_info)
RETURNS cstring
AS '$libdir/libfunctions','merge_info_output'
LANGUAGE C IMMUTABLE STRICT;

CREATE TYPE merge_info 
(
	internallength = 12,
	input = merge_info_input,
	output = merge_info_output
);

CREATE TABLE some_table (
	some_info merge_info,
	num int
);

INSERT INTO some_table VALUES ('(10, 10, 11)', 10);
INSERT INTO some_table VALUES ('(50, 0, 20)', 2);
