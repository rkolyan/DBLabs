--TODO:Рекурсивная хранимая процедура или хранимая процедура с рекурсивным ОТВ
CREATE OR REPLACE PROCEDURE update_album_ids()
AS $$
	WITH RECURSIVE my_cte(my_index)
	AS 
	(
		SELECT 
			1 AS i
		UNION ALL
		SELECT 
			i+1 AS i,
		FROM my_cte
		WHERE i <
		(
			SELECT COUNT(*)
			FROM lab_01.albums
		)
	)
	UPDATE lab_01.albums AS A
	SET A.album_id = 
	(
		WITH tmp(minimum)
		AS
		(
			SELECT MIN(my_index)
			FROM my_cte
		)
		DELETE FROM my_cte
		WHERE my_cte.my_index = tmp.minimum
		RETURNING my_cte.my_index
	)
$$ LANGUAGE SQL;
