#include <iostream>
#include <math.h>
using namespace std;
struct punct {
  float x, y;
};
struct vector {
  float x, y;
};
vector calcVector(punct p1, punct p2) {
  return vector{p1.x - p2.x, p1.y - p2.y};
}
float myround(float x, float unit) { return round(x / unit) * unit; }
float dotproduct(vector v1, vector v2) { return v1.x * v2.x + v1.y * v2.y; }
float norma(vector v) { return sqrt(pow(v.x, 2) + pow(v.y, 2)); }
float cos(vector v1, vector v2) {
  return dotproduct(v1, v2) / (norma(v1) * norma(v2));
}
void problA(punct p1, punct p2, punct p3, punct p4) {
  auto v21 = calcVector(p2, p1);
  auto v23 = calcVector(p2, p3);
  auto v41 = calcVector(p4, p1);
  auto v43 = calcVector(p4, p3);
  auto angle = acos(cos(v21, v23)) + acos(cos(v41, v43));
  if (angle == M_PI)
    cout << "Punctul se afla pe cerc\n";
  else {
    if (angle < M_PI)
      cout << "Punctul se afla in interiorul cercului\n";
    else
      cout << "Punctul se afla in exteriorul cercului\n";
  }
}
void problB(punct p1, punct p2, punct p3, punct p4) {
  auto v12 = calcVector(p1, p2);
  auto v23 = calcVector(p2, p3);
  auto v14 = calcVector(p1, p4);
  auto v34 = calcVector(p3, p4);
  auto n12 = norma(v12);
  auto n23 = norma(v23);
  auto n14 = norma(v14);
  auto n34 = norma(v34);
  if ((myround(n12, 0.05) + myround(n34, 0.05)) ==
      (myround(n14, 0.05) + myround(n23, 0.05)))
    cout << "Este circumscriptibil\n";
  else
    cout << "Nu este circumscriptibil\n";
}
int main() {
  auto p1 = punct{0, 0}, p2 = punct{2, -1}, p3 = punct{4, 0}, p4 = punct{0, 4};
  problA(p1, p2, p3, p4);
  problB(p1, p2, p3, p4);
  return 0;
}
