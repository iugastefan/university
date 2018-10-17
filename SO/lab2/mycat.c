#include <fcntl.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <unistd.h>

int main(int argc, char **argv) {
  if (argc != 2) {
    write(1, "Incorrect number of parameters", 30);
    return -1;
  }
  int fd = open(argv[1], O_RDONLY);
  if (fd == -1) {
    write(1, "Read file cannot be open", 24);
    return -1;
  }
  void *buff = malloc(4096);
  if (buff == NULL) {
    write(1, "Memory cannot be allocated", 26);
    return -1;
  }
  int n = 0;
  while ((n = read(fd, buff, 4096)) > 0) {
    write(1, buff, n);
  }
  free(buff);
  int fd2 = close(fd);
  if (fd2 == -1) {
    write(1, "Read file cannot be closed", 26);
    return -1;
  }
  return 0;
}
