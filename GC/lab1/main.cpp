#include <iostream>
#include <limits>
#include <vector>
using namespace std;

double maxim = numeric_limits<double>::max();
struct punct {
  double x, y, z;
};

bool diferite(const punct &p1, const punct &p2) {
  return (p1.x != p2.x || p1.y != p2.y || p1.z != p2.z);
}

bool diferite(const punct &p1, const punct &p2, const punct &p3) {
  return (diferite(p1, p2) && diferite(p2, p3) && diferite(p1, p3));
}

struct dreapta {
  double x, y, z;
  dreapta(const punct &p1, const punct &p2)
      : x{p2.x - p1.x}, y{p2.y - p1.y}, z{p2.z - p1.z} {}
};

double raport(const dreapta &d1, const dreapta &d2) {
  double rx = maxim, ry = maxim, rz = maxim;
  if (d2.x != 0 && d1.x != 0) {
    rx = d1.x / d2.x;
    if (rx * d2.y == d1.y && rx * d2.z == d1.z)
      return rx;
    return maxim;
  }
  if (d2.y != 0 && d1.y != 0) {
    ry = d1.y / d2.y;
    if (ry * d2.z == d1.z)
      return ry;
    return maxim;
  }
  if (d2.z != 0 && d1.z != 0) {
    rz = d1.z / d2.z;
    return rz;
  }
  return maxim;
}
void afis_puncte(const punct &p1, const punct &p2, const punct &p3) {
  cout << endl << "A1 = (" << p1.x << "," << p1.y << "," << p1.z << ") ";
  cout << "A2 = (" << p2.x << "," << p2.y << "," << p2.z << ") ";
  cout << "A3 = (" << p3.x << "," << p3.y << "," << p3.z << ")" << endl;
}
void ex_a(const punct &p1, const punct &p2, const punct &p3) {
  const dreapta d12(p1, p2), d23(p2, p3);
  afis_puncte(p1, p2, p3);
  if (diferite(p1, p2, p3) == false) {
    cout << "Puncte identice" << endl;
    return;
  }
  if (raport(d12, d23) != maxim) {
    cout << "Sunt coliniare" << endl;
    return;
  }
  cout << "Nu sunt coliniare" << endl;
  return;
}
void ex_b(const punct &p1, const punct &p2, const punct &p3) {
  const dreapta d12(p1, p2), d23(p2, p3);
  if (diferite(p1, p2, p3) == false) {
    if (diferite(p1, p2) == false) {
      cout << "A1 = 1*A2 + 0*A3" << endl;
      return;
    }
    if (diferite(p2, p3) == false) {
      cout << "A2 = 1*A3 + 0*A1" << endl;
      return;
    }
    if (diferite(p1, p3) == false) {
      cout << "A1 = 1*A3 + 0*A2" << endl;
      return;
    }
  }
  auto a = raport(d12, d23);
  if (a != maxim)
    cout << "A1 = " << (1 + a) << "*A2 + (" << (-a) << ")*A3" << endl;
}
void test_puncte_identice() {
  punct p1{1, 1, 0}, p2{1, 1, 0}, p3{1, 1, 0};
  ex_a(p1, p2, p3);
  ex_b(p1, p2, p3);
}
void test_2_puncte_identice() {
  punct p1{1, 1, 0}, p2{1, 1, 1}, p3{1, 1, 1};
  ex_a(p1, p2, p3);
  ex_b(p1, p2, p3);
}
void test_puncte_coliniare() {
  punct p1{-2, -2, 0}, p2{2, 2, 0}, p3{4, 4, 0};
  ex_a(p1, p2, p3);
  ex_b(p1, p2, p3);
}
void test_puncte_necoliniare() {
  punct p1{3, 3, 0}, p2{2, 2, 5}, p3{4, 4, 0};
  ex_a(p1, p2, p3);
  ex_b(p1, p2, p3);
}
int main() {
  punct p1{-2, -2, 0}, p2{2, 0, 0}, p3{4, 0, 0};
  dreapta d12(p1, p2), d23(p2, p3);

  test_puncte_identice();
  test_2_puncte_identice();
  test_puncte_coliniare();
  test_puncte_necoliniare();
}
