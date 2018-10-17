#include <algorithm>
#include <iostream>
#include <unordered_map>
#include <vector>
using namespace std;
struct activitate {
  int profit, termen, ordine;
};
int main() {
  vector<activitate> activitati{
      {100, 2, 1}, {19, 1, 2}, {27, 2, 3}, {25, 1, 4}, {15, 3, 5}};
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
  // for (auto x : activitati)
  //   cout << x.profit << " " << x.termen << endl;
  for (auto x : activitati) {
    if (orar[x.termen].ordine != 0) {
      if (pozitie[x.termen] != 0) {
        if (pozitie[x.termen] == 1)
          continue;
        pozitie[x.termen]--;
        orar[pozitie[x.termen]] = x;
        cout << x.profit << " " << pozitie[x.termen] << endl;
        sum += x.profit;
      }
    } else {
      pozitie[x.termen] = x.termen;
      orar[x.termen] = x;
      cout << x.profit << " " << pozitie[x.termen] << endl;
      sum += x.profit;
    }
  }
  cout << sum << endl;
  for (auto x : orar)
    cout << x.second.profit << " " << x.second.termen << endl;
}
