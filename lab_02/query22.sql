--(SELECT, используещее простое ОТВ)
WITH SOME_CTE(label_name, album_count)
AS
(
	SELECT L.name, COUNT(A.album_id)
	FROM lab_01.albums A
	JOIN lab_01.labels AS L ON L.label_id=A.label_id
	GROUP BY L.name
)
SELECT *
FROM SOME_CTE
ORDER BY album_count DESC;
