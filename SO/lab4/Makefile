CC=clang
RM=/bin/rm -f
all: forkls collatz ncollatz
forkls: forkls.c
	$(CC) -o forkls forkls.c
collatz: collatz.c
	$(CC) -o collatz collatz.c
ncollatz: ncollatz.c
	$(CC) -o ncollatz ncollatz.c
clean:
	$(RM) forkls collatz ncollatz
