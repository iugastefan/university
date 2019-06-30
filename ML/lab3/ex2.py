import numpy as np


class NaiveBayes:
    def __init__(self, num_bins, max_value):
        self.num_bins = num_bins
        self.bins = np.linspace(0, max_value, num=num_bins)

    def values_to_bins(self, x):
        new_x = np.digitize(x, self.bins)
        new_x = new_x - 1
        return new_x

    def fit(self, X, Y):
        self.num_samples = X.shape[0]
        self.num_features = X.shape[1]
        self.num_classes = np.max(Y) + 1
        X = self.values_to_bins(X)
        self.prob_classes = np.zeros(self.num_classes)
        for c in range(self.num_classes):
            self.prob_classes[c] = np.sum(Y == c) / self.num_samples
        self.prob_XcondY = np.zeros((self.num_classes, self.num_features, self.num_bins))
        for c in range(self.num_classes):
            Xc = X[Y == c, :]
            for i in range(self.num_features):
                for b in range(self.num_bins):
                    self.prob_XcondY[c, i, b] = np.sum(Xc[:, i] == b) / Xc.shape[0]
        self.prob_XcondY += 1e-10

    def predict(self, X_test):
        self.num_samples = X_test.shape[0]
        X_test = self.values_to_bins(X_test)
        prob_YcondX = np.zeros((self.num_samples, self.num_classes))
        for i in range(self.num_samples):
            for c in range(self.num_classes):
                prob_YcondX[i, c] = np.log(self.prob_classes[c])
                for j in range(self.num_features):
                    prob_YcondX[i, c] += np.log(self.prob_XcondY[c, j, X_test[i, j]])
        Y_test = np.argmax(prob_YcondX, axis=1)
        return Y_test

    def score(self, X_test, Y_test):
        Y_pred = self.predict(X_test)
        acc = (Y_test == Y_pred).mean()
        return acc


train_images = np.loadtxt('C:\\Users\\iugas\\university\\ML\\lab3\\data\\train_images.txt')
train_labels = np.loadtxt('C:\\Users\\iugas\\university\\ML\\lab3\\data\\train_labels.txt', 'int')
test_images = np.loadtxt('C:\\Users\\iugas\\university\\ML\\lab3\\data\\test_images.txt')
test_labels = np.loadtxt('C:\\Users\\iugas\\university\\ML\\lab3\\data\\test_labels.txt', 'int')
nb = NaiveBayes(3, 255)
nb.fit(train_images, train_labels)
acc = nb.score(test_images, test_labels)
print("acuratete  =  %.02f" % (acc * 100))
