#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <unistd.h>
int main(int argc, char **argv) {
  if (argc != 3) {
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
  int fd2 = open(argv[2], O_WRONLY);
  if (fd2 == -1) {
    write(1, "Write file cannot be open", 25);
    free(buff);
    int fd3 = close(fd);
    if (fd3 == -1) {
      write(1, "Read file cannot be closed", 26);
      return -1;
    }
    return -1;
  }
  int n = 0;
  while ((n = read(fd, buff, 4096)) > 0) {
    write(fd2, buff, n);
  }
  free(buff);
  int fd3 = close(fd);
  if (fd3 == -1) {
    write(1, "Read file cannot be closed", 26);
    return -1;
  }
  int fd4 = close(fd2);
  if (fd4 == -1) {
    write(1, "Write file cannot be closed", 27);
    return -1;
  }

  return 0;
}
