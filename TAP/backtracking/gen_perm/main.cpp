#include <iostream>
#include <vector>
using namespace std;
void rec(int poz, int n, vector<int> &v, vector<int> &aparitii) {
  if (poz == n) {
    for (auto x : v) {
      cout << x << " ";
    }
    cout << endl;
    return;
  }
  for (auto x = 1; x <= n; x++) {
    if (aparitii[x] == 1)
      continue;
    v.push_back(x);
    aparitii[x] = 1;
    rec(poz + 1, n, v, aparitii);
    aparitii[v.back()] = 0;
    v.pop_back();
  }
}
int main() {
  vector<int> v;
  int n = 4;
  vector<int> aparitii(n + 1);
  rec(0, n, v, aparitii);
}
