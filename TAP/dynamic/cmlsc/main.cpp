#include <fstream>
#include <vector>
using namespace std;

int main() {
  ifstream f("cmlsc.in");
  ofstream v("cmlsc.out");
  int n, m;
  f >> n >> m;
  vector<vector<int>> matrice(n + 1, vector<int>(m + 1));
  vector<int> sir1(n + 1), sir2(m + 1);
  for (auto i = 1; i < n + 1; i++)
    f >> sir1[i];
  for (auto i = 1; i < m + 1; i++)
    f >> sir2[i];
  for (auto x = 1; x < n + 1; x++) {
    for (auto y = 1; y < m + 1; y++) {
      matrice[x][y] = max(matrice[x - 1][y], matrice[x][y - 1]);
      if (sir1[x] == sir2[y])
        matrice[x][y] = matrice[x - 1][y - 1] + 1;
    }
  }
  int i = matrice[n][m];
  vector<int> raspuns;
  int x = n, y = m;
  while (i > 0) {
    if (matrice[x][y] > matrice[x - 1][y] &&
        matrice[x][y] > matrice[x][y - 1]) {
      if (matrice[x - 1][y] > matrice[x][y - 1])
        raspuns.push_back(sir1[x]);
      else
        raspuns.push_back(sir2[y]);
      i--;
      x--;
      y--;
    } else {
      if (matrice[x - 1][y] > matrice[x][y - 1])
        x--;
      else
        y--;
    }
  }
  v << raspuns.size() << endl;
  for (auto w = raspuns.rbegin(); w < raspuns.rend(); w++)
    v << *w << " ";
}
