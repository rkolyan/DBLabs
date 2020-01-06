--Вывести список групп и приблизительный год их появления(Простое выражение CASE)
SELECT name,
	CASE birthyear
		WHEN 2019 THEN 'This year'
		WHEN 2020 THEN 'Next year'
		ELSE 'Previous years'
	END AS "When musicians born"
FROM musicians;
