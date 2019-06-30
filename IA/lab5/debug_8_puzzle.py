""" definirea problemei """
from math import sqrt


class Nod:
    NR_LINII = 3
    NR_COLOANE = 3

    def __init__(self, info, h):
        self.info = info
        self.h = 0

    def __str__(self):
        sir = "\n"
        for i in range(0, self.__class__.NR_LINII):
            for j in range(0, self.__class__.NR_COLOANE):
                sir += str(self.info[i * self.__class__.NR_COLOANE + j]) + " "
            sir += "\n"
        return sir

    def __repr__(self):
        sir = "\n"
        for i in range(0, Nod.NR_LINII):
            for j in range(0, self.__class__.NR_COLOANE):
                sir += str(self.info[i * self.__class__.NR_COLOANE + j]) + " "
            sir += "\n"
        return sir


class Graf:

    def __init__(self, pozitii, scop):

        self.nod_start = Nod(list(pozitii), float('inf'))
        self.reprez_scop = list(scop)

    def scop(self, nod):
        return nod.info == self.reprez_scop

    def calculeaza_h(self, reprez_nod):
        h = 0
        for ind in range(len(reprez_nod)):
            i_elem = ind / Nod.NR_COLOANE
            j_elem = ind % Nod.NR_COLOANE
            h += self.dist_euclid(reprez_nod[ind], i_elem, j_elem, self.reprez_scop)
        return h

    def dist_euclid(self, elem, i_elem, j_elem, reprezentare):
        nr = reprezentare.index(elem)
        i_scop = nr / Nod.NR_COLOANE
        j_scop = nr % Nod.NR_COLOANE
        return sqrt((i_scop - i_elem) ** 2 + (j_scop - j_elem) ** 2)

    def interschimba(self, ind1, ind2, l):
        lnou = list(l)
        lnou[ind1], lnou[ind2] = lnou[ind2], lnou[ind1]
        return lnou

    def calculeaza_succesori(self, nod):
        ind_gol = nod.info.index(0)
        linie_gol = int(ind_gol / Nod.NR_COLOANE)
        coloana_gol = int(ind_gol % Nod.NR_COLOANE)
        l_succesori = []
        # TO DO infrumusetat cod
        if linie_gol >= 1:
            poz_mutare = (linie_gol - 1) * Nod.NR_COLOANE + coloana_gol
            reprez_noua = self.interschimba(ind_gol, poz_mutare, nod.info)
            h_nod = self.calculeaza_h(reprez_noua)
            l_succesori.append((Nod(reprez_noua, h_nod), 1))
        if linie_gol <= 1:
            poz_mutare = (linie_gol + 1) * Nod.NR_COLOANE + coloana_gol
            reprez_noua = self.interschimba(ind_gol, poz_mutare, nod.info)
            h_nod = self.calculeaza_h(reprez_noua)
            l_succesori.append((Nod(reprez_noua, h_nod), 1))
        if coloana_gol >= 1:
            poz_mutare = linie_gol * Nod.NR_COLOANE + coloana_gol - 1
            reprez_noua = self.interschimba(ind_gol, poz_mutare, nod.info)
            h_nod = self.calculeaza_h(reprez_noua)
            l_succesori.append((Nod(reprez_noua, h_nod), 1))
        if coloana_gol <= 1:
            poz_mutare = linie_gol * Nod.NR_COLOANE + coloana_gol + 1
            reprez_noua = self.interschimba(ind_gol, poz_mutare, nod.info)
            h_nod = self.calculeaza_h(reprez_noua)
            l_succesori.append((Nod(reprez_noua, h_nod), 1))
        return l_succesori


""" Sfarsit definire problema """

""" Clase folosite in algoritmul A* """


class NodCautare:
    def __init__(self, nod_graf, succesori=[], parinte=None, g=0, f=None):
        self.nod_graf = nod_graf
        self.succesori = succesori
        self.parinte = parinte
        self.g = g
        if f is None:
            self.f = self.g + self.nod_graf.h
        else:
            self.f = f

    def drum_arbore(self):
        nod_c = self
        drum = [nod_c]
        while nod_c.parinte is not None:
            drum = [nod_c.parinte] + drum
            nod_c = nod_c.parinte
        return drum

    def contine_in_drum(self, nod):
        nod_c = self
        while nod_c.parinte is not None:
            if nod.info == nod_c.nod_graf.info:
                return True
            nod_c = nod_c.parinte
        return False

    def __str__(self):
        parinte = self.parinte if self.parinte is None else self.parinte.nod_graf.info
        # return "("+str(self.nod_graf)+", parinte="+", f="+str(self.f)+", g="+str(self.g)+")";
        return str(self.nod_graf)


""" Algoritmul A* """


def debug_str_l_noduri(l):
    sir = ""
    for x in l:
        sir += str(x) + "\n"

    return sir


def get_lista_solutii(l):
    """ added by Cristina """
    drum = []
    for x in l:
        drum.append(x.nod_graf.info)
    return drum


def in_lista(l, nod):
    """
    if nod in l:
        return true
    """
    for x in l:
        if x.nod_graf.info == nod.info:
            return x
    return None


def a_star(graf):
    rad_arbore = NodCautare(nod_graf=graf.nod_start)
    print(graf.nod_start.info)
    print(graf.nod_start)

    open = [rad_arbore]
    closed = []
    while len(open) > 0:
        nod_curent = open.pop(0)
        closed.append(nod_curent)
        if graf.scop(nod_curent.nod_graf):
            break
        l_succesori = graf.calculeaza_succesori(nod_curent.nod_graf)
        for (nod, cost) in l_succesori:
            if (not nod_curent.contine_in_drum(nod)):
                # verific daca se afla in closed
                x = in_lista(closed, nod)
                g_succesor = nod_curent.g + cost
                f = g_succesor + nod.h
                if x is not None:
                    if (f < nod_curent.f):
                        nod_curent.f = f
                        x.parinte = nod_curent
                        x.g = g_succesor
                        x.f = f
                else:
                    x = in_lista(open, nod)
                    if x is not None:
                        if (x.g > g_succesor):  # f < nod_curent.f# x.g > g_succesor
                            nod_curent.f = f
                            x.parinte = nod_curent
                            x.g = g_succesor
                            x.f = f
                    else:  # cand nu e nici in closed nici in open
                        nod_cautare = NodCautare(nod_graf=nod, parinte=nod_curent,
                                                 g=g_succesor)  # se calculeaza f automat in constructor
                        open.append(nod_cautare)
        open.sort(key=lambda x: (x.f, -x.g))

    print("-----------------------------------------")
    print("Drum de cost minim:" + debug_str_l_noduri(nod_curent.drum_arbore()))

    """ added by Cristina: """
    return get_lista_solutii(nod_curent.drum_arbore())


def main(pozitii, scop):
    problema = Graf(pozitii, scop)
    return a_star(problema)

# main([5, 6, 7, 4, 0, 8, 3, 2, 1], [1, 2, 3, 4, 5, 6, 7, 8, 0])
# main([2, 8, 1, 0,  4, 3, 7, 6, 5], [1, 2, 3, 4, 5, 6, 7, 8, 0])
# main([1,8,2,0,4,3,7,6,5], [1, 2, 3, 4, 5, 6, 7, 8, 0])
