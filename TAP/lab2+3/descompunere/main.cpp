// Problema 8
// cautare binara
#include <iostream>
#include <vector>

using namespace std;

void cauta(vector<vector<int>> &gramada, vector<vector<int>>::iterator st,
           vector<vector<int>>::iterator dr, int carte) {
  const int size = dr - st;
  if (size == 0) {
    if (carte < (*st).back())
      (*st).push_back(carte);
    else
      gramada.push_back(vector<int>{carte});
  } else if (size == 1) {
    if (carte < (*st).back())
      (*st).push_back(carte);
    else if (carte < (*dr).back())
      (*dr).push_back(carte);
    else
      gramada.push_back(vector<int>{carte});
  } else {
    const vector<vector<int>>::iterator mij = st + size / 2;
    if (carte < (*mij).back())
      cauta(gramada, st, mij, carte);
    else
      cauta(gramada, mij + 1, dr, carte);
  }
}
int main() {
  vector<int> pachet{11, 13, 10, 15, 12, 7};
  vector<vector<int>> gramada;
  for (auto carte : pachet) {
    if (gramada.empty())
      gramada.push_back(vector<int>{carte});
    else {
      cauta(gramada, gramada.begin(), gramada.end() - 1, carte);
    }
  }
  for (auto x : gramada) {
    for (auto y : x)
      cout << y << " ";
    cout << endl;
  }
}
