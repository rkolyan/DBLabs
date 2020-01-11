TABLE persons;
TABLE holiday_types;
TABLE holidays;

--Сам запрос(нужны данные)
SELECT row_number() over (order by T5.begin_data) as id,
P.fio, T5.begin_data, T5.end_data, HT.htype as holiday_type
FROM
(
	SELECT * 
	FROM
	(
		SELECT pid, hid, --Определяем первое число и последнее число
		CASE 
			WHEN previous IS NULL THEN hdate
			ELSE next
		END AS begin_data,
		CASE
			WHEN previous IS NULL and next2 IS NULL then hdate
			ELSE next2
		END AS end_data
		FROM 
		(
				SELECT *, --Добавляем новую следующую дату, (next2)
				lead(hdate) over(partition by pid, hid order by hdate) as next2
				FROM
				(
					SELECT * --Оставляем только где есть null и разность дней > 1
					FROM
					(
						SELECT pid, hid, hdate, --Находим для каждого числа следующее и предыдущее
						lead(hdate) over (partition by pid, hid order by hdate) as next,
						lag(hdate) over (partition by pid, hid order by hdate) as previous
						FROM holidays
					) AS T1
					GROUP BY pid, hid, hdate, next, previous
					HAVING next - hdate > 1 OR next IS NULL OR previous IS NULL
				) AS T2
		) AS T3
	) AS T4
	WHERE begin_data IS NOT NULL
) AS T5
JOIN holiday_types AS HT ON T5.hid=HT.id
JOIN persons AS P ON T5.pid=P.id
ORDER BY begin_data;

				SELECT *, --Добавляем новую следующую дату, (next2)
				lead(hdate) over(partition by pid, hid order by hdate) as next2
				FROM
				(
					SELECT * --Оставляем только где есть null и разность дней > 1
					FROM
					(
						SELECT pid, hid, hdate, --Находим для каждого числа следующее и предыдущее
						lead(hdate) over (partition by pid, hid order by hdate) as next,
						lag(hdate) over (partition by pid, hid order by hdate) as previous
						FROM holidays
					) AS T1
					GROUP BY pid, hid, hdate, next, previous
					HAVING next - hdate > 1 OR next IS NULL OR previous IS NULL
				) AS T2;
