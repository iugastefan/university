import numpy as np
from skimage import io
import matplotlib.pyplot as plt
import os

# y = np.array([[[1, 2, 3, 4], [5, 6, 7, 8]], [[1, 2, 3, 4], [5, 6, 7, 8]], [[1, 2, 3, 4], [5, 6, 7, 8]]])
# print(y.shape)
# print(np.sum(y, axis=0))  # => [[1. 2. 3. 4.]#     [5. 6. 7. 8.]]
# print(np.sum(y, axis=1))
# print(np.sum(y, axis=2))
#
#
# x = np.arange(0, 3 * np.pi, 0.1)
# y = np.sin(x)  # Ploteaza punctele
# z = np.cos(x)  # Ploteaza punctele
# plt.subplot(2,2,1)
# plt.plot(x, y,'1')  # Adauga etichete pentru fiecare axa
# plt.subplot(2,2,2)
# plt.plot(x, z,'2')  # Adauga etichete pentru fiecare axa
# plt.subplot(2,2,3)
# plt.plot(x)
# plt.xlabel('x axis label')
# plt.ylabel('y axis label')  # Adauga titlu
# plt.title('Sine and cosine')  # Adauga legenda
# plt.legend(['Sine', 'Cosine'])  # Afiseaza figura
# plt.show()

path = 'C:\\Users\\iugas\\university\\IA\\sem3\\Data\\images\\'
imgs_array = []
for file in os.listdir(path):
    image = np.load(path + file)
    imgs_array.append(image)
    # io.imshow(image)
    # io.show()
imgs_array = np.array(imgs_array)
print(imgs_array.shape)

# 1.b
suma_imgs = np.sum(imgs_array, axis=0)
print(suma_imgs.shape)
print(suma_imgs)
io.imshow(suma_imgs.astype(np.uint8))
io.show()

# 1.c
suma_imgs = np.sum(imgs_array, axis=(1, 2))
print(suma_imgs.shape)
print(suma_imgs)

print('Index max este: ', np.argmax(suma_imgs))
