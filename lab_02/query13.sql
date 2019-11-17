--(вложенные подзапросы с уровнем вложенности 3)
SELECT DISTINCT A.name, M.people_count, A.tracks_count, A.album_type
FROM lab_01.albums A
JOIN lab_01.musicians AS M ON A.musicians_id=M.musicians_id
WHERE M.people_count = 
(
	SELECT CAST(AVG(people_count) + 2 AS INT)
	FROM lab_01.musicians M1
	WHERE M1.musicians_id BETWEEN 
	(
		SELECT CAST(MAX(M2.musicians_id)/2 AS INT)
		FROM lab_01.musicians M2
		--JOIN lab_01.albums AS A2 ON A2.musicians_id=M2.musicians_id
		--JOIN lab_01.genres AS G2 ON G2.genre_id=A2.genre_id
		WHERE M2.country = 
		(
			SELECT L3.country
			FROM lab_01.labels L3
			WHERE L3.label_id = 1
		)
	)
	AND
	(
		SELECT MAX(musicians_id)
		FROM lab_01.musicians	
	)
);

