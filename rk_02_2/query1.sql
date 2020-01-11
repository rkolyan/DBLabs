SELECT *
FROM subjects
WHERE rating > ALL
(
	SELECT rating
	WHERE subject_id < 5
);
