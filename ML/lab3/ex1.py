from skimage import io
# pentru afisarea imaginii
import numpy as np

train_images = np.loadtxt('C:\\Users\\iugas\\university\\ML\\lab3\\data\\train_images.txt')
train_labels = np.loadtxt('C:\\Users\\iugas\\university\\ML\\lab3\\data\\train_labels.txt', 'int')
for image in train_images:
    image = np.reshape(image, (28, 28))
    io.imshow(image.astype(np.uint8))
    io.show()
