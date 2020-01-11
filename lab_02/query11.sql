--Создать временную таблицу с именами музыкантов и кол-вом людей, 
--кол-во людей < 3(Создание новой временной локальной таблицы)
DROP TABLE IF EXISTS tmp_musicians;

SELECT name, people_count
INTO tmp_musicians
FROM musicians
WHERE people_count < 3
ORDER BY name;
