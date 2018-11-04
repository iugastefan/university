CC=clang
CFLAGS=-pthread
RM=/bin/rm -f
all: count barrier
count: count.c
	$(CC) $(CFLAGS) -o count count.c
barrier: barrier.c
	$(CC) $(CFLAGS) -o barrier barrier.c
clean:
	$(RM) count barrier
