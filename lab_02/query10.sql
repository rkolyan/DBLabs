--Вывести музыкантов, чье кол-во альбомов =0 >0 >2 >4 c соответствующими сообщениями(Поисковое выражение CASE)
SELECT M1.name,
	CASE
		WHEN albums_count=0 THEN 'There is no one album'
		WHEN albums_count<3 THEN 'There are 1-2 albums'
		WHEN albums_count<5 THEN 'There are 3-4 albums'
		ELSE 'There are more than 4 albums '
	END AS track_har_count
FROM 
(
	SELECT M2.name, COUNT(*) AS albums_count
	FROM lab_01.albums A
	JOIN lab_01.musicians AS M2 ON M2.musicians_id=A.musicians_id
	GROUP BY M2.name
) AS M1;
