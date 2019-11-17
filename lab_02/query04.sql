--Получить список музыкальных групп из предыдущего запроса(Предикат IN c вложенным подзапросом)
SELECT * 
FROM lab_01.musicians M1
WHERE M1.musicians_id IN
(
	SELECT A.musicians_id      
	FROM lab_01.albums A
	JOIN lab_01.genres AS G ON G.genre_id=A.genre_id
	JOIN lab_01.labels AS L ON L.label_id=A.label_id
	WHERE L.country='Russia' AND G.name LIKE '%Punk%'
	ORDER BY A.record_year
);

