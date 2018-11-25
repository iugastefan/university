#include <fstream>
#include <vector>
using namespace std;
void numara(vector<vector<int>> &matrice, int i, int j, vector<int> &dp) {
  if (i == 0 || j == 0) {
    if (matrice[i][j] != 0) {
      dp[0]++;
    }
    return;
  }
  if (matrice[i][j] != 0) {
    matrice[i][j] =
        min(min(matrice[i - 1][j], matrice[i][j - 1]), matrice[i - 1][j - 1]) +
        1;
    dp[matrice[i][j] - 1]++;
  }
}
int main() {
  ifstream f("custi.in");
  int n;
  f >> n;
  if (n > 1000)
    return 0;
  vector<vector<int>> matrice(n, vector<int>(n, 0));
  vector<int> dp(n);
  for (int i = 0; i < n; i++)
    for (int j = 0; j < n; j++) {
      f >> matrice[i][j];
    }
  for (int x = 0; x < n; x++)
    for (int y = 0; y < n; y++)
      numara(matrice, x, y, dp);
  ofstream k("custi.out");
  for (int i = n - 2; i >= 0; i--) {
    dp[i] += dp[i + 1];
  }
  k << dp[0];
  for (int i = 1; i < n; i++)
    k << endl << dp[i];
  return 0;
}
