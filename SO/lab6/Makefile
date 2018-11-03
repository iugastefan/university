CC=clang
CFLAGS=-pthread
RM=/bin/rm -f
all: strrev multi
strrev: strrev.c
	$(CC) $(CFLAGS) -o strrev strrev.c
multi: multi.c
	$(CC) $(CFLAGS) -o multi multi.c
clean:
	$(RM) strrev multi
