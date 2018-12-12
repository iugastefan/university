#define _USE_MATH_DEFINES
#include <algorithm>
#include <cmath>
#include <iostream>
#include <stack>
#include <vector>
#define infinit 1 << 30
// #define x first
// #define y second
struct Punct {
  double x, y;
};
using namespace std;

struct node {
  double key;
  Punct a, b;
  struct node *left, *right;
};

struct node *newNode(double item, Punct c, Punct d) {
  struct node *temp = (struct node *)malloc(sizeof(struct node));
  temp->key = item;
  temp->a.x = c.x;
  temp->a.y = c.y;
  temp->b.x = d.x;
  temp->b.y = d.y;
  temp->left = temp->right = NULL;
  return temp;
}

struct node *insert(struct node *node, double key, Punct a, Punct b) {

  if (node == NULL)
    return newNode(key, a, b);

  if (key < node->key)
    node->left = insert(node->left, key, a, b);
  else
    node->right = insert(node->right, key, a, b);

  return node;
}

struct node *minValueNode(struct node *node) {
  struct node *current = node;

  while (current->left != NULL)
    current = current->left;

  return current;
}

struct node *deleteNode(struct node *root, int key) {
  if (root == NULL)
    return root;

  if (key < root->key)
    root->left = deleteNode(root->left, key);

  else if (key > root->key)
    root->right = deleteNode(root->right, key);

  else {

    if (root->left == NULL) {
      struct node *temp = root->right;
      free(root);
      return temp;
    } else if (root->right == NULL) {
      struct node *temp = root->left;
      free(root);
      return temp;
    }

    struct node *temp = minValueNode(root->right);

    root->key = temp->key;

    root->right = deleteNode(root->right, temp->key);
  }
  return root;
}
struct node *search(struct node *root, int key) {

  if (root == NULL || root->key == key)
    return root;

  if (root->key < key) {
    if (root->right == NULL)
      return root;
    else
      return search(root->right, key);
  }
  if (root->left == NULL)
    return root;
  else
    return search(root->left, key);
}

void sorteaza(vector<Punct> &a) {
  int sortat = 0;
  Punct aux;
  while (sortat == 0) {
    sortat = 1;
    for (size_t i = 0; i < a.size() - 1; i++) {
      if ((a[i].y == a[i + 1].y && a[i].x > a[i + 1].x) ||
          a[i].y < a[i + 1].y) {
        aux.x = a[i].x;
        aux.y = a[i].y;
        a[i].x = a[i + 1].x;
        a[i].y = a[i + 1].y;
        a[i + 1].x = aux.x;
        a[i + 1].y = aux.y;
        sortat = 0;
      }
    }
  }
}
int inauntru(vector<Punct> a, Punct P) {
  int cn = 0;
  for (size_t i = 0; i < a.size(); i++) {
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
double unghi(Punct a, Punct b, Punct c, vector<Punct> q) {
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

int tip(vector<Punct> a, int j) {
  double k = j - 1, l = j + 1;
  if (j == 0)
    k = a.size() - 1;
  if (j == a.size() - 1)
    l = 0;
  // cout<<"l="<<l<<" j="<<j<<" k="<<k<<"\n";
  if ((a[j].y > a[l].y || (a[j].y == a[l].y && a[j].x < a[l].x)) &&
      (a[j].y > a[k].y || (a[j].y == a[k].y && a[j].x < a[k].x))) {
    // start sau split
    // cout<<unghi(a[k],a[j],a[l])<<" "<<M_PI;
    if (unghi(a[k], a[j], a[l], a) < M_PI)
      return 1; // start
    else
      return 2; // split

  } else if ((a[j].y < a[l].y || (a[j].y == a[l].y && a[j].x > a[l].x)) &&
             (a[j].y < a[k].y || (a[j].y == a[k].y && a[j].x > a[k].x))) {
    // end sau merge
    if (unghi(a[k], a[j], a[l], a) < M_PI)
      return 3; // end
    else
      return 4; // merge
  } else {
    return 5;
    // regular
  }
}
size_t gaseste(vector<Punct> a, Punct v) {
  size_t j;
  for (j = 0; j < a.size(); j++) {
    if (a[j].x == v.x && a[j].y == v.y)
      return j;
  }
  return -1;
}
double medie(vector<Punct> a) {
  double s = 0;
  for (size_t j = 0; j < a.size(); j++) {
    s = s + a[j].x;
  }
  s = s / a.size();
  return s;
}
void sortatV(vector<Punct> &V) {
  int sortat = 0;
  Punct aux;
  while (sortat == 0) {
    sortat = 1;

    for (size_t i = 0; i < V.size() - 1; i++) {
      if ((max(V[i].x, V[i].y) - min(V[i].x, V[i].y)) >
          (max(V[i + 1].x, V[i + 1].y) - min(V[i + 1].x, V[i + 1].y))) {
        aux.x = V[i].x;
        aux.y = V[i].y;
        V[i].x = V[i + 1].x;
        V[i].y = V[i + 1].y;
        V[i + 1].x = aux.x;
        V[i + 1].y = aux.y;
        sortat = 0;
      }
    }
  }
}
vector<vector<int>> ian(vector<Punct> a) {
  vector<Punct> q;
  vector<Punct> muchiadaugate;
  int m, m2;
  int i, j;
  double medx;
  Punct helper[100];
  for (size_t i = 0; i < a.size(); i++)
    q.push_back(a[i]);
  sorteaza(q);
  medx = medie(a);
  struct node *T = NULL, *S = NULL;

  for (size_t i = 0; i < a.size(); i++) {
    int k, l;
    j = gaseste(a, q[i]);
    k = j - 1;
    l = j + 1;
    if (j == 0)
      k = a.size() - 1;
    if (j == a.size() - 1)
      l = 0;
    // out<<k<<":("<<a[k].x<<","<<a[k].y<<") "<<"("<<a[j].x<<","<<a[j].y<<")
    // "<<"("<<a[l].x<<","<<a[l].y<<") ";
    switch (tip(a, j)) {
    case 1: {
      // cout<<"punctul "<<j<<"("<<a[j].x<<","<<a[j].y<<") cazul 1\n";
      T = insert(T, a[j].x, a[j], a[k]);
      helper[j] = a[j];
      break;
    }
    case 2: {
      // cout<<"punctul "<<j<<"("<<a[j].x<<","<<a[j].y<<") cazul 2\n";
      S = search(T, a[j].x);
      m = gaseste(a, S->a);
      if (m != -1) {
        muchiadaugate.push_back(Punct{double(j), double(m)});
        // make_pair(j, m)); // insereaza diagonala a[j] la helper S->a
        helper[m] = a[j];
      }
      helper[j] = a[j];
      T = insert(T, a[j].x, a[j], a[k]);
      break;
    }
    case 3: {
      // cout<<"punctul "<<j<<"("<<a[j].x<<","<<a[j].y<<") cazul 3\n";
      m = gaseste(a, helper[k]);
      if (m != -1) {
        if (tip(a, m) == 4) {
          // muchiadaugate.push_back(make_pair(j, m));
          muchiadaugate.push_back(Punct{double(j), double(m)});
          ; // insereaza diagonala q[i] la helper[k][j]

          T = deleteNode(T, a[m].x);
        }
      }
      break;
    }
    case 4: {
      // cout<<"punctul "<<j<<"("<<a[j].x<<","<<a[j].y<<") cazul 4\n";
      m = gaseste(a, helper[k]);
      if (m != -1) {
        if (tip(a, m) == 4) {
          // cout<<"a\n";
          // muchiadaugate.push_back(make_pair(j, m));
          muchiadaugate.push_back(Punct{double(j), double(m)});
          ; // insereaza diagonala q[i] la helper[k][j]

          // cout<<" se sterge "<<m;
          T = deleteNode(T, a[m].x);
        }
        S = search(T, a[j].x);
        m2 = gaseste(a, S->a);
        if (m2 != -1) {
          m = gaseste(a, helper[m2]);
          //     cout<<" se adauga "<<m2<<"\n";
          if (m != -1) {
            if (tip(a, m) == 4) {
              // cout<<"b\n";
              // muchiadaugate.push_back(
              //     make_pair(j, m)); // insereaza diagonala a[j] la helper
              //     S->a
              muchiadaugate.push_back(Punct{double(j), double(m)});
            }
          }
          helper[m2] = a[j];
        }

        break;
      } // de inspectat din nou
        // case 5: {
        //   // cout<<"punctul "<<j<<"("<<a[j].x<<","<<a[j].y<<") cazul 5\n";
        //   if (a[j].x < medx) {
        //     m = gaseste(a, helper[k]);
        //     if (tip(a, m) == 4) {

      //       // muchiadaugate.push_back(
      //       //     make_pair(j, m)); // insereaza diagonala q[i] la
      //       helper[k][j] muchiadaugate.push_back(Punct{double(j),
      //       double(m)}); T = deleteNode(T, a[k].x); T = insert(T, a[j].x,
      //       a[j], a[k]); helper[j] = q[i];
      //     } else {
      //       S = search(T, a[j].x);
      //       m2 = gaseste(a, S->a);
      //       m = gaseste(a, helper[m2]);
      //       if (tip(a, m) == 4) {
      //         m2 = gaseste(a, S->a);
      //         // muchiadaugate.push_back(
      //         //     make_pair(j, m)); // insereaza diagonala a[j] la helper
      //         //     S->a
      //         muchiadaugate.push_back(Punct{double(j), double(m)});
      //       }
      //       helper[m2] = a[j];
      //     }
      //   }
      //   break;
      // }
      // }
      // }
    case 5: {
      // cout << "punctul " << (char)('A' + j) << "(" << a[j].x << "," << a[j].y
      //      << ") cazul 5\n";
      if (a[j].x < medx) {
        m = gaseste(a, helper[k]);
        if (m != -1) {
          T = deleteNode(T, a[k].x);
          T = insert(T, a[j].x, a[j], a[k]);
          helper[j] = q[i];
          if (tip(a, m) == 4) {
            // cout << "Am adaugat" << j << " " << m << "\n";
            // muchiadaugate.push_back(
            //     make_pair(j, m)); // insereaza diagonala q[i] la helper[k][j]
            muchiadaugate.push_back(Punct{double(j), double(m)});

          }

          else {
            // cout<<"intra\n";
            S = search(T, a[j].x);
            m2 = gaseste(a, S->a);
            if (m2 != -1) {
              m = gaseste(a, helper[m2]);
              if (m != -1) {
                if (tip(a, m) == 4) {
                  m2 = gaseste(a, S->a);
                  // muchiadaugate.push_back(make_pair(
                  //     j, m)); // insereaza diagonala a[j] la helper S->a
                  muchiadaugate.push_back(Punct{double(j), double(m)});
                }
                helper[m2] = a[j];
              }
            }
          }

        } else {
          // cout<<"intra\n";
          S = search(T, a[j].x);
          m2 = gaseste(a, S->a);
          if (m2 != -1) {
            m = gaseste(a, helper[m2]);
            if (m != -1) {
              if (tip(a, m) == 4) {
                m2 = gaseste(a, S->a);
                // muchiadaugate.push_back(
                //     make_pair(j, m)); // insereaza diagonala a[j] la helper
                //     S->a
                muchiadaugate.push_back(Punct{double(j), double(m)});
              }
              helper[m2] = a[j];
            }
          }
        }
      }
      break;
    }
    }
    }
  }

  int apariti[100];
  vector<vector<int>> V(100);
  for (i = 0; i < 100; i++)
    apariti[i] = 1;
  /*
  for(i=0;i<muchiadaugate.size();i++)
      cout<<"muchie adaugata:"<<muchiadaugate[i].x<<"
  "<<muchiadaugate[i].y<<"\n";
   */
  sortatV(muchiadaugate);
  for (i = 0; i < muchiadaugate.size(); i++) {
    apariti[int(muchiadaugate[i].x)]++;
    apariti[int(muchiadaugate[i].y)]++;
    for (auto j = int(min(muchiadaugate[i].x, muchiadaugate[i].y));
         j <= max(muchiadaugate[i].x, muchiadaugate[i].y); j++) {
      if (muchiadaugate[i].x == muchiadaugate[i + 1].x &&
          muchiadaugate[i].y == muchiadaugate[i + 1].y)
        ;
      else if (apariti[j] >= 1) {
        V[i].push_back(j);
        apariti[j]--;
      }
    }
  }
  for (j = 0; j < a.size(); j++)
    if (apariti[j] == 1) {
      V[i].push_back(j);
    }
  /*
  for(i=0;i<=6;i++)
  {
      cout<<"Poligon: ";
      for(j=0;j<V[i].size();j++)
          cout<<V[i][j]<<" ";
      cout<<"\n";
  }
   */
  return V;
}

// int main()
// {
//     vector<pair<double,double>> a;
//     a.push_back(make_pair(20, 12));
//     a.push_back(make_pair(14, 10));
//     a.push_back(make_pair(12, 18));
//     a.push_back(make_pair(9, 15));
//     a.push_back(make_pair(6, 18));
//     a.push_back(make_pair(2, 15));
//     a.push_back(make_pair(4, 13));
//     a.push_back(make_pair(4, 10));
//     a.push_back(make_pair(2, 12));
//     a.push_back(make_pair(0, 8));
//     a.push_back(make_pair(4, 4));
//     a.push_back(make_pair(7, 6));
//     a.push_back(make_pair(14, 2));
//     a.push_back(make_pair(12, 8));
//     a.push_back(make_pair(16, 7));
//     ian(a);
//     return 0;
// }
struct Lanturi {
  double x, y;
  bool lant;
};
// struct Punct {
//   double x, y;
// };
struct Diagonala {
  Punct x, y;
};

int inauntru(vector<Punct> a, Lanturi P) {
  int cn = 0;
  for (size_t i = 0; i < a.size(); i++) {
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
double unghi(Lanturi a, Lanturi b, Lanturi c, const vector<Punct> &q) {
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
  vector<Punct> poligon{{4, 5},  {0, 3},  {4, 7},  {7, 8}, {8, 6},
                        {6, 4},  {8, 2},  {5, -1}, {5, 2}, {2, -1},
                        {9, -2}, {7, -4}, {1, -2}, {0, 0}, {1, 2}};
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
  return 0;
}
