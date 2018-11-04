#include <errno.h>
#include <pthread.h>
#include <semaphore.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define MAX_RESOURCES 5
int avaible_resources = MAX_RESOURCES;
sem_t sem;
void barrier_point() {
  sem_wait(&sem);
  usleep(200);
  sem_post(&sem);
}

void *tfun(void *v) {
  int *tid = (int *)v;

  printf("%d reached the barrier\n", *tid);
  barrier_point();
  printf("%d passed the barrier\n", *tid);

  free(tid);
  return NULL;
}
int main(void) {
  if (sem_init(&sem, 0, avaible_resources)) {
    perror(NULL);
    return errno;
  }
  printf("NTHRS=%d\n", MAX_RESOURCES);

  pthread_t thr[5];
  int i;
  for (i = 0; i < 5; i++) {
    int *val = (int *)malloc(sizeof(int));
    *val = i;
    if (pthread_create(&thr[i], NULL, tfun, (void *)val)) {
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

  sem_destroy(&sem);

  return EXIT_SUCCESS;
}
