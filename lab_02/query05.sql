--Вывести весь список музыкальных групп, если нет группы с названием Pensix(Предикат EXISTS с вложенным подзапросом)
SELECT name
FROM musicians
WHERE NOT EXISTS 
(
	SELECT *
	FROM musicians
	WHERE name='Pensix'
);

