import psycopg2 as pg

def print_row(row):
    print('|', end = '');
    print('{:6s}'.format(str(row[0])), end = '|');
    print('{:40s}'.format(str(row[1])), end = '|');
    for element in row[2:]:
        print('{:20s}'.format(str(element)), end = '|');
    print('');

if __name__ == "__main__":
    connection = pg.connect("dbname=labs user=nikolay");
    cursor = connection.cursor();
    
    #Однотабличный запрос на выборку (вывести все альбомы с id > 1000)
    cursor.execute("SELECT * FROM albums;");
    tmp = cursor.fetchall();

    query_result1 = filter(lambda query: (query[0] > 1000), tmp);

    del tmp;
    for row in query_result1:
        print_row(row);
    del query_result1;

    #Многотабличный запрос на выборку
    #cursor.execute("SELECT COUNT(*), M.musicians");
    #cursor.execute("FROM albums AS A");
    
    print("\n");
    print("\n");
    print("\n");

    #Многотабличный запрос на выборку(JOIN albums Genres MINUS albums_id < 900)
    cursor.execute("SELECT * FROM albums;");
    all_albums = cursor.fetchall();
    cursor.execute("SELECT * FROM genres;");
    all_genres = cursor.fetchall();

    albums_join_genres = lambda array1, array2: [(arrayi1[0], arrayi1[1], arrayi1[2], arrayi1[3], arrayi1[4],
        arrayi1[5], arrayi1[6], arrayi2[0], arrayi2[1], arrayi2[2])
        for arrayi1 in array1 for arrayi2 in array2 if (arrayi1[7] == arrayi2[0])];
    query_result2 = filter(lambda query: (query[0] <= 900) and (query[0] >= 800), albums_join_genres(all_albums, all_genres));
    
    for row in query_result2:
        print_row(row);

    #Удаление, обновление и добавление в БД
    #1)
    cursor.execute("DELETE FROM albums \
            WHERE album_id > 1000;");

    #2)
    cursor.execute("UPDATE genres \
            SET name = \'PPunk\' \
            WHERE name = \'Punk\';");

    #3)
    cursor.execute("INSERT INTO labels \
            VALUES \
            (26, \'Old 80-yeers studio\', \'Russia\'), \
            (27, \'Your music portrait\', \'Austria\');");
    connection.commit();

    #Emmm... Получить доступ к данным используя только хранимые процедуры? Да ну на...
