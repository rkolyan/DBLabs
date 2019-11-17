--Вывести распавшиеся группы с кол-вом альбомов, которые они выпустили(SELECT c GROUP BY и HAVING)
SELECT M.name, COUNT(A.album_id)
FROM lab_01.albums A
JOIN lab_01.musicians AS M ON A.musicians_id=M.musicians_id
WHERE CAST(M.is_dead AS INT) = 1
GROUP BY M.name, M.birthyear
HAVING M.birthyear < CAST(AVG(A.record_year) AS INT);
