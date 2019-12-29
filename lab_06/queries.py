import psycopg2 as pg

if __name__ == "__main__":
    connection = pg.connect("dbname=labs user=nikolay");
    cursor = connection.cursor();
    
    #Однотабличный запрос на выборку (вывести все альбомы с id > 1000)
    cursor.execute("SELECT * FROM lab_01.albums;");
    tmp = cursor.fetchall();

    query_result1 = filter(lambda query: (query[0] > 1000), tmp);

    del tmp;
    for row in query_result1:
        print(row);
    del query_result1;

    #Многотабличный запрос на выборку
    #cursor.execute("SELECT COUNT(*), M.musicians");
    #cursor.execute("FROM lab_01.albums AS A");
    
    print("\n");
    print("\n");
    print("\n");

    #Многотабличный запрос на выборку(JOIN albums Genres MINUS albums_id < 900)
    cursor.execute("SELECT * FROM lab_01.albums;");
    all_albums = cursor.fetchall();
    cursor.execute("SELECT * FROM lab_01.genres;");
    all_genres = cursor.fetchall();

    albums_join_genres = lambda array1, array2: [(arrayi1[0], arrayi1[1], arrayi1[2], arrayi1[3], arrayi1[4],
        arrayi1[5], arrayi1[6], arrayi2[0], arrayi2[1], arrayi2[2])
        for arrayi1 in array1 for arrayi2 in array2 if (arrayi1[7] == arrayi2[0])];
    query_result2 = filter(lambda query: (query[0] <= 900) and (query[0] >= 800), albums_join_genres(all_albums, all_genres));
    
    for row in query_result2:
        print(row);

    #Удаление, обновление и добавление в БД
    #1)
    cursor.execute("DELETE FROM lab_01.albums AS A")
    cursor.execute("WHERE A.album_id > 1000;");

    #2)
    cursor.execute("UPDATE lab_01.genres")
    cursor.execute("SET G.name = \"PPunk\"");
    cursor.execute("WHERE G.name = \"Punk\";");
