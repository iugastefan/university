#include <algorithm>
#include <array>
#include <iostream>
#include <map>
#include <queue>

using namespace std;
struct activitate {
  int profit, termen, ordine;
  bool operator()(const activitate &a, const activitate &b) {
    return a.profit < b.profit;
  }
};

int main() {
  vector<activitate> activitati{{7, 4, 1}, {9, 6, 2},  {10, 4, 3},
                                {9, 1, 4}, {11, 4, 5}, {7, 6, 6}};
  sort(activitati.begin(), activitati.end(),
       [](const activitate &a, const activitate &b) {
         if (a.termen == b.termen) {
           return a.profit > b.profit;
         }
         return a.termen > b.termen;
       });
  map<int, vector<activitate>> map_activ;
  int loc = activitati.front().termen;
  array<activitate, 6> orar;
  for (auto x : activitati) {
    map_activ[x.termen].push_back(x);
  }
  priority_queue<activitate, vector<activitate>, activitate> max_activ;
  int sum = 0;
  auto it = map_activ.rbegin();
  while (loc) {
    if (it != map_activ.rend() && it->second.back().termen >= loc) {
      for (auto x : it->second)
        max_activ.push(x);
      it++;
    }
    loc--;
    orar[loc] = max_activ.top();
    sum += orar[loc].profit;
    max_activ.pop();
  }
  cout << endl;
  for (auto x : orar) {
    cout << x.ordine << " ";
  }
}
