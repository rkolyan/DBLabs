--Вывести среднее значение появления группы, кол-во человек, кол-во групп (агрегатные функции в выражениях столбцов)
SELECT CAST(AVG(birthyear) AS INT) AS "Average birth year", 
	SUM(people_count) AS "Count of all people", 
	COUNT(musicians_id) AS "Count of all groups",
	3 AS "What does god love?"
FROM lab_01.musicians;
