// Problema 1
#include <iostream>
#include <vector>
using namespace std;

int gaseste(const vector<int> &munte, vector<int>::iterator a,
            vector<int>::iterator b) {
  const int size = b - a;
  if (size == 0) {
    return *a;
  } else if (size == 1) {
    if (*a < *b)
      return *b;
    return *a;
  } else {
    const vector<int>::iterator mij = a + size / 2 - 1;
    if ((*mij < *(mij + 1)))
      return gaseste(munte, mij + 1, b);
    else
      return gaseste(munte, a, mij);
  }
}
int main() {
  vector<int> munte{4, 8, 10, 11, 5, 2};
  cout << gaseste(munte, munte.begin(), munte.end());
}
