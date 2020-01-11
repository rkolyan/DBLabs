--Вывести список всех групп, чьих музыкальных жанров id больше 20(Предикат сравнения)
SELECT DISTINCT M.name,A.name
FROM albums A
JOIN genres AS G ON A.genre_id=G.genre_id
JOIN musicians AS M ON A.musicians_id=M.musicians_id
WHERE G.genre_id > 20;

