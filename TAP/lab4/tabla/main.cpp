// Problema 3
#include <algorithm>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <math.h>
#include <vector>

struct punct {
  int x, y;
};
struct patrat {
  punct p1, p2;
};
int distanta(punct p1, punct p2) {
  return pow((p2.y - p1.y), 2) + pow((p2.x - p1.x), 2);
}
using namespace std;
void completeaza(vector<vector<int>> &v, punct x, patrat p, int *count) {
  if (p.p2.y - p.p1.y == 1) {
    for (auto i = p.p1.x; i <= p.p2.x; i++)
      for (auto j = p.p1.y; j <= p.p2.y; j++)
        if (i != x.x || j != x.y)
          v[i][j] = *count;
    (*count)++;
    return;
  }
  punct mij{p.p1.x + (p.p2.x - p.p1.x) / 2, p.p1.y + (p.p2.y - p.p1.y) / 2};
  vector<punct> w{
      mij, {mij.x + 1, mij.y}, {mij.x, mij.y + 1}, {mij.x + 1, mij.y + 1}};
  sort(w.begin(), w.end(),
       [=](punct p1, punct p2) { return distanta(x, p1) > distanta(x, p2); });
  for (int q = 0; q < 3; q++) {
    v[w[q].x][w[q].y] = (*count);
  }
  (*count)++;
  for (int q = 0; q < 3; q++) {
    if (w[q].x % 2 != 0) {
      if (w[q].y % 2 != 0)
        completeaza(v, w[q], patrat{p.p1, w[q]}, count);
      else
        completeaza(v, w[q],
                    patrat{punct{p.p1.x, w[q].y}, punct{w[q].x, p.p2.y}},
                    count);
    } else {
      if (w[q].y % 2 != 0)
        completeaza(v, w[q],
                    patrat{punct{w[q].x, p.p1.y}, punct{p.p2.x, w[q].y}},
                    count);
      else
        completeaza(v, w[q], patrat{w[q], p.p2}, count);
    }
  }
  if (w[3].x % 2 != 0) {
    if (w[3].y % 2 != 0)
      completeaza(v, x, patrat{p.p1, w[3]}, count);
    else
      completeaza(v, x, patrat{punct{p.p1.x, w[3].y}, punct{w[3].x, p.p2.y}},
                  count);
  } else {
    if (w[3].y % 2 != 0)
      completeaza(v, x, patrat{punct{w[3].x, p.p1.y}, punct{p.p2.x, w[3].y}},
                  count);
    else
      completeaza(v, x, patrat{w[3], p.p2}, count);
  }
}
int main() {

  ifstream f("date.in");
  int n;
  f >> n;
  int x, y;
  f >> x >> y;
  x--;
  y--;
  int size = 1 << n;
  vector<vector<int>> v(size);
  for (int i = 0; i < size; i++)
    v[i] = vector<int>(size);
  int *i = new int;
  *i = 1;
  completeaza(v, punct{x, y}, patrat{punct{0, 0}, punct{size - 1, size - 1}},
              i);
  for (int i = 0; i < size; i++) {
    for (int j = 0; j < size; j++)
      cout << setw(3) << v[i][j] << " ";
    cout << endl;
  }
  f.close();
  delete i;
  return EXIT_SUCCESS;
}
