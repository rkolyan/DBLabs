--Вывести список всех групп, чьих музыкальных жанров id больше 20(Предикат сравнения)
SELECT DISTINCT M.name,A.name
FROM lab_01.albums A
JOIN lab_01.genres AS G ON A.genre_id=G.genre_id
JOIN lab_01.musicians AS M ON A.musicians_id=M.musicians_id
WHERE G.genre_id > 20;

--Получить список музыкальных групп, которые выпускали альбомы с 2000 по 2010 год(Предикат BETWEEN)
SELECT DISTINCT M.name,A.name,A.record_year
FROM lab_01.albums A
JOIN lab_01.musicians AS M ON M.musicians_id=A.musicians_id
WHERE A.record_year BETWEEN 2000 AND 2010;

--Получить список альбомов в жанрах и поджанрах 'Punk' и записывали их в России(Предикат LIKE)
SELECT A.name,G.name,L.name
FROM lab_01.albums A
JOIN lab_01.genres AS G ON G.genre_id=A.genre_id
JOIN lab_01.labels AS L ON L.label_id=A.label_id
WHERE L.country='Russia' AND G.name LIKE '%Punk%'
ORDER BY A.record_year;

--Получить список музыкальных групп из предыдущего запроса(Предикат IN c вложенным подзапросом)
SELECT * 
FROM lab_01.musicians M1
WHERE M1.musicians_id IN
(
	SELECT A.musicians_id      
	FROM lab_01.albums A
	JOIN lab_01.genres AS G ON G.genre_id=A.genre_id
	JOIN lab_01.labels AS L ON L.label_id=A.label_id
	WHERE L.country='Russia' AND G.name LIKE '%Punk%'
	ORDER BY A.record_year
);

--Вывести весь список музыкальных групп, если нет группы с названием Pensix(Предикат EXISTS с вложенным подзапросом)
SELECT name
FROM lab_01.musicians
WHERE NOT EXISTS 
(
	SELECT *
	FROM lab_01.musicians
	WHERE name='Pensix'
);

--Вывести список всех групп, у которых есть альбомы в стиле Retrowave и кол-во музыкантов > 3(Предикат сравнения с квантором)
WITH MyOTV (name, people_count, country)
AS
(
	SELECT DISTINCT M.name, M.people_count, M.country
	FROM lab_01.albums A
	JOIN lab_01.genres AS G ON A.genre_id=G.genre_id
	JOIN lab_01.musicians AS M ON A.musicians_id=M.musicians_id
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

--Вывести среднее значение появления группы, кол-во человек, кол-во групп (агрегатные функции в выражениях столбцов)
SELECT CAST(AVG(birthyear) AS INT) AS "Average birth year", 
	SUM(people_count) AS "Count of all people", 
	COUNT(musicians_id) AS "Count of all groups",
	3 AS "What does god love?"
FROM lab_01.musicians;

--Вывести (скалярные подзапросы в выражениях столбцов)
SELECT musicians_id, 
	name,
	(
		SELECT COUNT(album_id)
		FROM lab_01.albums A
		WHERE A.musicians_id=lab_01.musicians.musicians_id
	) AS "Albums Count",
	people_count
FROM lab_01.musicians
ORDER BY musicians_id;

--Объединение два предыдущих запросов TODO:Fix union, please
SELECT A.name,G.name,L.name
FROM lab_01.albums A
JOIN lab_01.genres AS G ON G.genre_id=A.genre_id
JOIN lab_01.labels AS L ON L.label_id=A.label_id
WHERE L.country='Russia' AND G.name LIKE '%Punk%'
ORDER BY A.record_year
UNION ALL
SELECT * 
FROM lab_01.musicians M1
WHERE M1.musicians_id IN
(
	SELECT A.musicians_id      
	FROM lab_01.albums A
	JOIN lab_01.genres AS G ON G.genre_id=A.genre_id
	JOIN lab_01.labels AS L ON L.label_id=A.label_id
	WHERE L.country='Russia' AND G.name LIKE '%Punk%'
	ORDER BY A.record_year
);

--Вывести список групп и приблизительный год их появления(Простое выражение CASE)
SELECT name,
	CASE birthyear
		WHEN 2019 THEN 'This year'
		WHEN 2020 THEN 'Next year'
		ELSE 'Previous years'
	END AS "When musicians born"
FROM lab_01.musicians;

--Вывести музыкантов, чье кол-во альбомов =0 >0 >2 >4 c соответствующими сообщениями(Поисковое выражение CASE)
SELECT M1.name,
	CASE
		WHEN albums_count=0 THEN 'There is no one album'
		WHEN albums_count<3 THEN 'There are 1-2 albums'
		WHEN albums_count<5 THEN 'There are 3-4 albums'
		ELSE 'There are more than 4 albums '
	END AS track_har_count
FROM 
(
	SELECT M2.name, COUNT(*) AS albums_count
	FROM lab_01.albums A
	JOIN lab_01.musicians AS M2 ON M2.musicians_id=A.musicians_id
	GROUP BY M2.name
) AS M1;

--Создать временную таблицу с именами музыкантов и кол-вом людей, 
--кол-во людей < 3(Создание новой временной локальной таблицы)
SELECT name, people_count
INTO tmp_musicians
FROM lab_01.musicians
WHERE people_count < 3
ORDER BY name;

--Вывести список альбомов, которые...(вложенные коррелированные подзапросы в качестве
--производных таблиц в предложении FROM)
SELECT A.name, A.tracks_count, M.name
FROM lab_01.albums A
JOIN lab_01.musicians AS M ON A.musicians_id=M.musicians_id
WHERE record_year =
(
	SELECT MAX(record_year)
	FROM lab_01.albums A1
	WHERE A1.album_type='SP'
);

--(вложенные подзапросы с уровнем вложенности 3)
SELECT DISTINCT A.name, M.people_count, A.tracks_count, A.album_type
FROM lab_01.albums A
JOIN lab_01.musicians AS M ON A.musicians_id=M.musicians_id
WHERE M.people_count = 
(
	SELECT CAST(AVG(people_count) + 2 AS INT)
	FROM lab_01.musicians M1
	WHERE M1.musicians_id BETWEEN 
	(
		SELECT CAST(MAX(A2.musicians_id)/2 AS INT)
		FROM lab_01.musicians M2
		JOIN lab_01.albums AS A2 ON A2.musicians_id=M2.musicians_id
		JOIN lab_01.genres AS G2 ON G2.genre_id=A2.genre_id
		WHERE M2.country = 
		(
			SELECT L3.country
			FROM lab_01.labels L3
			WHERE L3.label_id = 1
		)
	)
	AND
	(
		SELECT MAX(musicians_id)
		FROM lab_01.musicians	
	)
);

--Вывести названия жанров и кол-во их альбомов, которые вышли в 1994 году(SELECT с GROUP BY, но без HAVING)
SELECT G.name AS "Genre name", COUNT(*) AS "Count of albums"
FROM lab_01.albums A
JOIN lab_01.genres AS G ON G.genre_id=A.genre_id
WHERE A.record_year=1998
GROUP BY G.name;

--Вывести распавшиеся группы с кол-вом альбомов, которые они выпустили(SELECT c GROUP BY и HAVING)
SELECT M.name, COUNT(A.album_id)
FROM lab_01.albums A
JOIN lab_01.musicians AS M ON A.musicians_id=M.musicians_id
WHERE CAST(M.is_dead AS INT) = 1
GROUP BY M.name, M.birthyear
HAVING M.birthyear < CAST(AVG(A.record_year) AS INT);

--Добавить ещё один русский music label(Простая инструкция INSERT)
INSERT INTO lab_01.labels
VALUES (36, 'Wow Records','Russia');

--Добавить в конец ещё один альбом
INSERT INTO lab_01.albums
SELECT MAX(album_id)+1,'It is your heroic duty, Henry!','TLK',2000,50,3,4,5
FROM lab_01.albums;

--Добавить результаты подзапроса в таблицу
INSERT INTO lab_01.albums
SELECT (
	SELECT MAX(album_id)+1
	FROM lab_01.albums
),'Rock and Titanfall','TLP',2007,49,3,4,5;

--Переименовать группу Real Dragons в Not-Imagined Dragons(Простая инструкция UPDATE)
UPDATE lab_01.musicians
SET name='Not-Imagined Dragons'
WHERE name='Real Dragons';

--(UPDATE со скалярным подзапросом в предложении SET)
UPDATE lab_01.musicians
SET birthyear =
(
	SELECT AVG(birthyear)
	FROM lab_01.musicians
	WHERE people_count=3
)
WHERE name='Limbo';

--Удалить все альбомы, в которых кол-во треков > 12 && < 24 (DELETE)
DELETE FROM lab_01.albums AS A
WHERE A.tracks_count BETWEEN 12 AND 24;

--Удалить все 'Metal' альбомы (DELETE с вложенным подзапросом)
DELETE FROM lab_01.albums AS A
WHERE A.genre_id IN
(
	SELECT A.genre_id
	FROM lab_01.albums A
	JOIN lab_01.genres AS G ON A.genre_id=G.genre_id
	WHERE G.name LIKE '%Metal'
);

--(SELECT, используещее простое ОТВ)
WITH SOME_CTE(label_name, album_count)
AS
(
	SELECT L.name, COUNT(A.album_id)
	FROM lab_01.albums A
	JOIN lab_01.labels AS L ON L.label_id=A.label_id
	GROUP BY L.name
)
SELECT *
FROM SOME_CTE
ORDER BY album_count DESC;

--(SELECT, использующее рекурсивное ОТВ)
WITH RECURSIVE SOME_CTE(new_album_id, album_name)
AS
(

)
SELECT *
FROM SOME_CTE
ORDER BY new_album_id DESC;

--(Оконные функции)
SELECT DISTINCT M.name, M.people_count,
	CAST(AVG(A.record_year) OVER(PARTITION BY M.name) AS INT) AS "Average Record Year",
	MIN(A.record_year) OVER(PARTITION BY M.name) AS "First Album Record Year",
	MAX(A.record_year) OVER(PARTITION BY M.name) AS "Last Album Record Year"
FROM lab_01.albums A
JOIN lab_01.musicians AS M ON M.musicians_id=A.musicians_id;

--(Оконные фикции для устранения дублей)
WITH SOME_CTE(label_id, label_name)
AS
(
	SELECT label_id, name
	FROM lab_01.labels
	UNION
	SELECT label_id, name
	FROM lab_01.labels
)
