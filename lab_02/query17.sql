--Добавить результаты подзапроса в таблицу
INSERT INTO albums
SELECT A.album_id+200,
	'Inserted', A.album_type, 2008, A.tracks_count,1,1,1
FROM albums A
WHERE A.record_year=2008;
