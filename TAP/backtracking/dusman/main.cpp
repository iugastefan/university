#include <algorithm>
#include <fstream>
#include <iostream>
#include <vector>
using namespace std;
ofstream q("dusman.out");
void rec(int &a_cata, int k, const vector<vector<int>> &dusman, vector<int> &v,
         vector<int> &aparitii) {
  if (a_cata == k) {
    for (auto x : v) {
      q << x << " ";
    }
    exit(0);
  }
  for (auto x = 1; x < dusman.size(); x++) {
    if (aparitii[x] == 1)
      continue;
    if (v.size() != 0)
      if (find(dusman[v.back()].begin(), dusman[v.back()].end(), x) !=
          dusman[v.back()].end())
        continue;
    v.push_back(x);
    aparitii[x] = 1;
    if (v.size() == dusman.size() - 1) {
      a_cata++;
    }
    rec(a_cata, k, dusman, v, aparitii);
    aparitii[v.back()] = 0;
    v.pop_back();
  }
}
int main() {
  ifstream f("dusman.in");
  int n, k, m;
  f >> n >> k >> m;
  vector<vector<int>> dusman(n + 1);
  vector<int> aparitii(n + 1);
  for (int i = 0; i < m; i++) {
    int x, y;
    f >> x >> y;
    dusman[x].push_back(y);
    dusman[y].push_back(x);
  }
  vector<int> v;
  int x = 0;
  rec(x, k, dusman, v, aparitii);
}
