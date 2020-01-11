CREATE OR REPLACE FUNCTION find_all_like_constraints()
RETURNS RECORD
AS $$
	select * from pg_constraint
	where pg_get_constraintdef(oid) like '%~~%';
$$ LANGUAGE SQL;

CREATE OR REPLACE FUNCTION find_all_tablices_with_like_constraints()
RETURNS SETOF RECORD
AS $$
	select N.relname
	from (
		select * from 
		(
			select pg_get_constraintdef(oid) as result, conrelid from pg_constraint
		) as tmp
	   	where result like '%~~%'
	) AS M
	JOIN pg_class AS N on M.conrelid=N.oid;
$$ LANGUAGE SQL;

select find_all_tablices_with_like_constraints();
