CC=gcc
CFLAGS=$(shell pkg-config fuse libzip libarchive --cflags --libs)
RM=/bin/rm -f
all: main
main: main.c
	$(CC) $(CFLAGS) -o main main.c -g
