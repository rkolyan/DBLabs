--Получить список музыкальных групп, которые выпускали альбомы с 2000 по 2010 год(Предикат BETWEEN)
SELECT DISTINCT M.name,A.name,A.record_year
FROM albums A
JOIN musicians AS M ON M.musicians_id=A.musicians_id
WHERE A.record_year BETWEEN 2000 AND 2010;
