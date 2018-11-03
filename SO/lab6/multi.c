#include <errno.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

struct matrix_in {
  int x;
  int y;
  int marime;
  int **matrix_1;
  int **matrix_2;
};

void *calc(void *v) {
  struct matrix_in *matr_in = (struct matrix_in *)v;
  int i;
  int *sum = (int *)malloc(sizeof(int));
  *sum = 0;
  int x = matr_in->x;
  int y = matr_in->y;
  for (i = 0; i < matr_in->marime; i++)
    *sum += matr_in->matrix_1[x][i] * matr_in->matrix_2[i][y];
  return (void *)sum;
}

int main(int argc, char **argv) {
  if (argc == 1) {
    printf("Program ce inmulteste 2 matrici");
    return EXIT_SUCCESS;
  }

  FILE *in = fopen(argv[1], "r");
  if (in == NULL) {
    perror(NULL);
    return errno;
  }

  int x, y;
  fscanf(in, "%d%d", &x, &y);

  int **matrix = (int **)malloc(x * sizeof(int *));
  int i;
  for (i = 0; i < x; i++)
    matrix[i] = (int *)malloc(x * sizeof(int));

  int **matrix_in_1 = (int **)malloc(x * sizeof(int *));
  for (i = 0; i < x; i++)
    matrix_in_1[i] = (int *)malloc(y * sizeof(int));

  int **matrix_in_2 = (int **)malloc(y * sizeof(int *));
  for (i = 0; i < y; i++)
    matrix_in_2[i] = (int *)malloc(x * sizeof(int));

  int j;
  for (i = 0; i < x; i++)
    for (j = 0; j < y; j++)
      fscanf(in, "%d", &matrix_in_1[i][j]);

  for (i = 0; i < y; i++)
    for (j = 0; j < x; j++)
      fscanf(in, "%d", &matrix_in_2[i][j]);

  struct matrix_in *matr_in =
      (struct matrix_in *)malloc(sizeof(struct matrix_in));
  matr_in->marime = y;
  matr_in->matrix_1 = matrix_in_1;
  matr_in->matrix_2 = matrix_in_2;

  pthread_t *thr = (pthread_t *)malloc((x * x) * sizeof(pthread_t));
  int w = 0;

  for (i = 0; i < x; i++)
    for (j = 0; j < x; j++) {

      matr_in->x = i;
      matr_in->y = j;

      if (pthread_create(&thr[w], NULL, calc, (void *)matr_in)) {
        perror(NULL);
        int my_err = errno;
        fclose(in);
        free(matrix);
        return my_err;
      }

      int *sum;
      if (pthread_join(thr[w], (void **)&sum)) {
        perror(NULL);
        int my_err = errno;
        fclose(in);
        free(matrix);
        return my_err;
      }

      matrix[i][j] = *sum;
      free(sum);
      w++;
    }

  for (i = 0; i < x; i++) {
    for (j = 0; j < x; j++)
      printf("%d ", matrix[i][j]);
    printf("\n");
  }

  for (i = 0; i < x; i++)
    free(matrix[i]);
  free(matrix);

  for (i = 0; i < x; i++)
    free(matrix_in_1[i]);
  free(matrix_in_1);

  for (i = 0; i < y; i++)
    free(matrix_in_2[i]);
  free(matrix_in_2);

  free(matr_in);

  free(thr);

  if (fclose(in) == EOF) {
    perror(NULL);
    free(matrix);
    return errno;
  }

  return EXIT_SUCCESS;
}
