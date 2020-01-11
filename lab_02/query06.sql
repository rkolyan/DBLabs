--Вывести список всех групп, у которых есть альбомы в стиле Retrowave и кол-во музыкантов > 3(Предикат сравнения с квантором)
WITH MyOTV (name, people_count, country)
AS
(
	SELECT DISTINCT M.name, M.people_count, M.country
	FROM albums A
	JOIN genres AS G ON A.genre_id=G.genre_id
	JOIN musicians AS M ON A.musicians_id=M.musicians_id
	WHERE G.name='Retrowave'
)
SELECT *
FROM MyOTV
WHERE people_count > ALL
(
	SELECT people_count
	FROM MyOTV
	WHERE people_count=2
);

