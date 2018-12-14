#include <iostream>
#include <vector>
using namespace std;
void rec(int poz, int n, vector<int> &v) {
  if (poz == n) {
    for (auto x : v) {
      cout << x << " ";
    }
    cout << endl;
    return;
  }
  v.push_back(0);
  rec(poz + 1, n, v);
  v.pop_back();
  v.push_back(1);
  rec(poz + 1, n, v);
  v.pop_back();
}
int main() {
  vector<int> v;
  rec(0, 5, v);
}
