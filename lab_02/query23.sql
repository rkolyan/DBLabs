--Вывести список альбомов с их номерами в таблице(SELECT, использующее рекурсивное ОТВ)
SELECT * 
FROM albums;
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
FROM my_cte;
