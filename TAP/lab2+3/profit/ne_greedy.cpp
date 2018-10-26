// Problema 7(metoda ne-greedy)
#include <algorithm>
#include <iostream>
#include <list>
#include <queue>
#include <vector>
using namespace std;
struct activitate {
  int profit, termen, ordine;
};
struct minim {
  int val;
  list<activitate>::iterator it;
  bool operator()(const minim &a, const minim &b) { return a.val > b.val; }
};

int main() {
  vector<activitate> activitati{{7, 4, 1}, {9, 6, 2},  {10, 4, 3},
                                {9, 1, 4}, {11, 4, 5}, {7, 6, 6}};
  sort(activitati.begin(), activitati.end(),
       [](const activitate &a, const activitate &b) {
         if (a.termen == b.termen) {
           return a.profit < b.profit;
         }
         return a.termen < b.termen;
       });
  int sum = 0;
  list<activitate> orar;
  priority_queue<minim, vector<minim>, minim> mini;
  for (auto x : activitati) {
    if (orar.empty()) {
      orar.push_back(x);
      auto ptr = orar.end();
      ptr--;
      mini.push(minim{x.profit, ptr});
      sum += x.profit;
    } else {
      if (orar.back().termen < x.termen) {
        orar.push_back(activitate{x.profit, orar.back().termen + 1, x.ordine});
        auto ptr = orar.end();
        ptr--;
        mini.push(minim{x.profit, ptr});
        sum += x.profit;
      } else {
        sum -= mini.top().val;
        orar.erase(mini.top().it);
        mini.pop();
        orar.push_back(x);
        auto ptr = orar.end();
        ptr--;
        mini.push(minim{x.profit, ptr});
        sum += x.profit;
      }
    }
  }
  cout << sum << endl;
  for (auto x : orar)
    cout << x.ordine << " ";
}
