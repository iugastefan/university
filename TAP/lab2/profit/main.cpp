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
  for (auto x : activitati)
    cout << x.profit << " " << x.termen << endl;
  unordered_map<int, activitate> orar;
  for (auto x : activitati) {
  }
}
