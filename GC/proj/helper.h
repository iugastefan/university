#define _USE_MATH_DEFINES
#include <algorithm>
#include <climits>
#include <cmath>
#include <iostream>
#include <map>
#include <queue>
#include <stack>
#include <vector>

#define infinit INT_MAX
#define start_vertex 1
#define end_vertex 2
#define regular_vertex 3
#define split_vertex 4
#define merge_vertex 5
using namespace std;

struct Punct {
  friend bool operator<(const Punct &p1, const Punct &p2);
  double x, y;
};
struct Segment {
  Punct p1, p2;
};
// double unghi(Punct a, Punct b, Punct c, const vector<Punct> &q);
