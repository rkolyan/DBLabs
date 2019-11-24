--Хранимая процедура доступа к метаданным
CREATE OR REPLACE PROCEDURE select_all_tablices_of_user(user_name VARCHAR(200))
AS $$
BEGIN
	DROP TABLE IF EXISTS tmp_tab;
	CREATE TABLE tmp_tab 
	AS
		SELECT *
		FROM pg_tables T
		JOIN pg_user AS U ON U.usename = T.tableowner
		WHERE T.tableowner = user_name;
END;
$$ LANGUAGE PLPGSQL;
