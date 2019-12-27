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

    def __length__(self):
        length = 0;
        key = self.__dict__.keys()[0];
        length = len(self.__dict__[key]);

    def delete(self, value):


class AlbumsTable:
    def __init__(self):
        self.album_id = list();
        self.name = list();
        self.album_type = list();
        self.record_year = list();
        self.tracks_count = list();
        self.musicians_id = list();
        self.label_id = list();
        self.genre_id = list();

    def __length__(self):
        return len(self.album_id);

    def __getitem__(self, key):
        return {'album_id' : [self.album_id[key]], 
                'name' : [self.name[key]], 
                'album_type' : [self.album_type[key]], 
                'record_year' : [self.record_year[key]], 
                'tracks_count' : [self.tracks_count[key]],
                'musicians_id' : [self.musicians_id[key]],
                'label_id' : [self.label_id[key]],
                'genre_id' : [self.genre_id[key]]};

    def __setitem__(self, key, value):
        self.album_id[key] = value['album_id'];
        self.name[key] = value['name'];
        self.album_type[key] = value['album_type'];
        self.tracks_count[key] = value['tracks_count'];
        self.musicians_id[key] = value['musicians_id'];
        self.label_id[key] = value['label_id'];
        self.genre_id[key] = value['genre_id'];

    def insert(self, values):
        for key in self.__dict__.keys():
            for i in range(len(values[key])):
                self.__dict__[key].append(values[key][i]);

class MusiciansTable:
    def __init__(self):
        self.musicians_id = list();
        self.name = list();
        self.people_count = list();
        self.birthyear = list();
        self.is_dead = list();
        self.country = list();

    def __length__(self):
        return len(self.musicians_id);

    def __getitem__(self, key):
        return {'musicians_id' : [self.album_id[key]], 
                'name' : [self.name[key]], 
                'people_count' : [self.people_count[key]], 
                'birthyear' : [self.birthyear[key]], 
                'is_dead' : [self.is_dead[key]],
                'country' : [self.country[key]]};

    def __setitem__(self, key, value):
        self.musicians_id[key] = value['musicians_id'];
        self.name[key] = value['name'];
        self.people_count[key] = value['people_count'];
        self.birthyear[key] = value['birthyear'];
        self.is_dead[key] = value['is_dead'];
        self.country[key] = value['country'];

class GenreTable:
    def __init__(self):
        self.genre_id = list();
        self.name = list();
        self.birth_years = list();

    def __length__(self):
        return len(self.genre_id);

    def __getitem__(self, key):
        return {'genre_id' : [self.genre_id[key]], 
                'name' : [self.name[key]], 
                'birth_years' : [self.birth_years[key]]};

    def __setitem__(self, key, value):
        this.genre_id = value['genre_id'];
        this.name = value['name'];
        this.birth_years = value['birth_years'];

class LabelTable:
    def __init__(self):
        self.label_id = list();
        self.name = list();
        self.country = list();

    def __length__(self):
        return len(self.label_id);

    def __getitem__(self, key):
        return {'label_id' : [self.label_id[key]], 
                'name' : [self.name[key]], 
                'country' : [self.country[key]]};

    def __setitem__(self, key, value):
        this.label_id = value['label_id'];
        this.name = value['name'];
        this.country = value['country'];


if __name__ == "__main__":
    #TODO: Add lambda-functions
