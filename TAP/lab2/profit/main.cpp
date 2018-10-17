#include <algorithm>
#include <iostream>
#include <list>
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
         if (a.termen == b.termen) {
           return a.profit < b.profit;
         }
         return a.termen < b.termen;
       });
  int sum = 0;
  list<activitate> orar;
  for (auto x : activitati) {
    if (orar.empty()) {
      orar.push_back(x);
      sum += x.profit;
    } else {
      if (orar.back().termen < x.termen) {
        orar.push_back(x);
        sum += x.profit;
      } else {
        orar.push_back(x);
        sum += x.profit;
        sum -= orar.front().profit;
        orar.pop_front();
      }
    }
  }
  cout << sum << endl;
  for (auto x : orar)
    cout << x.ordine << " ";
}
