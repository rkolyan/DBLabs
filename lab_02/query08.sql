--Вывести (скалярные подзапросы в выражениях столбцов)
SELECT musicians_id, 
	name,
	(
		SELECT COUNT(album_id)
		FROM albums A
		WHERE A.musicians_id=lab_01.musicians.musicians_id
	) AS "Albums Count",
	people_count
FROM musicians
ORDER BY musicians_id;
