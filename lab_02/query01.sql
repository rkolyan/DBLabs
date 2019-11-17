--Вывести список всех групп, чьих музыкальных жанров id больше 20(Предикат сравнения)
SELECT DISTINCT M.name,A.name
FROM lab_01.albums A
JOIN lab_01.genres AS G ON A.genre_id=G.genre_id
JOIN lab_01.musicians AS M ON A.musicians_id=M.musicians_id
WHERE G.genre_id > 20;

