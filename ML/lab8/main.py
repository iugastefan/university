import matplotlib.pyplot as plt
import numpy as np
from mpl_toolkits import mplot3d


def plot3d_data_and_decision_function(X, y, W, b):
    ax = plt.axes(projection='3d')
    xx, yy = np.meshgrid(range(10), range(10))
    zz = (-W[0] * xx - W[1] * yy - b) / W[2]
    ax.plot_surface(xx, yy, zz, alpha=0.5)
    ax.scatter3D(X[y == -1, 0], X[y == -1, 1], X[y == -1, 2], 'b')
    ax.scatter3D(X[y == 1, 0], X[y == 1, 1], X[y == 1, 2], 'r')
    plt.show()


X_train = np.loadtxt('./data/3d-points/x_train.txt')
y_train = np.loadtxt('./data/3d-points/y_train.txt', 'int')

X_test = np.loadtxt('./data/3d-points/x_test.txt')
y_test = np.loadtxt('./data/3d-points/y_test.txt', 'int')

from sklearn.linear_model import Perceptron
model = Perceptron(eta0=0.1, tol=1e-5)
model.fit(X_train, y_train)
print('Test acc = %.2f ' % (model.score(X_test, y_test)))
print('Train acc = %.2f' % model.score(X_train, y_train))
print('Weights = ', model.coef_)
print('Bias = ', model.intercept_)
print('Epochs = ', model.n_iter_)
plot3d_data_and_decision_function(X_train,y_train,np.squeeze(model.coef_),model.intercept_)
