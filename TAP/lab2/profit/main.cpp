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
      {100, 4, 1}, {199, 1, 2}, {27, 2, 3}, {25, 2, 4}, {150, 4, 5}};
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
        if (x.profit > orar.front().profit) {
          orar.push_back(x);
          sum += x.profit;
          sum -= orar.front().profit;
          orar.pop_front();
        } else {
          sum -= orar.back().profit;
          orar.pop_back();
          orar.push_back(x);
          sum += x.profit;
        }
      }
    }
  }
  cout << sum << endl;
  for (auto x : orar)
    cout << x.ordine << " ";
}
