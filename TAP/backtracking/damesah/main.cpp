#include <fstream>
#include <vector>
using namespace std;
ofstream q("damesah.out");
void rec(int &y, int linie, vector<int> &diag1, vector<int> &diag2,
         vector<int> &aparitii, vector<int> &v) {
  if (linie == aparitii.size())
    y++;
  if (linie == aparitii.size() && y == 1) {
    for (int x : v) {
      q << x + 1 << " ";
    }
    q << endl;
    return;
  }
  for (int coloana = 0; coloana < aparitii.size(); coloana++) {
    if (aparitii[coloana] == 1)
      continue;
    if (diag1[coloana + linie] == 1 ||
        diag2[aparitii.size() - 1 - coloana + linie] == 1)
      continue;

    v[linie] = coloana;
    aparitii[coloana] = 1;
    diag1[coloana + linie] = 1;
    diag2[aparitii.size() - 1 - coloana + linie] = 1;

    rec(y, linie + 1, diag1, diag2, aparitii, v);

    aparitii[coloana] = 0;
    diag1[coloana + linie] = 0;
    diag2[aparitii.size() - 1 - coloana + linie] = 0;
  }
}
int main() {
  ifstream f("damesah.in");
  int N;
  f >> N;
  vector<int> diag1(2 * N - 1, 0);
  vector<int> diag2(2 * N - 1, 0);
  vector<int> aparitii(N, 0);
  vector<int> v(N);
  int x = 0;
  rec(x, 0, diag1, diag2, aparitii, v);
  q << x;
}
