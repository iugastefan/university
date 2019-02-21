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
rock_paper_scissors('scissors')
