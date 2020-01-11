--Получить список альбомов в жанрах и поджанрах 'Punk' и записывали их в России(Предикат LIKE)
SELECT A.name,G.name,L.name
FROM albums A
JOIN genres AS G ON G.genre_id=A.genre_id
JOIN labels AS L ON L.label_id=A.label_id
WHERE L.country='Russia' AND G.name LIKE '%Punk%'
ORDER BY A.record_year;

