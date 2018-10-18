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
        orar.push_back(x);
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
  cout << endl;
  while (!mini.empty()) {
    cout << mini.top().val << " ";
    mini.pop();
  }
}
