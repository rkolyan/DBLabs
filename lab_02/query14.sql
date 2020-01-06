--Вывести названия жанров и кол-во их альбомов, которые вышли в 1994 году(SELECT с GROUP BY, но без HAVING)
SELECT G.name AS "Genre name", COUNT(*) AS "Count of albums"
FROM albums A
JOIN genres AS G ON G.genre_id=A.genre_id
WHERE A.record_year=1998
GROUP BY G.name;


