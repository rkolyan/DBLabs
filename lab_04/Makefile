CC = gcc -std=c1x -Wall -Werror

last_move : libfunctions.so
	sudo mv libfunctions.so /lib/postgresql/libfunctions.so

libfunctions.so : functions.o
	$(CC) -shared -L/usr/lib/postgresql -lpq -o $@ $^

%.o : %.c
	$(CC) -I/usr/include/postgresql/server -fPIC -c $^

clean :
	rm *.o *.so
