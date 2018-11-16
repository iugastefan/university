#include <array>
#include <iostream>
#include <unordered_map>
#include <vector>
using namespace std;
array<array<int, 5>, 4> numarare;
array<array<int, 5>, 4> rez;
int rec(const vector<vector<int>> &matrice, int i, int j) {
  if (i == matrice.size() || j == matrice[i].size()) {
    return 0;
  }
  if (rez[i][j] != 0) {
    return rez[i][j];
  }
  numarare[i][j]++;
  rez[i][j] =
      matrice[i][j] + max(rec(matrice, i + 1, j), rec(matrice, i, j + 1));
  return rez[i][j];
}
void nerec(const vector<vector<int>> &matrice, int i, int j) {
  int n = matrice.size() - 1, m = matrice[i].size() - 1;
  if (i == n && j == m) {
    rez[i][j] = matrice[i][j];
  } else if (i == n) {
    rez[i][j] = matrice[i][j] + rez[i][j + 1];
  } else if (j == m) {
    rez[i][j] = matrice[i][j] + rez[i + 1][j];
  } else {
    rez[i][j] = matrice[i][j] + max(rez[i + 1][j], rez[i][j + 1]);
  }
}
int main() {
  vector<vector<int>> matrice{
      {1, 2, 1, 1, 1}, {1, 1, 1, 1, 1}, {1, 1, 1, 1, 1}, {1000, 1, 1, 1, 1}};
  // cout << rec(matrice, 0, 0) << endl;
  // for (auto x : numarare) {
  //   for (auto y : x) {
  //     cout << y << " ";
  //   }
  //   cout << endl;
  // }
  for (int x = matrice.size() - 1; x >= 0; x--)
    for (int y = matrice[x].size() - 1; y >= 0; y--)
      nerec(matrice, x, y);

  cout << rez[0][0] << endl;
  for (auto x : rez) {
    for (auto y : x) {
      cout << y << " ";
    }
    cout << endl;
  }
  return 0;
}
