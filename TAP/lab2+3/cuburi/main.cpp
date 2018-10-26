// Problema 1
#include <algorithm>
#include <iostream>
#include <vector>
using namespace std;
struct cub {
  int latura, culoare, indice;
};
int main() {
  vector<cub> cuburi{{5, 1, 1}, {10, 1, 2}, {9, 1, 3}, {8, 2, 4}};
  sort(cuburi.begin(), cuburi.end(),
       [](const cub &a, const cub &b) { return a.latura > b.latura; });
  int sum = 0;
  int last_cul = 0;
  for (auto x : cuburi) {
    if (x.culoare != last_cul) {
      last_cul = x.culoare;
      sum += x.latura;
      cout << x.indice << " ";
    }
  }
  cout << endl << sum;
}
