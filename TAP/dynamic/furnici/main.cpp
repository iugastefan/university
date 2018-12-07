#include <algorithm>
#include <fstream>
#include <iostream>
#include <vector>
using namespace std;

// void calc(int n, int dp[][1000], int suma, int w[]) {
//   for (int i = 1; i <= n; i++) {
//     if (6 * w[i] >= suma - w[i])
//       dp[i][suma] = max(dp[i - 1][suma], w[i] +)
//   }
// }
int main() {
  ifstream f("furnici.in");
  int n;
  f >> n;
  int dp[n + 1][7001];

  // dp[i][j] = numarul maxim de furnici pe care le putem selecta din primele i
  // (1, 2, .. i) daca ele au suma j

  dp[0][0] = 0;

  for (int i = 0; i <= n; i += 1)
    for (int j = 0; j <= 7000; j += 1)
      dp[i][j] = 0;

  int w[n + 1];
  for (int i = 0; i <= n; i++)
    w[i] = 0;
  for (int i = 1; i <= n; i++)
    f >> w[i];

  for (int i = 0; i < n; i += 1)
    for (int j = 0; j <= 7000; j += 1) {
      // -> dp[i + 1][j] inseamna ca nu adaugam furnica i + 1 nicaieri, doar
      // luam solutia pentru primele i
      dp[i + 1][j] = max(dp[i][j], dp[i + 1][j]);
      if (w[i + 1] * 6 >= j)
        dp[i + 1][j + w[i + 1]] = max(dp[i][j] + 1, dp[i + 1][j + w[i + 1]]);
    }
  int m = 0;
  for (int i = 0; i <= 7000; i++) {
    if (dp[n][i] > m)
      m = dp[n][i];
    // cout << dp[n][i] << " ";
  }
  cout << m;
}
