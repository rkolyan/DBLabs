CREATE TYPE some_type AS (f1 integer, f2 integer, f3 integer);

DROP FUNCTION IF EXISTS return_select;

CREATE OR REPLACE FUNCTION return_select(integer, integer)
RETURNS TABLE (f1 INT, f2 INT, f3 INT)
AS
'$libdir/libfunctions','return_select'
LANGUAGE C IMMUTABLE STRICT;

CREATE EXTENSION plpython3u;

DROP FUNCTION IF EXISTS return_python_select;

CREATE OR REPLACE FUNCTION return_python_select()
RETURNS TABLE (year_name text, album_year INT, album_count INT)
AS $$
rows = plpy.execute("SELECT * FROM lab_01.albums");
if (rows is None):
	return None;
min_year = int(rows[0]['record_year']);
max_year = min_year;
for i in range(1, len(rows)):
	min_year = min(int(rows[i]["record_year"]), min_year);
	max_year = max(int(rows[i]["record_year"]), max_year);
max_count = 0;
maxc_year = min_year;
for year in range(min_year, max_year + 1):
	count = 0;
	for i in range(len(rows)):
		if (int(rows[i]["record_year"]) == year):
			count += 1;
	if (count > max_count):
		maxc_year = year;
		max_count = count;
min_count = max_count;
minc_year = min_year;
for year in range(min_year, max_year + 1):
	count = 0;
	for i in range(len(rows)):
		if (int(rows[i]["record_year"]) == year):
			count += 1;
	if (count < min_count):
		minc_year = year;
		min_count = count;
return (["The Wrongest Year", minc_year, min_count], ["The Best Year", maxc_year, max_count]);
$$ LANGUAGE plpython3u;
