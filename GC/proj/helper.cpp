#include "helper.h"

int cn_PnPoly(Punct P, vector<Punct> V) {
  int cn = 0; // the  crossing number counter

  // loop through all edges of the polygon
  for (size_t i = 0; i < V.size(); i++) { // edge from V[i]  to V[i+1]
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
double unghi(Punct a, Punct b, Punct c, const vector<Punct> &q) {
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
bool operator<(const Punct &p1, const Punct &p2) {
  return tie(p1.x, p1.y) < tie(p2.x, p2.y);
}
bool operator<(const Segment &s1, const Segment &s2) {}
