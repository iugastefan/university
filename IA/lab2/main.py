# x = 3
# y = 4.5
# t = True
# f = False
# l_0 = ['a', "b"]
# l_1 = [10, 20, 30, 40, 50, 60, 70]

# print(x, type(x))
# print(y, type(y))
# print(t, type(t))
# print(f, type(f))
# print(l_0, type(l_0))
# print(l_1, type(l_1))
# print(t and not f, type(t and not f))
# print(t or f, type(t or f))

# print("\n--- Conversii intre 'bool' si alte tipuri de date")
# print(y+True, type(y+True), '  ', x**False, type(x**False)) # True = 1, False =0 (conversie implicita)
# print('numere: ', bool(3.5), bool(-1), bool(0)) # conversie: orice nenul = True; 0=False
# print('liste: ', bool([1,2,3]), bool([])) # lista nevida = True; lista vida = False
# print('stringuri: ', bool('cuvant'), bool('')) # cuv nevid = True; cuv vid = False
# print('dictionare: ', bool({1:2, 3:4}), bool({})) # dict nevid = True; dict vid = False

# print("\n--- Asignare multipla")
# a = b = c = d = 3
# print('adunare: ', a+b, '\nscadere: ', a-c, '\ninmultire: ', a*d)
# print('impartire completa: ', b/(c-1))
# print('catul: ', b//(d-1), '  restul:', c%d)
# print('ridicarea la putere: ', d**4)

# a, b, c = 1, 2, 3
# print(a,b,c) # 1,2,3
# b, a = 2*b, 2*b
# print(a,b) # 4,4
# b, c = c, b # interschimbare valori
# print(a,b,c)

# print("\n--- Operatori:")
# print("- de comparare (==, !=, <, <=, >, >=): ")
# print(False == 0, True != 4.7, '  ', 3<3.0, 3.0<=3, '  ', 'bec'>'abcd', True>=False)

# print("- testare apartenenta elem (in, not in): ")
# print(3 in [1,3,2], 'a' not in 'casa', 'as' in 'casa')
# print("- comparare locatie in memorie a doua obiecte (is, is not): ")

# a = b = c = 5
# print('variabile simple: ', a is not b, a is c, end=' ') # ??
# b+=1; print(a,b,c, end='')
# print('   ', a is not b, a is c, a,b,c) # ??

# l1 = [1,2,3]; l2 = l1; l3 = l1.copy()
# print('liste: ', l2 is l1, l3 is l1, end='  ')
# l1[0] = 0; print(l1, l2, l3)

# l1 = [1,2,3]; l2 = l1; l3 = l1.copy()
# print('liste: ', l2 is l1, l3 is l1, end='  ')
# l1[0] = 0; print(l1, l2, l3)

# print("\n--- Siruri")
# c1 = 'Hello World!'
# c2 = "Python Programming"
# print(c1); print(c2)

# print('- extragere portiune din sir (ca la liste): ')
# print(c1[:7] + c2[-3:]) # '+' pt concatenare, ca la liste
# print(c1[::-1]) # sirul oglindit
# print('- "multiplicare" (concatenare multipla) sir/lista: ')
# print(3 * 'abcd.')
# print(3 * [1,2,3,0])

# print('- "modificare" sir (prin reasignare!): ', end='')
# #c1[5] = ','; print(c1)   # asa NU!
# #TypeError: 'str' object does not support item assignment
# c1 = c1[:5] + ',' + c1[6:]; print(c1)   # asa DA!

# print('- formatare sir: ')
# print("Invatam %s de %d saptamana si %g zile." %(c2[:6], 1, 2.5))
# # '%s' pt siruri, '%c' pentru un caracter
# # '%i' sau '%d' pentru nr intreg
# # '%f' sau '%g' pentru nr real

# l_1='casa'
# #l_1=[10, 20, 30, 40]
# for i in range(len(l_1)):
#    print("l[{}] = {}".format(i, l_1[i]))

# sir = 'aBCdE'
# print("\n", sir, sir.lower(), sir.upper(), sir.title())

# print(['   ab  '.lstrip(), ' cd '.rstrip(), '  ef  '.strip()])
# print(['++--+-ab+'.lstrip('+'), '++--+-ab+'.lstrip('+-')])

# print('laborator'.startswith('labo'), 'sala'.endswith('la'))
# print('examen'.find('am'), 'examen'.find('exe'))

# print('nota'.isalpha(), '1234'.isdigit(), 'nota 10'.isalnum())

# l = 'Ana are mere.'.split(' ')
# tel = '0000-111-222'.split('-')
# print(l)
# print(tel)

# print(list("abracadabra"))
# print(list('123456789'))
# print(1234/4, '--> ', list(str(float(1234/4))))

dictionar = {}
dictionar['vocale'] = 'aeiou'
dictionar['consoane'] = 'bcdfghjklmnpqrstvxyz'
dictionar['cifre'] = '0123456789'
lista = [
    "co-pa-cel", "pa-pu-cel", "a-bac", "021-220-20-10", "1-pi-tic",
    "go-go-nea", "tip-til", "123-456", "a-co-lo", "lo-go-ped", "pa-pa-gal",
    "co-co-starc"
]

dictionar2 = {}
for x in lista:
    for y in x.split('-'):
        if y not in dictionar2:
            dictionar2[y] = [x.replace('-', '')]
        else:
            if x.replace('-', '') not in dictionar2[y]:
                dictionar2[y].append(x.replace('-', ''))
print(dictionar2)

for x in dictionar2.copy().keys():
    if x.isdigit():
        for y in dictionar2[x]:
            print(x, y)
        dictionar2.pop(x, None)
