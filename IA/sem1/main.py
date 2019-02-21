y_pred = [1, 1, 1, 0, 1, 0, 1, 1, 0, 0]
y_true = [1, 0, 1, 0, 1, 0, 1, 0, 1, 0]


def accuracy_score(y_pred, y_true):
    sum = 0
    for i in range(len(y_pred)):
        if y_true[i] == y_pred[i]:
            sum += 1
    return sum / len(y_pred)


accuracy_score(y_pred, y_true)


def precision_recall_score(y_pred, y_true):
    tp = 0
    fp = 0
    fn = 0
    for i in range(len(y_pred)):
        if y_true[i] != y_pred[i]:
            if y_pred[i] == 1:
                fp += 1
            else:
                fn += 1
        else:
            if y_pred[i] == 1:
                tp += 1
    precizie = tp / (tp + fp)
    recall = tp / (tp + fn)
    return precizie, recall


precision_recall_score(y_pred, y_true)


def mse(y_pred, y_true):
    sum = 0
    for i in range(len(y_pred)):
        sum += pow((y_pred[i] - y_true[i]), 2)
    return sum


mse(y_pred, y_true)


def mae(y_pred, y_true):
    sum = 0
    for i in range(len(y_pred)):
        sum += abs(y_pred[i] - y_true[i])
    return sum


mae(y_pred, y_true)
