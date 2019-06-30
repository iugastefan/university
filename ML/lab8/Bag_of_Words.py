import numpy as np
import pdb

class Bag_of_words:

    def __init__(self):
        self.vocabulary = {}
        self.vocabulary_length = 0

    def build_vocabulary(self, data):
  
        for document in data:
            for word in document: 
                if word not in self.vocabulary.keys():
                    self.vocabulary[word] = len(self.vocabulary) 
        self.vocabulary_length = len(self.vocabulary)

    def get_features(self, data):
        features = np.zeros((len(data), self.vocabulary_length)) 
        for document_idx, document in enumerate(data):
            for word in document:
                if word in self.vocabulary.keys():
                    features[document_idx, self.vocabulary[word]] = features[document_idx, self.vocabulary[word]] + 1

        return features
