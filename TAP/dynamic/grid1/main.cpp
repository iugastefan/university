// https://atcoder.jp/contests/dp/tasks/dp_h
#include <iostream>
#include <vector>
using namespace std;

int main() {
  int i, j;
  vector<vector<char>> grid = {
      {
          '.',
          '.',
          '.',
          '#',
      },
      {
          '.',
          '#',
          '.',
          '.',
      },
      {
          '.',
          '.',
          '.',
          '.',
      },
  };
  i = 3;
  j = 4;

  // cin >> i >> j;
  // grid.reserve(i);
  // for (auto x : grid) {
  //   x.reserve(j);
  // }
  // for (auto x : grid)
  //   for (auto y : x)
  //     cin >> y;

  // vector<vector<int>> dp;
  // dp.reserve(i);
  // for (auto x : dp) {
  //   x.reserve(j);
  // }
  int dp[i][j];
  for (auto x = 0; x < i; x++)
    for (auto y = 0; y < j; y++)
      dp[i][j] = 0;
  dp[0][0] = 1;
  for (auto x = 0; x < i; x++) {
    for (auto y = x == 0 ? 1 : 0; y < j; y++) {
      if (grid[x][y] == '.') {
        dp[x][y] = x != 0 && y != 0
                       ? dp[x - 1][y] != 0 && dp[x][y - 1] != 0
                             ? max(dp[x - 1][y], dp[x][y - 1]) + 1
                             : dp[x][y - 1] == 0
                                   ? dp[x - 1][y] + 1
                                   : dp[x - 1][y] ? dp[x][y - 1] + 1 : 0
                       : 0;
      } else {
        dp[x][y] = 0;
        break;
      }
    }
  }
  cout << dp[i - 1][j - 1]<<endl;
  for (auto x = 0; x < i; x++) {
    for (auto y = 0; y < j; y++)
      cout << dp[x][y]<<" ";
    cout<<endl;
  }
}
