import csv
import re

import numpy as np
from sklearn import preprocessing
from sklearn.kernel_ridge import KernelRidge
from sklearn.metrics import mean_squared_error, mean_absolute_error


# from Bag_of_Words import *

class Bag_of_Words:
    def __init__(self):
        self.vocabulary = dict()

    def build_vocabulary(self, data):
        idx = 0
        for x in data:
            for y in x:
                if y not in self.vocabulary:
                    self.vocabulary[y] = idx
                    idx += 1

    def get_features(self, data):
        features = np.zeros((len(data), len(self.vocabulary)))
        for i, essay in enumerate(data):
            for word in essay:
                if word in self.vocabulary:
                    features[i, self.vocabulary[word]] += 1
        return features


def read_data(file_path):
    data = []
    scores = []

    with open(file_path, mode='r') as csv_file:
        csv_reader = csv.DictReader(csv_file)
        for row in csv_reader:
            data.append(re.sub("[-.,;:!?\"\'\/()_*=`]", "", row["essay"].lower()).split())
            scores.append(int(row["score"]))
    return data, scores


train_data, train_scores = read_data("Data/train_data.csv")
test_data, test_scores = read_data("Data/test_data.csv")

print("Train data length: texts: %d, scores: %d" % (len(train_data), len(train_scores)))
print("Test data length: texts: %d, scores: %d" % (len(test_data), len(test_scores)))

bow = Bag_of_Words()
bow.build_vocabulary(train_data)
print("Voc size: %d" % len(bow.vocabulary))
train_features = bow.get_features(train_data)
test_features = bow.get_features(test_data)

scaler = preprocessing.Normalizer('l2')
scaler.fit(train_features)
train_features = scaler.transform(train_features)
test_features = scaler.transform(test_features)

krr = KernelRidge(alpha=10 ** (-4.25), kernel='linear')
krr.fit(train_features, train_scores)
predicted_scores_train = krr.predict(train_features)
predicted_scores_test = krr.predict(test_features)

print("MSE train: ", mean_squared_error(train_scores, predicted_scores_train))  # 0.643
print("MSE test: ", mean_squared_error(test_scores, predicted_scores_test))  # 1.080
print("MAE train: ", mean_absolute_error(train_scores, predicted_scores_train))  # 0.630
print("MAE test: ", mean_absolute_error(test_scores, predicted_scores_test))  # 0.832
print("=" * 30)

lmb = 10 ** -4.25
n = train_features.shape[0]
K = np.matmul(train_features, train_features.T)
alpha = np.matmul(np.linalg.inv(K + lmb * np.eye(n)), train_scores)

Y_train = np.matmul(K, alpha)

K_test = np.matmul(test_features, train_features.T)
Y_test = np.matmul(K_test, alpha)
print("MSE train: ", mean_squared_error(train_scores, Y_train))  # 0.643
print("MSE test: ", mean_squared_error(test_scores, Y_test))  # 1.080
print("MAE train: ", mean_absolute_error(train_scores, Y_train))  # 0.630
print("MAE test: ", mean_absolute_error(test_scores, Y_test))  # 0.832
