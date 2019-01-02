#include "stefan.cpp"
#include <fstream>
#include <iostream>
#include <vector>
using namespace std;

double scalar(Punct p1, Punct p2) { return p1.x * p2.y - p1.y * p2.x; }
Punct scadere(Punct p1, Punct p2) { return Punct{p1.x - p2.x, p1.y - p2.y}; }
bool apartine(vector<Punct> polygon, Punct p) {
  Punct a = polygon[0], b = polygon[1], c = polygon[2];
  b = scadere(b, a);
  c = scadere(c, a);
  p = scadere(p, a);
  double d = scalar(b, c);
  double wa =
      (p.x * (b.y - c.y) + p.y * (c.x - b.x) + b.x * c.y - c.x * b.y) / d;
  double wb = (p.x * c.y - p.y * c.x) / d;
  double wc = (p.y * b.x - p.x * b.y) / d;
  if (wa >= 0 && wa <= 1 && wb >= 0 && wb <= 1 && wc >= 0 && wc <= 1)
    return true;
  return false;
}
vector<Punct> gaseste(vector<vector<Punct>> poligoane, Punct p) {
  for (auto x : poligoane) {
    if (apartine(x, p))
      return x;
  }
  return vector<Punct>{{0, 0}, {0, 0}, {0, 0}};
}
int main() {
  ifstream file("poly.in");
  int n;
  file >> n;
  vector<Punct> polygon;
  for (auto i = 0; i < n; i++) {
    double x, y;
    file >> x >> y;
    polygon.push_back(Punct{x, y});
  }
  Punct p;
  file >> p.x >> p.y;
  // for (auto p : polygon) {
  //   cout << p.x << " " << p.y << endl;
  // }
  // cout << apartine(polygon, p);
  // vector<Punct> poligon{{4, 5},  {0, 3},  {4, 7},  {7, 8}, {8, 6},
  //                       {6, 4},  {8, 2},  {5, -1}, {5, 2}, {2, -1},
  //                       {9, -2}, {7, -4}, {1, -2}, {0, 0}, {1, 2}};
  vector<Punct> poligon{{4, 6},  {6, 7}, {10, 5}, {6, 2},  {2, 6}, {6, 10},
                        {13, 5}, {6, 0}, {5, 1},  {11, 5}, {6, 8}, {3, 6},
                        {6, 3},  {8, 5}, {6, 6},  {6, 4}};
  vector<vector<Punct>> poligoane_monotone;
  auto iancu = ian(poligon);
  for (auto x : iancu) {
    if (x.size() != 0)
      poligoane_monotone.push_back(vector<Punct>{});
    for (auto y : x)
      poligoane_monotone.back().push_back(poligon[y]);
    // cout << char('A' + x[0]) << char('A' + x.back());
    // cout << char('A' + y) << " ";
  }
  for (auto x : iancu) {
    for (auto y : x)
      cout << char('A' + y) << " ";
    cout << endl;
    // cout << char('A' + y) << " ";
    cout << endl;
  }
  // for (auto x : poligoane_monotone) {
  //   for (auto y : x)
  //     cout << y.x << " " << y.y << ", ";
  //   cout << endl;
  // }
  for (auto x : poligoane_monotone) {
    auto diagonale = Triangularizare(x);
    for (auto x : diagonale)
      cout << x.x.x << " " << x.x.y << ", " << x.y.x << " " << x.y.y << endl;
    cout << endl << endl;
  }
  // auto diagonale = Triangularizare(poligon);
  // for (auto x : diagonale)
  //   cout << x.x.x << " " << x.x.y << ", " << x.y.x << " " << x.y.y <<
  //   endl;

  // auto poligoane_monotone = iancu(polygon);
  // auto triungiuri = stefan(poligoane_monotone);
  // auto triunghi_cu_punct = gaseste(triungiuri, p);
  // int eroare = 0;
  // for (auto x : triunghi_cu_punct) {
  //   if (x.x == 0 && x.y == 0)
  //     eroare++;
  // }
  // if (eroare == 3)
  //   cout << "Eroare";
  // else
  //   for (auto x : triunghi_cu_punct)
  //     cout << x.x << " " << x.y << endl;
}
