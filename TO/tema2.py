def subMatr(matrice, x, y):
    m = []
    for i in range(0, len(matrice)):
        if i == x:
            continue
        m.append([])
        for j in range(len(matrice)):
            if j == y:
                continue
            m[-1].append(matrice[i][j])
    return m


def det(matrice):
    rez = 0
    if len(matrice) == 1:
        return matrice[0][0]
    if len(matrice) == 2:
        return matrice[0][0]*matrice[1][1]-matrice[0][1]*matrice[1][0]
    semn = 1
    for i in range(len(matrice)):
        rez += semn * matrice[0][i]*det(subMatr(matrice, 0, i))
        semn *= -1
    return rez


def transpusa(matrice):
    m = []
    for i in range(len(matrice)):
        m.append([])
        for j in range(len(matrice)):
            m[-1].append(matrice[j][i])
    return m


def adjuncta(matrice):
    transp = transpusa(matrice)
    m = []
    for i in range(len(transp)):
        m.append([])
        for j in range(len(transp)):
            semn = (-1) ** ((i+j+2))
            m[-1].append(semn*det(subMatr(transp, i, j)))
    return m


def inversa(matrice):
    d = 1/det(matrice)
    m = []
    for i in adjuncta(matrice):
        m.append([])
        for j in i:
            m[-1].append(d*j)

    return m


def produs(matrice1, matrice2):
    m = []
    for i in range(len(matrice1)):
        m.append([])
        for j in range(len(matrice1)):
            m[-1].append(0)
            for k in range(len(matrice1)):
                m[i][j] += matrice1[i][k]*matrice2[k][j]
            m[i][j] = round(m[i][j], 3)
    return m


def mIdentitate(marime):
    m = []
    for i in range(marime):
        m.append([])
        for j in range(marime):
            if i == j:
                m[-1].append(1)
            else:
                m[-1].append(0)
    return m


def egalitate(matrice1, matrice2):
    for i in range(len(matrice1)):
        for j in range(len(matrice2)):
            if matrice1[i][j] != matrice2[i][j]:
                return False
    return True


def verifica(matrice):
    if det(matrice) == 0:
        print("Determinant 0")
    else:
        if egalitate(produs(matrice, inversa(matrice)), mIdentitate(len(matrice))):
            print("Functioneaza corect")
        else:
            print("Nu functioneaza corect")


matrice = [[1, 3, 5, 9],
           [1, 3, 1, 7],
           [4, 3, 9, 7],
           [5, 2, 0, 9]]
m = [[1, 2],
     [3, 4]]
m2 = [[2, 1, -1],
      [1, 2, 3],
      [3, 1, 1]]
m3 = [[2, 3],
      [4, 6]]

verifica(matrice)
verifica(m)
verifica(m2)
verifica(m3)
