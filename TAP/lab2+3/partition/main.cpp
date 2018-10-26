// Problema 3
#include <algorithm>
#include <iostream>
#include <queue>
#include <vector>
using namespace std;
struct interval {
  int inceput, sfarsit;
};
struct minim {
  int pozitie, valoare;
};
int main() {
  vector<interval> intervale{{5, 10}, {7, 8}, {9, 11}, {1, 3}, {2, 6}, {4, 5}};
  sort(intervale.begin(), intervale.end(),
       [](const interval &a, const interval &b) {
         return a.inceput < b.inceput;
       });

  vector<vector<interval>> sali;
  auto cmp = [](const minim &a, const minim &b) {
    return a.valoare > b.valoare;
  };
  priority_queue<minim, vector<minim>, decltype(cmp)> minim(cmp);
  minim.push({-1, -1});
  for (auto x : intervale) {
    if (minim.top().valoare == -1) {
      sali.push_back(vector<interval>{x});
      minim.pop();
      minim.push({0, x.sfarsit});
      continue;
    }
    if (minim.top().valoare <= x.inceput) {
      auto poz = minim.top().pozitie;
      sali.at(poz).push_back(x);
      minim.pop();
      minim.push({poz, x.sfarsit});
    } else {
      sali.push_back(vector<interval>{x});
      auto poz = int(sali.size());
      poz--;
      minim.push({poz, x.sfarsit});
    }
  }
  for (auto x : sali) {
    if (!x.empty()) {
      for (auto y : x)
        cout << "[" << y.inceput << "," << y.sfarsit << "] ";
      cout << endl;
    }
  }
}
