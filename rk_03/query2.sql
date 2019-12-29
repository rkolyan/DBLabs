SELECT AVG(EB.birthdate)
FROM 
(
	SELECT ES.employer_id, age(E2.ddate, E1.birthdate)
	FROM (
		SELECT * 
		FROM 
		(
			SELECT *, time EE1.ttime - time EE2.ttime AS deltatime
			FROM 
			(
				SELECT * FROM enterexit WHERE ttype = 1
			) AS EE2
			JOIN
			(
				SELECT * FROM enterexit WHERE ttype = 2
			) AS EE1
			ON EE1.employer_id = EE2.employer_id
		) AS ES
		WHERE deltatime < time '8:00'
	) AS E1
	JOIN enterexit AS E2 ON E1.employer_id = E2.employer_id
) AS EB
JOIN employers AS EX ON EX.employer_id = EB.employer_id
GROUP BY EB.employer_id;
