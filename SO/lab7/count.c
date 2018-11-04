#include <errno.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define MAX_RESOURCES 5
int avaible_resources = MAX_RESOURCES;
pthread_mutex_t mtx;

int decrease_count(int count) {
  pthread_mutex_lock(&mtx);
  if (avaible_resources < count) {
    pthread_mutex_unlock(&mtx);
    return -1;
  } else {
    avaible_resources -= count;
    printf("Got %d resources %d remaining\n", count, avaible_resources);
    pthread_mutex_unlock(&mtx);
  }
  return 0;
}
int increase_count(int count) {
  pthread_mutex_lock(&mtx);
  avaible_resources += count;
  printf("Released %d resources %d remaining\n", count, avaible_resources);
  pthread_mutex_unlock(&mtx);
  return 0;
}
void *proces(void *v) {
  int *count = (int *)v;
  int got = decrease_count(*count);
  while (got != 0)
    got = decrease_count(*count);
  usleep(200);
  increase_count(*count);
  free(count);
  return NULL;
}
int main() {

  if (pthread_mutex_init(&mtx, NULL)) {
    perror(NULL);
    return errno;
  }
  pthread_t thr[5];
  int i;
  printf("MAX_RESOURCES=%d\n", MAX_RESOURCES);
  for (i = 0; i < 5; i++) {

    int *count = (int *)malloc(sizeof(int));
    *count = i + 1;
    if (pthread_create(&thr[i], NULL, proces, (void *)count)) {
      perror(NULL);
      return errno;
    }
  }

  for (i = 0; i < 5; i++) {
    if (pthread_join(thr[i], NULL)) {
      perror(NULL);
      return errno;
    }
  }

  if (pthread_mutex_destroy(&mtx)) {
    perror(NULL);
    return errno;
  }

  return EXIT_SUCCESS;
}
