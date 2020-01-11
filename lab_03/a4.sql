--Рекурсивная функция или функция с рекурсивным обобщенным табличным выражением
CREATE OR REPLACE FUNCTION show_albums()
RETURNS TABLE (album_index INT, album_name VARCHAR(200))
AS $$
	WITH RECURSIVE my_cte
	AS 
	(
		SELECT 
			1 AS i,
			(SELECT name
			FROM albums
			LIMIT 1)
		UNION ALL
		SELECT 
			i+1 AS i,
			(SELECT name
			FROM albums
			LIMIT 1
			OFFSET i)
		FROM my_cte
		WHERE i <
		(
			SELECT COUNT(*)
			FROM albums
		)
	)
	SELECT *
	FROM my_cte
$$ LANGUAGE SQL;
