// Problema 2
#include <iostream>
#include <limits.h>
#include <vector>

using namespace std;

void matr(vector<vector<long>> &v, int x, int y, int n, long &z) {
  if (n == 2) {
    v[x][y + 1] = z;
    v[x + 1][y] = z + 1;
    v[x][y] = z + 2;
    v[x + 1][y + 1] = z + 3;
    z += 4;
    return;
  }
  matr(v, x, y + n / 2, n / 2, z);
  matr(v, x + n / 2, y, n / 2, z);
  matr(v, x, y, n / 2, z);
  matr(v, x + n / 2, y + n / 2, n / 2, z);
}

int main(int argc, char **argv) {

  if (argc == 1) {
    cout << "Problema cu matrice";
    return 0;
  }

  long w = strtol(argv[1], nullptr, 10);
  if (w == LONG_MAX || w == LONG_MIN) {
    perror(NULL);
    return errno;
  }

  w = 1 << w;

  auto v = vector<vector<long>>(w);
  for (long i = 0; i < w; i++)
    v[i] = vector<long>(w);

  long i = 1;
  matr(v, 0, 0, w, i);

  for (int i = 0; i < w; i++) {
    for (int j = 0; j < w; j++)
      cout << v[i][j] << "  ";
    cout << endl;
  }

  return EXIT_SUCCESS;
}
