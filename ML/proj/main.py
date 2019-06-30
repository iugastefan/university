import matplotlib.pyplot as plt
from scipy.stats import skew, kurtosis
from sklearn import model_selection
from sklearn.metrics import confusion_matrix
from sklearn.neural_network import MLPClassifier
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
import numpy as np
from os import listdir


# Functie pentru confusion matrix
# https://scikit-learn.org/stable/auto_examples/model_selection/plot_confusion_matrix.html
def plot_confusion_matrix(y_true, y_pred, classes,
                          normalize=False,
                          title=None,
                          cmap=plt.cm.Blues):
    """
    This function prints and plots the confusion matrix.
    Normalization can be applied by setting `normalize=True`.
    """
    if not title:
        if normalize:
            title = 'Normalized confusion matrix'
        else:
            title = 'Confusion matrix, without normalization'

    # Compute confusion matrix
    cm = confusion_matrix(y_true, y_pred)
    # Only use the labels that appear in the data
    if normalize:
        cm = cm.astype('float') / cm.sum(axis=1)[:, np.newaxis]
        print("Normalized confusion matrix")
    else:
        print('Confusion matrix, without normalization')

    fig, ax = plt.subplots()
    im = ax.imshow(cm, interpolation='nearest', cmap=cmap)
    ax.figure.colorbar(im, ax=ax)
    # We want to show all ticks...
    ax.set(xticks=np.arange(cm.shape[1]),
           yticks=np.arange(cm.shape[0]),
           # ... and label them with the respective list entries
           xticklabels=classes, yticklabels=classes,
           title=title,
           ylabel='True label',
           xlabel='Predicted label')

    # Rotate the tick labels and set their alignment.
    plt.setp(ax.get_xticklabels(), rotation=0, ha="right",
             rotation_mode="anchor")

    # Loop over data dimensions and create text annotations.
    fmt = '.1f' if normalize else 'd'
    thresh = cm.max() / 2.
    for i in range(cm.shape[0]):
        for j in range(cm.shape[1]):
            ax.text(j, i, format(cm[i, j], fmt),
                    ha="center", va="center",
                    color="white" if cm[i, j] > thresh else "black")
    fig.tight_layout()
    return ax


def calc_features(matrix):
    dispersie = matrix.var(axis=0)
    mediana = np.median(matrix, axis=0)
    abatere_standard = np.std(matrix, axis=0)
    maxim = matrix.max(axis=0)
    minim = matrix.min(axis=0)
    skew_temp = skew(matrix, axis=0)
    kurto = kurtosis(matrix, axis=0)
    matrix = matrix.mean(axis=0)
    matrix = np.append(matrix, [
        dispersie,
        mediana,
        abatere_standard,
        maxim,
        minim,
        skew_temp,
        kurto
    ])
    return matrix


def scrie_predicitii_in_fisier(predictii):
    with open('./submission.csv', 'a') as file:
        for x in zip(listdir('./test'), predictii):
            file.write(x[0][:-4] + ',' + str(int(x[1])) + '\n')


# Incarcarea datelor de test
def incarca_fisier_test():
    x_test = []
    for fisier in listdir('./test/'):
        temp = np.loadtxt('./test/' + str(fisier), delimiter=',')
        temp = calc_features(temp)
        x_test.append(temp)
    return x_test


# Incarcarea datelor de antrenare
def incarcare_date_antrenare():
    labels = np.loadtxt('./train_labels.csv', delimiter=',', skiprows=1).tolist()
    X_train = []
    y_train = []
    for label in labels:
        temp = np.loadtxt('./train/' + str(label[0])[:-2] + '.csv', delimiter=',')
        temp = calc_features(temp)
        X_train.append(temp)
        y_train.append(label[1])
    return X_train, y_train


X, Y = incarcare_date_antrenare()

# Impartirea datelor pentru antrenare
X_train, X_test, y_train, y_test = train_test_split(X, Y, random_state=0)

# X_train = X
# y_train = Y

# Folosim StandardScaler pentru a scala seturile de date
# Datele trebuie sa aiba media 0 si deviatia standard 1
scaler = StandardScaler()
scaler.fit(X_train)
X_train = scaler.transform(X_train)
X_test = scaler.transform(X_test)

# Folosim retele neuronale ca model
mlp = MLPClassifier(hidden_layer_sizes=(50, 50,), max_iter=1500)
mlp.fit(X=X_train, y=y_train)
y_predict = mlp.predict(X_test)

# Cross-validation scor
score_res = model_selection.cross_val_score(mlp, X, Y, cv=5)
print('Mean accuracy rate for a 3-fold cross-validation: %.2f' % (score_res.mean() * 100))
for i, x in enumerate(score_res):
    print('Fold: %d \t Scor: %.2f' % (i + 1, x * 100))

plot_confusion_matrix(y_test, y_predict, [x for x in range(1, 21)], True)
plt.show()

# scrie_predicii_in_fisier (mlp.predict(X_test))
