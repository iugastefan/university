#include <algorithm>
#include <iostream>
#include <map>
#include <vector>
using namespace std;
struct furnica {
  int marime;
  int masa;
};
int gaseste(int w[], furnica x, int y) {
  if (y == 1) {
    int max = 0;
    for (int i = 1; i < x.marime; i++)
      if (w[i] <= x.masa * 6 && w[i] > max)
        max = w[i];
    return max;
  }
  for (int i = 1; i < x.marime; i++)

}
int main() {
  int t;
  cin >> t;
  for (int i = 1; i <= t; i++) {
    int n;
    cin >> n;
    int w[n + 1];
    for (int i = 0; i <= n; i++)
      w[i] = 0;
    vector<map<int, int>> dp(n + 1);
    for (int i = 1; i <= n; i++) {
      cin >> w[i];
      dp[1][w[i]] = 1;
    }
    for (int i = 2; i <= n; i++)
      for (int j = i; j <= n; j++)
      // for (auto x : dp[i - 1]) {
      //   dp[i][x.first] = max(dp[i - 1][x.first], dp[i][x.first]);
      //   if (w[i] * 6 >= x.first)
      //     dp[i][x.first + w[i]] =
      //         max(dp[i - 1][x.first] + 1, dp[i][x.first + w[i]]);
      // }
      {
        for (auto x : dp[i - 1])
          if (w[j] * 6 >= x.first)
            dp[i][x.first + w[j]] = x.second + 1;
      }

    for (int i = 1; i <= n; i += 1) {
      for (auto x : dp[i])
        cout << x.first << " " << x.second << " ";
      cout << endl;
    }
    int m = 0;
    for (auto x : dp[n])
      if (x.second > m)
        m = x.second;
    cout << "Case #" << i << ": " << m << endl;
  }
}
