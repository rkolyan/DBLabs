--Вывести весь список музыкальных групп, если нет группы с названием Pensix(Предикат EXISTS с вложенным подзапросом)
SELECT name
FROM lab_01.musicians
WHERE NOT EXISTS 
(
	SELECT *
	FROM lab_01.musicians
	WHERE name='Pensix'
);

