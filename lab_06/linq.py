class AbstractTable:
    def __init__(self, **kwargs):
        for key in kwargs:
            self.__dict__[key] = list();

    def insert(self, values):
        for key in self.__dict__.keys():
            for i in range(len(values[key])):
                self.__dict__[key].append(values[key][i]);

    def __len__(self):
        key = self.__dict__.keys()[0];
        return len(self.__dict__[key]);

#Ou Эта функция работает стабильно
def fill_tablice(somefile, tablice):
    for row1 in somefile:
        tablice.append(row1.split(','));
    return tablice;

def print_tablice(tablice):
    for i in range(len(tablice)):
        print("|", end='');
        for element in tablice[i]:
            print('{:20s}'.format(element), end='|');
        print("");

if __name__ == "__main__":
    albums = list();
    musicians = list();
    genres = list();
    labels = list();
    f = open("../lab_01/csv/albums.csv", "r");
    albums = fill_tablice(f, albums);
    f.close();
    f = open("../lab_01/csv/musicians.csv", "r");
    musicians = fill_tablice(f, musicians);
    f.close();
    f = open("../lab_01/csv/genres.csv", "r");
    genres = fill_tablice(f, genres);
    f.close();
    f = open("../lab_01/csv/labels.csv", "r");
    labels = fill_tablice(f, labels);
    f.close();

    #TODO: Add lambda-functions
    #1)Get Dead Music Groups
    print("QUERY01:");
    query01 = list(filter(lambda row: int(row[2]) > 1 and int(row[4]), musicians));
    print_tablice(query01);
    del query01;

    print("\n\n\n");

    #2)Get Alive Musician's Names
    print("QUERY02:");
    query02 = list(filter(lambda row: not int(row[4]), musicians));
    print_tablice(query02);
    del query02;

    print("\n\n\n");

    #3)All Dead Musicians (with order desc)
    print("QUERY03:");
    query03 = sorted(list(filter(lambda row: int(row[4]), musicians)), key=lambda row: int(row[0]), reverse=True);
    print_tablice(query03);
    del query03;

    print("\n\n\n");

    #4)Add something
