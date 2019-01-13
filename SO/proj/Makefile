CC=gcc
CFLAGS=$(shell pkg-config fuse libzip --cflags --libs)
RM=/bin/rm -f
all: main
main: main.c
	$(CC) $(CFLAGS) -o main main.c
