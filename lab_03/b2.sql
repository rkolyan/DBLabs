--Рекурсивная хранимая процедура или хранимая процедура с рекурсивным ОТВ
DROP TABLE IF EXISTS tmp_tab;
CREATE TEMP TABLE "tmp_tab"
(
	album_id INT,
	name VARCHAR(200),
	album_type VARCHAR(3),
	record_year INT,
	tracks_count INT,
	musicians_id INT,
	label_id INT,
	genre_id INT
);

CREATE OR REPLACE PROCEDURE create_new_album_tablice()
AS $$
	TRUNCATE TABLE tmp_tab RESTART IDENTITY;
	WITH RECURSIVE my_cte(my_index, name, album_type, record_year, tracks_count, musicians_id, label_id, genre_id)
	AS 
	(
		SELECT 
			1 AS i,
			(SELECT name 
			FROM lab_01.albums
			LIMIT 1), 
			(SELECT album_type 
			FROM lab_01.albums
			LIMIT 1), 
			(SELECT record_year
			FROM lab_01.albums
			LIMIT 1), 
			(SELECT tracks_count
			FROM lab_01.albums
			LIMIT 1), 
			(SELECT musicians_id
			FROM lab_01.albums
			LIMIT 1), 
			(SELECT label_id
			FROM lab_01.albums
			LIMIT 1), 
			(SELECT genre_id
			FROM lab_01.albums
			LIMIT 1) 
		UNION ALL
		SELECT 
			my_index+1 AS my_index,
			(SELECT name 
			FROM lab_01.albums
			LIMIT 1
			OFFSET my_index), 
			(SELECT album_type 
			FROM lab_01.albums
			LIMIT 1
			OFFSET my_index), 
			(SELECT record_year
			FROM lab_01.albums
			LIMIT 1
			OFFSET my_index), 
			(SELECT tracks_count
			FROM lab_01.albums
			LIMIT 1
			OFFSET my_index), 
			(SELECT musicians_id
			FROM lab_01.albums
			LIMIT 1
			OFFSET my_index), 
			(SELECT label_id
			FROM lab_01.albums
			LIMIT 1
			OFFSET my_index), 
			(SELECT genre_id
			FROM lab_01.albums
			LIMIT 1
			OFFSET my_index) 
		FROM my_cte
		WHERE my_index <
		(
			SELECT COUNT(*)
			FROM lab_01.albums
		)
	)
	INSERT INTO tmp_tab
	(
		SELECT *
		FROM my_cte
	);
$$ LANGUAGE SQL;
