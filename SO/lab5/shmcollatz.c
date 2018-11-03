#include <errno.h>
#include <fcntl.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <unistd.h>

int main(int argc, char **argv) {
  if (argc == 1) {
    printf("Program that tests the Collatz conjecture.");
    return EXIT_SUCCESS;
  }
  char shm_name[] = "myshm";
  int shm_fd;
  shm_fd = shm_open(shm_name, O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);
  if (shm_fd < 0) {
    perror("SHM_FD");
    return errno;
  }
  size_t shm_size = 10000;
  if (ftruncate(shm_fd, shm_size) == -1) {
    perror(NULL);
    shm_unlink(shm_name);
    return errno;
  }
  size_t copil_size = shm_size / (argc - 1);
  off_t copil_off[(argc-1)];
  int i;
  copil_off[0]=0;
  for(i=1;i<(argc-1);i++){
    copil_off[i]= copil_off[i-1]+copil_size;
  }
  printf("Starting parent %d\n", getpid());
  for (i = 0; i < (argc-1); i++) {
    pid_t pid = fork();
    if (pid < 0){
      perror(NULL);
      return EXIT_FAILURE;
    }
    else if (pid == 0) {
    char *shm_ptr =
      (char*)mmap(0, copil_size, PROT_WRITE, MAP_SHARED, shm_fd, copil_off[i]);
    if (shm_ptr == MAP_FAILED) {
      perror("WTF");
      shm_unlink(shm_name);
      return errno;
    }
    long number = strtol(argv[i], NULL, 10);
    sprintf(shm_ptr, "\n%ld: %ld ", number, number);
    while (number > 1)
      if (number % 2 == 0) {
        number /= 2;
        sprintf(shm_ptr, "%ld ", number);
      } else {
        number = number * 3 + 1;
        sprintf(shm_ptr, "%ld ", number);
      }
    if (number < 0) {
      errno = ERANGE;
      perror("Error");
      return EXIT_FAILURE;
    }
    sprintf(shm_ptr,"\nDone Parent %d Me %d \n", getppid(), getpid());
    munmap(shm_ptr, copil_size);
    return EXIT_SUCCESS;
    }
  }
  for (i = 0; i < argc; i++) {
    wait(NULL);
  }
  char *shm_ptr =(char *) mmap(0, shm_size, PROT_READ, MAP_SHARED, shm_fd, 0);
  for (i = 0; i< (int)shm_size; i++) {
    char c=shm_ptr[i];
    putchar(c);
  }
  return 0;
}
