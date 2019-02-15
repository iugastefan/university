#include <fstream>
#include <iostream>
#include <vector>
using namespace std;
ifstream f("C-small-practice.in");
ofstream g("C-small-practice.out");

int main() {

  int T;
  f >> T;
  int l = 0;
  for (int i = 1; i <= T; i++) {
    int x;
    f >> x;
    int w;
    f >> w;
    vector<int> cresc;
    vector<int> desc;
    cresc.push_back(w);
    int m = 0, M = 0;
    for (int j = 1; j < x; j++) {
      int z;
      f >> z;
      if (z > cresc.back())
        cresc.push_back(z);
      else
        desc.push_back(z);
    }
    m = desc.size();
    M = cresc.size();
    if (abs(m - M) < x / 2) {
      g << "Case #" << i << ": GOOD" << endl;
      l++;
    } else
      g << "Case #" << i << ": BAD" << endl;
  }
  cout << l;
  return 0;
}
