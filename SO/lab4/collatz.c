#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

int main(int argc, char **argv) {
  if (argc == 1) {
    printf("Program that tests the Collatz conjecture.");
    return EXIT_SUCCESS;
  }
  if (argc > 2) {
    errno = E2BIG;
    perror("Error");
    return EXIT_FAILURE;
  }
  pid_t pid = fork();
  if (pid < 0)
    return EXIT_FAILURE;
  if (pid == 0) {
    long number = strtol(argv[1], NULL, 10);
    if (errno != 0) {
      perror("Error");
      return EXIT_FAILURE;
    }
    if (number <= 0) {
      fprintf(stderr, "Please provide an natural number greater than 0\n");
      return EXIT_FAILURE;
    }
    printf("\n%ld: %ld ", number, number);
    while (number > 1)
      if (number % 2 == 0) {
        number /= 2;
        printf("%ld ", number);
      } else {
        number = number * 3 + 1;
        printf("%ld ", number);
      }
    if (number < 0) {
      errno = ERANGE;
      perror("Error");
      return EXIT_FAILURE;
    }
  } else {
    wait(NULL);
    printf("\nChild %d finished\n", pid);
  }
  return EXIT_SUCCESS;
}
