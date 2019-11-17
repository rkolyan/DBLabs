--(Оконные функции)
SELECT DISTINCT M.name, M.people_count,
	CAST(AVG(A.record_year) OVER(PARTITION BY M.name) AS INT) AS "Average Record Year",
	MIN(A.record_year) OVER(PARTITION BY M.name) AS "First Album Record Year",
	MAX(A.record_year) OVER(PARTITION BY M.name) AS "Last Album Record Year"
FROM lab_01.albums A
JOIN lab_01.musicians AS M ON M.musicians_id=A.musicians_id;
