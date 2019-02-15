// https://atcoder.jp/contests/dp/tasks/dp_b
#include <iostream>
#include <math.h>
#include <vector>
using namespace std;

int main() {
  int n;
  cin >> n;
  int k;
  cin >> k;
  vector<int> h;
  for (auto i = 0; i < n; i++) {
    int x;
    cin >> x;
    h.push_back(x);
  }
  int dp[n];
  dp[0] = 0;
  for (auto x = 1; x < n; x++) {
    int mini = INT32_MAX;
    int w = k;
    for (auto y = x - w; y < x; y++) {
      if (y < 0)
        continue;
      if (abs(h[y] - h[x]) + dp[y] < mini) {
        mini = abs(h[y] - h[x]) + dp[y];
      }
    }
    dp[x] = mini;
  }
  cout << dp[n - 1];
}
