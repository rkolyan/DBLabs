--Хранимая процедура без параметров или с параметрами
CREATE OR REPLACE PROCEDURE add_new_album
(
	album_name VARCHAR(200), 
	album_type VARCHAR(3), 
	record_year INT,
	tracks_count INT, 
	group_name VARCHAR(150),
	label_name VARCHAR(150),
	genre_name VARCHAR(150)
)
AS $$
	INSERT INTO lab_01.albums
	VALUES
	(
		(SELECT MAX(album_id)+1 FROM lab_01.albums),
		$1,
		$2,
		$3,
		$4,
		(SELECT musicians_id FROM lab_01.musicians M WHERE M.name=$5),
		(SELECT label_id FROM lab_01.labels L WHERE L.name=$6),
		(SELECT genre_id FROM lab_01.genres G WHERE G.name=$7)
	)
$$ LANGUAGE SQL;
