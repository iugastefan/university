# Iuga Stefan
# grupa 332
# Proiectul 23
# Sa se genereze variabila Poisson(3) prin doua metode diferite (curs 7).
# Sa se genereze histograma corespunzatoare fiecarei metode (curs 8).

import numpy as np
import matplotlib.pyplot as plt
from math import trunc, ceil


# Curs 7
# Din lema
def Poisson1(l):
    P = 1
    U = np.random.uniform(0, 1)
    i = 1
    P = P*U
    while P >= np.e**(-l):
        U = np.random.uniform(0, 1)
        i = i+1
        P = P*U
    X = i-1
    return X


# Y ∼ Poisson(λ) cu λ = np ¸si n → ∞, p → 0, atunci Y ∼ Binom(n, p)
def Poisson2(l, p=0.001):
    n = int(round(l/p))
    X = np.random.binomial(n, p)
    return X


# Curs 8
def Histograma(X: list):
    m = min(X)
    M = max(X)
    k = 25  # Nr de intervale
    I = [m+(i)*((M-m)/(k-1)) for i in range(k)]  # Intervalele
    f = [0 for i in range(k)]  # Frecvente absolute
    for x in X:
        for j in range(k):
            if x == I[j+1]:
                f[j+1] += 1
                break
            if I[j] <= x < I[j+1]:
                f[j] += 1
                break
    r = [j/len(X) for j in f]  # Frecvente relative
    return r


p1 = [Poisson1(3) for i in range(1000)]
p2 = [Poisson2(3) for i in range(1000)]
print(sum(p1)/len(p1))
print(sum(p2)/len(p2))
h1 = Histograma(p1)
h2 = Histograma(p2)

s = np.random.poisson(3, 1000)
hs = Histograma(s)
print(sum(s)/len(s))

fig, ax = plt.subplots(ncols=3, figsize=(15, 7))
x_pos = [i for i, _ in enumerate(h1)]
ax[0].bar(x_pos, h1)
ax[0].set_title('Poisson varianta 1 din curs')
ax[1].bar(x_pos, h2)
ax[1].set_title('Poisson varianta 2 din curs')
ax[2].bar(x_pos, hs)
ax[2].set_title('Poisson din libraria numpy')
plt.show()
