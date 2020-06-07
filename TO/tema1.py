import matplotlib
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import numpy as np
x1 = np.arange(0, 5, 0.2)
x2 = np.arange(0, 5, 0.2)
fig, ax = plt.subplots(2, 2)
ax[0, 0].fill_between(x1, 3-x2, 0, where=3-x2 >= 0,
                      interpolate=True, alpha=0.5)
ax[0, 0].fill_between(x1, x2+1, 0, where=x2-x1 <= 1,
                      interpolate=True, alpha=0.5)
ax[0, 0].fill_between(x1, 5, 0, interpolate=True, alpha=0.2)
ax[0, 0].plot(1, 2, 'bo')
ax[0, 0].grid()

ax[0, 1].fill_between(x1, x2, 0, where=x1-x2 >= 0, interpolate=True, alpha=0.5)
ax[0, 1].fill_between(x1, 5, 0.5*x2, where=5-0.5*x2 >=
                      0, interpolate=True, alpha=0.5)
ax[0, 1].fill_between(x1, 5, 0, interpolate=True, alpha=0.2)
ax[0, 1].plot(0, 0, 'bo')
ax[0, 1].grid()

ax[1, 0].fill_between(x1, 3-x2, 0, where=3-x2 >= 0,
                      interpolate=True, alpha=0.5)
ax[1, 0].fill_between(x1, 4-x2, 5, where=4-x2 >= 0,
                      interpolate=True, alpha=0.5)
ax[1, 0].grid()


def y(x: int):
    if x <= 1:
        return 1-x
    else:
        return 0


x1 = np.arange(0, 10, 0.2)
x2 = np.arange(0, 10, 0.2)
ax[1, 1].fill_between(x1, 5-0.5*x2, 0, interpolate=True, alpha=0.5)
ax[1, 1].fill_between(x1, [y(x) for x in x1], 10, interpolate=True, alpha=0.5)
ax[1, 1].fill_between(x1, 4, 0, interpolate=True, alpha=0.5)
ax[1, 1].plot([0, 2, 10], [4, 4, 0])
ax[1, 1].grid()

plt.show()
