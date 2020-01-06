--Удалить все 'Metal' альбомы (DELETE с вложенным подзапросом)
DELETE FROM albums AS A
WHERE A.genre_id IN
(
	SELECT A.genre_id
	FROM albums A
	JOIN genres AS G ON A.genre_id=G.genre_id
	WHERE G.name LIKE '%Metal'
);
