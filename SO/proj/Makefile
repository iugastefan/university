CC=gcc
CFLAGS=$(shell pkg-config fuse libarchive --cflags --libs)
RM=/bin/rm -f
all: main
main: main.c
	$(CC) $(CFLAGS) -o main main.c
