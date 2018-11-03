#include <errno.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void *reverse(void *v) {
  char *word = (char *)v;
  ulong size = strlen(word);
  char *rword = (char *)malloc(size * sizeof(char));
  int i;
  for (i = 1; i <= (int)size; i++)
    rword[size - i] = word[i - 1];
  return rword;
}
int main(int argc, char **argv) {
  pthread_t thr;
  if (pthread_create(&thr, NULL, reverse, argv[1])) {
    perror(NULL);
    return errno;
  }
  char *rword;
  if (pthread_join(thr, (void **)&rword)) {
    perror(NULL);
    return errno;
  }
  printf("%s", rword);
  free(rword);
  return 0;
}
