#define _USE_MATH_DEFINES
#include <algorithm>
#include <cmath>
#include <iostream>
#include <stack>
#include <vector>
#define infinit 1 << 30
using namespace std;

struct Lanturi {
  double x, y;
  bool lant;
};
struct Punct {
  double x, y;
};
struct Diagonala {
  Punct x, y;
};

int inauntru(vector<Punct> a, Lanturi P) {
  int i, cn = 0;
  for (i = 0; i < a.size(); i++) {
    if (i == a.size() - 1) {

      if ((P.y < a[i].y || P.y < a[0].y) &&
          ((P.x > a[i].x && P.x < a[0].x) || (P.x < a[i].x && P.x > a[0].x)))
        cn++;
    } else {

      if ((P.y < a[i].y || P.y < a[i + 1].y) &&
          ((P.x > a[i].x && P.x < a[i + 1].x) ||
           (P.x < a[i].x && P.x > a[i + 1].x)))
        cn++;
    }
  }
  return cn;
}
int cn_PnPoly(Lanturi P, vector<Punct> V) {
  int cn = 0; // the  crossing number counter

  // loop through all edges of the polygon
  for (int i = 0; i < V.size(); i++) { // edge from V[i]  to V[i+1]
    if (i == V.size() - 1) {
      if (((V[i].y <= P.y) && (V[0].y > P.y)) ||
          ((V[i].y > P.y) && (V[0].y <= P.y))) {
        // compute  the actual edge-ray intersect x-coordinate
        float vt = (float)(P.y - V[i].y) / (V[0].y - V[i].y);
        if (P.x < V[i].x + vt * (V[0].x - V[i].x)) // P.x < intersect
          ++cn; // a valid crossing of y=P.y right of P.x
      }
    } else if (((V[i].y <= P.y) && (V[i + 1].y > P.y)) ||
               ((V[i].y > P.y) && (V[i + 1].y <= P.y))) {
      // compute  the actual edge-ray intersect x-coordinate
      float vt = (float)(P.y - V[i].y) / (V[i + 1].y - V[i].y);
      if (P.x < V[i].x + vt * (V[i + 1].x - V[i].x)) // P.x < intersect
        ++cn; // a valid crossing of y=P.y right of P.x
    }
  }
  return (cn & 1); // 0 if even (out), and 1 if  odd (in)
}
double unghi(Lanturi a, Lanturi b, Lanturi c, vector<Punct> q) {
  Punct ba, bc;
  double cos, n;
  ba.x = b.x - a.x;
  ba.y = b.y - a.y;
  bc.x = b.x - c.x;
  bc.y = b.y - c.y;
  cos = ba.x * bc.x + ba.y * bc.y;
  n = sqrt(pow(ba.x, 2) + pow(ba.y, 2)) * sqrt(pow(bc.x, 2) + pow(bc.y, 2));
  cos = cos / n;
  if (cn_PnPoly(b, q))
    return 2 * M_PI - acos(cos);
  else
    return acos(cos);
}
bool sortare(Lanturi a, Lanturi b) {
  if (a.y > b.y)
    return 1;
  else if (a.y < b.y)
    return 0;
  else if (a.y == b.y && a.x < b.x)
    return 1;
  else
    return 0;
}
vector<Diagonala> Triangularizare(vector<Punct> V) {
  int Numar_de_puncte = V.size();
  int yMax = 0, yMin = infinit, PozYMax, PozYMin;
  stack<Lanturi> S;
  vector<Lanturi> VectorLocal;
  vector<Diagonala> Diagonale;
  for (int i = 0; i < Numar_de_puncte; i++) {
    if (yMax < V[i].y) {
      yMax = V[i].y;
      PozYMax = i;
    }
    if (yMin > V[i].y) {
      yMin = V[i].y;
      PozYMin = i;
    }
    VectorLocal.push_back(Lanturi{V[i].x, V[i].y, 0});
  }
  if (PozYMax > PozYMin)
    for (int i = PozYMin; i <= PozYMax; i++)
      VectorLocal[i].lant = 1;
  else
    for (int i = PozYMax; i <= PozYMin; i++)
      VectorLocal[i].lant = 1;
  sort(VectorLocal.begin(), VectorLocal.end(), sortare);

  S.push(Lanturi{VectorLocal[0].x, VectorLocal[0].y, VectorLocal[0].lant});
  S.push(Lanturi{VectorLocal[1].x, VectorLocal[1].y, VectorLocal[1].lant});

  for (int j = 2; j < Numar_de_puncte - 1; j++) {

    if (VectorLocal[j].lant != S.top().lant) {
      while (!S.empty()) {
        if (S.size() > 1) {
          Diagonale.push_back(
              Diagonala{Punct{VectorLocal[j].x, VectorLocal[j].y},
                        Punct{S.top().x, S.top().y}});
        }
        S.pop();
      }
      S.push(Lanturi{VectorLocal[j - 1].x, VectorLocal[j - 1].y,
                     VectorLocal[j - 1].lant});
      S.push(Lanturi{VectorLocal[j].x, VectorLocal[j].y, VectorLocal[j].lant});
    } else {
      Lanturi L{S.top()};
      S.pop();
      Lanturi L1 = S.top();
      while (!S.empty() && unghi(VectorLocal[j], L, L1, V) < M_PI) {
        L = S.top();
        S.pop();
        Diagonale.push_back(Diagonala{Punct{VectorLocal[j].x, VectorLocal[j].y},
                                      Punct{L.x, L.y}});
      }
      S.push(L);
      S.push(VectorLocal[j]);
    }
  }
  S.pop();
  while (S.size() > 1) {
    Diagonale.push_back(Diagonala{Punct{VectorLocal[Numar_de_puncte - 1].x,
                                        VectorLocal[Numar_de_puncte - 1].y},
                                  Punct{S.top().x, S.top().y}});
    S.pop();
  }
  S.pop();
  return Diagonale;
}
int main() {
  vector<Punct> poligon{{4, 5},  {8, 6},  {6, 4},  {5, 2}, {2, -1},
                        {9, -2}, {7, -4}, {1, -2}, {0, 0}, {1, 2}};
  auto diagonale = Triangularizare(poligon);
  for (auto x : diagonale)
    cout << x.x.x << " " << x.x.y << ", " << x.y.x << " " << x.y.y << endl;
  return 0;
}
