# x = 3
# y = 4.5
# z = True
# l_0 = ['a', "b"]
# l_1 = [10, 20, 30, 40, 50, 60, 70]
# l_2 = [100, 'laborator', True, "nota 10", 4.95, [x, y, not z, l_0]]
# print("cu append:")
# l_3 = l_1.copy()
# l_3.append(z); print(l_3)   # [10, 20, 30, 40, 50, 60, 70, True]
# l_3 = l_1.copy()
# l_3.append(l_0); print(l_3) # [10, 20, 30, 40, 50, 60, 70, ['a', 'b']]
# print("\ncu extend:")
# l_3 = l_1.copy()
# l_3.extend([z]); print(l_3)   # [10, 20, 30, 40, 50, 60, 70, True]
# l_3 = l_1.copy()
# l_3.extend(l_0); print(l_3)   # [10, 20, 30, 40, 50, 60, 70, 'a', 'b']
# print("cu '+':")
# l_3 = l_1.copy()
# l_3 = l_3+[z]; print(l_3)   # [10, 20, 30, 40, 50, 60, 70, True]
# l_3 = l_1.copy()
# l_3 += l_0; print(l_3)      # [10, 20, 30, 40, 50, 60, 70, 'a', 'b']
# l_3 = l_1[:]
# print(l_3)
# l_3[1:]
# l_3[:4]
# l_3[1:4]
# l_3[4:4]
# l_3 = l_1.copy()
# l_3[2] = not z; print(l_3)
# l_3[-1] = l_0; print(l_3)
# l_3[3:6] = l_0; print(l_3)
# print(l_3[4:4])
# l_3[4:4]=["bau", 'BAU']; print(l_3)


def create_dictionary(lista):
    d = {}
    for el in lista:
        if el in d.keys():
            d[el] += 1
        else:
            d[el] = 1
    return d


import random


def rock_paper_scissors(alegere):
    alegeri = {'rock': 1, 'paper': 2, 'scissors': 3}
    alegere_pc = random.randint(1, 3)
    alegere_player = alegeri[alegere]
    raspuns = alegere_pc - alegere_player
    print("Alegere PC: " + str(alegere_pc) + " Alegere player: " +
          str(alegere_player))
    if raspuns == 0:
        print("Draw")
    else:
        if raspuns == 1 or raspuns == -2:
            print("PC win")
        else:
            print("Player win")


# create_dictionary([1, 1, 2, 3, 2, 2, 2, 4, 3, 1, 4])
# rock_paper_scissors('scissors')
numar = 0


def cows_and_bulls(raspuns):
    global numar
    if numar == 0:
        numar = random.randint(1000, 9999)
    print(numar, raspuns)
    for x, y in enumerate(str(raspuns)):
        if y in str(numar):
            if str(numar)[x] == y:
                print('b', end='')
            else:
                print('c', end='')
        else:
            print('.', end='')


# cows_and_bulls(4239)


def elemente_comune(lista1: list, lista2: list):
    lista_comune = []
    lista_necomune = []
    for elem in lista1:
        if elem in lista2:
            lista_comune.append(elem)
        else:
            lista_necomune.append(elem)
    return lista_comune, lista_necomune


comune, necomune = elemente_comune([1, 5, 3, 6, 2, 7, 8, 3, 5, 7, 3, 2, 7],
                                   [2, 4, 6, 2, 4, 6, 8, 9, 3, 5, 0, 0, 0])
print(comune, necomune)
