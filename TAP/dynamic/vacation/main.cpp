// https://atcoder.jp/contests/dp/tasks/dp_c
#include <iostream>
#include <vector>
using namespace std;

int main() {
  vector<int> a, b, c;
  int n;
  cin >> n;
  for (auto i = 0; i < n; i++) {
    int x, y, z;
    cin >> x >> y >> z;
    a.push_back(x);
    b.push_back(y);
    c.push_back(z);
  }
  int dp[n][3];
  dp[0][0] = a[0];
  dp[0][1] = b[0];
  dp[0][2] = c[0];

  for (auto i = 1; i < n; i++) {
    dp[i][0] = max(dp[i - 1][1], dp[i - 1][2]) + a[i];
    dp[i][1] = max(dp[i - 1][0], dp[i - 1][2]) + b[i];
    dp[i][2] = max(dp[i - 1][0], dp[i - 1][1]) + c[i];
  }
  cout << max(max(dp[n - 1][0], dp[n - 1][1]), dp[n - 1][2]);
}
