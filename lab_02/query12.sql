--Вывести список альбомов, которые...(вложенные коррелированные подзапросы в качестве
--производных таблиц в предложении FROM)
SELECT A.name, A.tracks_count, M.name
FROM albums A
JOIN musicians AS M ON A.musicians_id=M.musicians_id
WHERE record_year =
(
	SELECT MAX(record_year)
	FROM albums A1
	WHERE A1.album_type='SP'
);
