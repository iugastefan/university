#include <iostream>
#include <map>
#include <vector>
using namespace std;

int main() {
  vector<int> valori{1, 3, 9, 27, 54};
  map<int, int, greater<int>> monede;
  int suma = 35;
  for (auto it = valori.rbegin(); it != valori.rend(); it++) {
    while (suma >= *it) {
      monede[*it]++;
      suma -= *it;
    }
  }
  for (auto x : monede) {
    cout << x.second << " monede de " << x.first << endl;
  }
}
