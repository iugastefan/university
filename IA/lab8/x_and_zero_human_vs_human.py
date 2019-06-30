GOL = '#'


class Tabla:
    tabla_curenta = [['#', '#', '#'], ['#', '#', '#'], ['#', '#', '#']]

    def __repr__(self):
        tb = ''
        for x in self.tabla_curenta:
            for y in x:
                tb += y+' '
            tb += '\n'

        return tb



# def __str__(matr):
#     sir = (" ".join([str(x) for x in matr[0:3]]) + "\n" +
#            " ".join([str(x) for x in matr[3:6]]) + "\n" +
#            " ".join([str(x) for x in matr[6:9]]) + "\n")
#
#     return sir


def elem_identice(lista):
    '''
    lista contine elementele de pe linie, coloana  sau
     diagonale si verifica daca are doar valori de x
    sau doar valori de 0

    Daca lista contine un castigator, il intoarce pe acesta (x sau 0), altfel intoarce False
    '''
    if len(set(lista)) == 1:
        if lista[0] == 'x':
            return 'x'
        if lista[0] == '0':
            return '0'
    return False


def final(matr):
    '''
    verifica liniile, coloanele si diagonalele cu ajutorul lui elem_identice si intoarce, dupa caz, castigatorul,
    remiza, sau False
    '''
    castigatori = [elem_identice(matr[0]),
                   elem_identice(matr[1]),
                   elem_identice(matr[2]),
                   elem_identice([matr[0][0],
                                  matr[1][0],
                                  matr[2][0]]),
                   elem_identice([matr[0][1],
                                  matr[1][1],
                                  matr[2][1]]),
                   elem_identice([matr[0][2],
                                  matr[1][2],
                                  matr[2][2]]),
                   elem_identice([matr[0][0],
                                  matr[1][1],
                                  matr[2][2]]),
                   elem_identice([matr[0][2],
                                  matr[1][1],
                                  matr[2][0]])
                   ]
    if 'x' in castigatori:
        if '0' in castigatori:
            return 'remiza'
        return 'x'
    if '0' in castigatori:
        return '0'
    return False
    # ... TO DO


def afis_daca_final(stare_curenta):
    final_ans = final(stare_curenta)
    if final_ans:
        if final_ans == "remiza":
            print("Remiza!")
        else:
            print("A castigat " + final_ans)

        return True

    return False


def jucator_opus(juc_curent):
    # returneaza jucatorul opus fata de jucatorul curent ('x' sau '0')
    if juc_curent == 'x':
        return '0'
    return 'x'


def main():
    print('Incepe jocul x si 0')
    tabla=Tabla()
    tabla_curenta = Tabla.tabla_curenta

    # initializare jucatori
    raspuns_valid = False
    while not raspuns_valid:
        JMIN = input("Doriti sa jucati cu x sau cu 0? ").lower()
        if JMIN in ['x', '0']:
            raspuns_valid = True
        else:
            print("Raspunsul trebuie sa fie x sau 0.")
    JMAX = '0' if JMIN == 'x' else 'x'

    # initializare tabla
    # tabla_curenta = [['#', '#', '#'], ['#', '#', '#'], ['#', '#', '#']]
    print("Tabla initiala")
    print(tabla)

    # creare stare initiala
    j_curent = 'x'

    while True:
        if j_curent == JMIN:
            # muta jucatorul 'x'
            # Solicitam introducerea de la tastatura a liniei si a coloanei (0,1,2).
            raspuns_valid = False
            while not raspuns_valid:
                x = int(input("Introdu numarul liniei 0/1/2"))
                if 0 <= x <= 2:
                    y = int(input("Introdu numarul coloanei 0/1/2"))
                    if 0 <= y <= 2 and tabla_curenta[x][y] == '#':
                        raspuns_valid = True
                        tabla_curenta[x][y] = 'x'

            # In punctul acesta sigur am valide atat linia cat si coloana
            # deci pot plasa simbolul pe "tabla de joc"

            # afisarea starii jocului in urma mutarii utilizatorului
            print("\nTabla dupa mutarea jucatorului")
            print(tabla)

            # testez daca jocul a ajuns intr-o stare finala
            # si afisez un mesaj corespunzator in caz ca da
            if afis_daca_final(tabla_curenta):
                break

            # S-a realizat o mutare. Schimb jucatorul cu cel opus
            j_curent = jucator_opus(j_curent)

        # --------------------------------
        else:  # jucatorul e JMAX
            if j_curent == JMAX:
                raspuns_valid = False
                while not raspuns_valid:
                    x = int(input("Introdu numarul liniei 0/1/2"))
                    if 0 <= x <= 2:
                        y = int(input("Introdu numarul coloanei 0/1/2"))
                        if 0 <= y <= 2 and tabla_curenta[x][y] == '#':
                            raspuns_valid = True
                            tabla_curenta[x][y] = '0'
                # muta jucatorul '0'
                # Solicitam introducerea de la tastatura a liniei si a coloanei (0,1,2).

                # In punctul acesta sigur am valide atat linia cat si coloana
                # deci pot plasa simbolul pe "tabla de joc"

                # afisarea starii jocului in urma mutarii utilizatorului
                print("\nTabla dupa mutarea jucatorului")
                print(tabla)

                # testez daca jocul a ajuns intr-o stare finala
                # si afisez un mesaj corespunzator in caz ca da
                if afis_daca_final(tabla_curenta):
                    break

                # S-a realizat o mutare. Schimb jucatorul cu cel opus
                j_curent = jucator_opus(j_curent)


if __name__ == "__main__":
    main()
