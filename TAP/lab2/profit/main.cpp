#include <algorithm>
#include <iostream>
#include <unordered_map>
#include <vector>
using namespace std;
struct activitate {
  int profit, termen, ordine;
};
int main() {
  vector<activitate> activitati{{4, 3, 1}, {1, 1, 2}, {2, 1, 3}, {5, 3, 4}};
  sort(activitati.begin(), activitati.end(),
       [](const activitate &a, const activitate &b) {
         if (a.profit == b.profit) {
           return a.termen > b.termen;
         }
         return a.profit > b.profit;
       });
  unordered_map<int, activitate> orar;
  unordered_map<int, int> pozitie;
  int sum = 0;
  for (auto x : activitati) {
    if (orar[x.termen].ordine != 0) {
      if (pozitie[x.termen] != 0) {
        if (pozitie[x.termen] == 1)
          continue;
        pozitie[x.termen]--;
        orar[pozitie[x.termen]] = x;
        sum += x.profit;
        continue;
      }
    }
    pozitie[x.termen] = x.termen;
    orar[x.termen] = x;
    sum += x.profit;
  }
  cout << sum << endl;
  for (auto x : orar)
    cout << x.second.ordine << " ";
}
