#include "helper.cpp"

int tip_punct(const Punct &p_st, const Punct &p, const Punct &p_dr,
              const vector<Punct> &poligon) {
  if (p_st.y < p.y && p_dr.y < p.y) {
    auto ung = unghi(p_st, p, p_dr, poligon);
    if (ung < M_PI)
      return start_vertex;
    else if (ung > M_PI)
      return split_vertex;
  }
  if (p_st.y > p.y && p_dr.y > p.y) {
    auto ung = unghi(p_st, p, p_dr, poligon);
    if (ung < M_PI)
      return end_vertex;
    else if (ung > M_PI)
      return merge_vertex;
  }
  return regular_vertex;
}
struct Punct_cu_tip {
  Punct p;
  int tip;
};

void handle_start_vertex(const Punct_cu_tip &v, const int ordine,
                         map<Segment, int> &T,
                         map<Segment, Punct_cu_tip> &helper,
                         const vector<Segment> &e) {
  T.at(e[ordine]) = 1;
  helper[e[ordine]] = v;
}
void handle_vertex(const Punct_cu_tip &v, const int ordine,
                   map<Segment, int> &T, map<Segment, Punct_cu_tip> &helper,
                   const vector<Segment> &e) {
  switch (ordine) {
  case start_vertex: {
  }
  case end_vertex: {
  }
  case regular_vertex: {
  }
  case split_vertex: {
  }
  case merge_vertex: {
  }
  }
}

vector<Segment> MakeMonotone(vector<Punct> P) {

  auto cmp_points_by_y = [](const Punct_cu_tip &p1, const Punct_cu_tip &p2) {
    if (p1.p.y != p2.p.y)
      return p1.p.y > p2.p.y;
    else
      return p1.p.x < p2.p.x;
  };
  priority_queue<Punct_cu_tip, vector<Punct_cu_tip>, decltype(cmp_points_by_y)>
      Q(cmp_points_by_y);

  vector<Segment> e;

  for (auto it = P.begin(); it != P.end(); it++) {
    if (it == P.begin()) {
      Q.push(Punct_cu_tip{*it, tip_punct(P.back(), *it, *(it + 1), P)});
      e.push_back({*it, *(it + 1)});
    } else if (it == (P.end() - 1)) {
      Q.push(Punct_cu_tip{*it, tip_punct(*(it - 1), *it, P.front(), P)});
      e.push_back({*it, P.front()});
    } else {
      Q.push(Punct_cu_tip{*it, tip_punct(*(it - 1), *it, *(it + 1), P)});
      e.push_back({*it, *(it + 1)});
    }
  }

  map<Segment, int> T;
  map<Segment, Punct_cu_tip> helper;
  int ordine = 0;

  while (!Q.empty()) {
    auto v = Q.top();
    Q.pop();
  }
}
