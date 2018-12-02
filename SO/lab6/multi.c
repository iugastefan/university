#include <errno.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

struct matrix_in {
  int marime;
  int x;
  int y;
  int **matrix_1;
  int **matrix_2;
  int **matrix_out;
};

void *calc(void *v) {
  struct matrix_in *matr_in = (struct matrix_in *)v;
  int i;
  int sum = 0;
  int x = matr_in->x;
  int y = matr_in->y;
  for (i = 0; i < matr_in->marime; i++)
    sum += matr_in->matrix_1[x][i] * matr_in->matrix_2[i][y];
  matr_in->matrix_out[x][y] = sum;
  return NULL;
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

  int x, y, z;
  fscanf(in, "%d%d%d", &x, &y, &z);

  int **matrix = (int **)malloc(x * sizeof(int *));
  int i;
  for (i = 0; i < x; i++)
    matrix[i] = (int *)malloc(z * sizeof(int));

  int **matrix_in_1 = (int **)malloc(x * sizeof(int *));
  for (i = 0; i < x; i++)
    matrix_in_1[i] = (int *)malloc(y * sizeof(int));

  int **matrix_in_2 = (int **)malloc(y * sizeof(int *));
  for (i = 0; i < y; i++)
    matrix_in_2[i] = (int *)malloc(z * sizeof(int));

  int j;
  for (i = 0; i < x; i++)
    for (j = 0; j < y; j++)
      fscanf(in, "%d", &matrix_in_1[i][j]);

  for (i = 0; i < y; i++)
    for (j = 0; j < z; j++)
      fscanf(in, "%d", &matrix_in_2[i][j]);

  struct matrix_in matr_in[x * z];

  pthread_t thr[x * z];
  int w = 0;

  for (i = 0; i < x; i++) {
    for (j = 0; j < z; j++, w++) {

      matr_in[w].marime = y;
      matr_in[w].matrix_1 = matrix_in_1;
      matr_in[w].matrix_2 = matrix_in_2;
      matr_in[w].matrix_out = matrix;
      matr_in[w].x = i;
      matr_in[w].y = j;

      if (pthread_create(&thr[w], NULL, calc, (void *)&matr_in[w])) {
        perror(NULL);
        int my_err = errno;
        fclose(in);
        free(matrix);
        return my_err;
      }
    }
  }

  for (i = 0; i < w; i++) {
    if (pthread_join(thr[i], NULL)) {
      perror(NULL);
      int my_err = errno;
      fclose(in);
      free(matrix);
      return my_err;
    }
  }

  for (i = 0; i < x; i++) {
    for (j = 0; j < z; j++)
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

  if (fclose(in) == EOF) {
    perror(NULL);
    return errno;
  }

  return EXIT_SUCCESS;
}
