from Data_Loader import *
import Bag_of_Words as BOW
from sklearn.neural_network import MLPClassifier
from sklearn import preprocessing

loader = Data_Loader()
loader.build_dataset()

bow_model = BOW.Bag_of_words()
bow_model.build_vocabulary(loader.train_data)
X_train = bow_model.get_features(loader.train_data)
X_test = bow_model.get_features(loader.test_data)
y_train = loader.train_labels
y_test = loader.test_labels

scaler = preprocessing.StandardScaler()
scaler.fit(X_train)
X_train = scaler.transform(X_train)
X_test = scaler.transform(X_test)

# mlp = MLPClassifier(solver='sgd', hidden_layer_sizes=(30, 20), activation='tanh', learning_rate='constant',
#                     learning_rate_init=0.01, momentum=0)
# mlp.fit(X_train, y_train)
# acc_train = mlp.score(X_train, y_train)
# acc_test = mlp.score(X_test, y_test)
# print('Train acc=%.2f\nTest acc = %.2f' % (100 * acc_train, 100 * acc_test))
# print('Epochs = ', mlp.n_iter_)

# mlp_a = MLPClassifier(solver='sgd', hidden_layer_sizes=(30, 20), activation='tanh', learning_rate='constant',
#                       learning_rate_init=0.01, momentum=0, early_stopping=True)
# mlp_a.fit(X_train, y_train)
# acc_train = mlp_a.score(X_train, y_train)
# acc_test = mlp_a.score(X_test, y_test)
# print('-' * 10 + 'a' + '-' * 10)
# print('Train acc=%.2f\nTest acc = %.2f' % (100 * acc_train, 100 * acc_test))
#
# mlp_b = MLPClassifier(solver='sgd', hidden_layer_sizes=(30, 20), activation='tanh', learning_rate='adaptive',
#                       learning_rate_init=0.01, momentum=0)
# mlp_b.fit(X_train, y_train)
# acc_train = mlp_b.score(X_train, y_train)
# acc_test = mlp_b.score(X_test, y_test)
# print('-' * 10 + 'b' + '-' * 10)
# print('Train acc=%.2f\nTest acc = %.2f' % (100 * acc_train, 100 * acc_test))
#
#
# mlp_c = MLPClassifier(solver='sgd', hidden_layer_sizes=(30, 20), activation='tanh', learning_rate='adaptive',
#                       learning_rate_init=0.01, momentum=0.9)
# mlp_c.fit(X_train, y_train)
# acc_train = mlp_c.score(X_train, y_train)
# acc_test = mlp_c.score(X_test, y_test)
# print('-' * 10 + 'c' + '-' * 10)
# print('Train acc=%.2f\nTest acc = %.2f' % (100 * acc_train, 100 * acc_test))


mlp_d = MLPClassifier(solver='sgd', hidden_layer_sizes=(30, 20), activation='tanh', learning_rate='adaptive',
                      learning_rate_init=0.01, momentum=0.9, alpha=0.5)
mlp_d.fit(X_train, y_train)
acc_train = mlp_d.score(X_train, y_train)
acc_test = mlp_d.score(X_test, y_test)
print('-' * 10 + 'd' + '-' * 10)
print('Train acc=%.2f\nTest acc = %.2f' % (100 * acc_train, 100 * acc_test))


mlp_e = MLPClassifier(solver='sgd', hidden_layer_sizes=(30, 20), activation='tanh', learning_rate='adaptive',
                      learning_rate_init=0.01, momentum=0.9, alpha=0.5, early_stopping=True)
mlp_e.fit(X_train, y_train)
acc_train = mlp_e.score(X_train, y_train)
acc_test = mlp_e.score(X_test, y_test)
print('-' * 10 + 'e' + '-' * 10)
print('Train acc=%.2f\nTest acc = %.2f' % (100 * acc_train, 100 * acc_test))
