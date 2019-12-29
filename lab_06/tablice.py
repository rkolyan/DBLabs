albums = {'album_id' : list(), 'name' : list(), 'album_type' : list(), 'record_year' : list(), 'tracks_count' : list(), 'musicians_id' : list(), 'label_id' : list(), 'genre_id' : list()};
musicians = {'musicians_id' : list(), 'name' : list(), 'people_count' : list(), 'birthyear' : list(), 'is_dead' : list(), 'country' : list()};
genres = {'genre_id' : list(), 'name' : list(), 'birth_years' : list()};
labels = {'label_id' : list(), 'name' : list(), 'country' : list()};

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

    def __iter__(self):
        #TODO: Iterator
        pass;

    def __add__(self, other):
        #TODO: JOIN

    def __sub__(self, other):
        #TODO: MINUS

if __name__ == "__main__":
    #TODO: Add lambda-functions
