--Удалить все 'Metal' альбомы (DELETE с вложенным подзапросом)
DELETE FROM lab_01.albums AS A
WHERE A.genre_id IN
(
	SELECT A.genre_id
	FROM lab_01.albums A
	JOIN lab_01.genres AS G ON A.genre_id=G.genre_id
	WHERE G.name LIKE '%Metal'
);
