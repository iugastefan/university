#include "helper.cpp"

struct Lanturi {
  Punct p;
  bool lant;
};

struct Diagonala {
  Punct x, y;
};

bool sortare(Lanturi l1, Lanturi l2) {
  Punct a{l1.p}, b{l2.p};
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
    VectorLocal.push_back(Lanturi{{V[i].x, V[i].y}, 0});
  }
  if (PozYMax > PozYMin)
    for (int i = PozYMin; i <= PozYMax; i++)
      VectorLocal[i].lant = 1;
  else
    for (int i = PozYMax; i <= PozYMin; i++)
      VectorLocal[i].lant = 1;
  sort(VectorLocal.begin(), VectorLocal.end(), sortare);

  S.push(
      Lanturi{{VectorLocal[0].p.x, VectorLocal[0].p.y}, VectorLocal[0].lant});
  S.push(
      Lanturi{{VectorLocal[1].p.x, VectorLocal[1].p.y}, VectorLocal[1].lant});

  for (int j = 2; j < Numar_de_puncte - 1; j++) {

    if (VectorLocal[j].lant != S.top().lant) {
      while (!S.empty()) {
        if (S.size() > 1) {
          Diagonale.push_back(
              Diagonala{Punct{VectorLocal[j].p.x, VectorLocal[j].p.y},
                        Punct{S.top().p.x, S.top().p.y}});
        }
        S.pop();
      }
      S.push(Lanturi{{VectorLocal[j - 1].p.x, VectorLocal[j - 1].p.y},
                     VectorLocal[j - 1].lant});
      S.push(Lanturi{{VectorLocal[j].p.x, VectorLocal[j].p.y},
                     VectorLocal[j].lant});
    } else {
      Lanturi L{S.top()};
      S.pop();
      Lanturi L1 = S.top();
      while (!S.empty() && unghi(VectorLocal[j].p, L.p, L1.p, V) < M_PI) {
        L = S.top();
        S.pop();
        Diagonale.push_back(
            Diagonala{Punct{VectorLocal[j].p.x, VectorLocal[j].p.y},
                      Punct{L.p.x, L.p.y}});
      }
      S.push(L);
      S.push(VectorLocal[j]);
    }
  }
  S.pop();
  while (S.size() > 1) {
    Diagonale.push_back(Diagonala{Punct{VectorLocal[Numar_de_puncte - 1].p.x,
                                        VectorLocal[Numar_de_puncte - 1].p.y},
                                  Punct{S.top().p.x, S.top().p.y}});
    S.pop();
  }
  S.pop();
  return Diagonale;
}
