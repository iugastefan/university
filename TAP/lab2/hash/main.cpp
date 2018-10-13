#include <cmath>
#include <iostream>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <vector>
using namespace std;

int main() {
  vector<string> f1{"primul", "laborator", "primul", "exercitiu"},
      f2{"primul", "exercitiu", "usor"};
  unordered_map<string, int> v1, v2;
  unordered_set<string> c;
  for (auto x : f1) {
    v1[x]++;
    c.insert(x);
  }
  for (auto x : f2) {
    v2[x]++;
    c.insert(x);
  }
  int sum = 0;
  int m1 = 0, m2 = 0;
  for (auto x : c) {
    sum += v1[x] * v2[x];
    m1 += v1[x] * v1[x];
    m2 += v2[x] * v2[x];
  }
  double calcul = sum / (sqrt(m1) * sqrt(m2));
  cout << calcul;
}
