CREATE OR REPLACE FUNCTION find_index_information_about_table(tablename text)
RETURNS SETOF RECORD
AS $$
select P.relname, M.* 
from pg_index as M 
join pg_class as P on P.oid = M.indrelid
WHERE P.relname = $1;
$$ LANGUAGE SQL;

select find_index_information_about_table('musicians');
