CREATE OR REPLACE FUNCTION(late_time time)
RETURNS INT
AS $body$
	SELECT COUNT(*) 
	FROM (
		SELECT employer_id
		FROM enterexit
		WHERE ttime > late_time
		GROUP BY employer_id
	);
$body$ LANGUAGE SQL
