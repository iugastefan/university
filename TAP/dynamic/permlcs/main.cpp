#include <algorithm>
#include <fstream>
#include <iostream>
#include <list>
#include <vector>
using namespace std;
int cmmsc(vector<int> v, vector<int> &dp) {
  int s = v.size();
  for (auto i = 0; i < s; i++) {
    int pos = -1;
    for (auto j = 0; j < i; j++)
      if (v[i] > v[j] && dp[j] > pos) {
        pos = dp[j];
      }
    dp[i] = 1 + pos;
  }
  auto w = dp[0];
  for (auto x : dp) {
    if (x > w)
      w = x;
  }
  return w;
}

int main() {
  // fstream f("permlcs.in");
  // int n, m;
  // f >> n >> m;
  // vector<int> temp(n + 1);
  // vector<int> raspuns;
  // for (auto i = 1; i < n + 1; i++) {
  //   int x;
  //   f >> x;
  //   temp[x] = i;
  //   raspuns.push_back(x);
  // }
  // int x;
  // f >> x;
  // for (auto i = 1; i < n + 1; i++) {
  //   int y;
  //   f >> y;
  //   if (temp[x] > temp[y]) {
  //     auto pos = find(raspuns.begin(), raspuns.end(), x);
  //     if (pos != raspuns.end())
  //       raspuns.erase(pos);
  //   }
  //   f >> x;
  // }
  // for (auto w : raspuns) {
  //   cout << w << " ";
  // }
  vector<int> v{24, 12, 15, 15, 19, 11};
  vector<int> dp(v.size(), 0);
  cout << cmmsc(v, dp);
}
