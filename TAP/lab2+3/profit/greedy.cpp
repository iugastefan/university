#include <algorithm>
#include <iostream>
#include <map>
#include <queue>

using namespace std;
struct activitate {
  int profit, termen, ordine;
  bool operator()(const activitate &a, const activitate &b) {
    return a.profit > b.profit;
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
  for(auto x:activitati)cout<<x.ordine<<" ";
  map<int, vector<activitate>> map_activ;
  int loc = activitati.front().termen;
  vector<activitate> orar(loc);
  for (auto x : activitati) {
    map_activ[x.termen].push_back(x);
  }
  // for (auto x : map_activ) {
  //   cout << endl << x.first << ": ";
  //   for (auto y : x.second)
  //     cout << y.ordine << " ";
  // }
  priority_queue<activitate, vector<activitate>, activitate> max_activ;
  int sum = 0;
  for (auto x = map_activ.rbegin(); x != map_activ.rend(); x++) {
    for (auto y : x->second)
      max_activ.push(y);
    loc--;
    orar[loc] = max_activ.top();
    sum += max_activ.top().profit;
    max_activ.pop();
  }
  cout << sum << endl;
  for (auto x : orar)
    cout << x.ordine << " ";
}
