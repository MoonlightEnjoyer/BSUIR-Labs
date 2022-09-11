import math

import numpy as np
import matplotlib.pyplot as plt
from PIL import Image,ImageOps
from numpy import asarray

img = Image.open("amogus.jpg")
img.show()


source = asarray(img)
new_image = np.zeros(source.shape, source.dtype)
c1 = 0.212
c2 = 0.715
c3 = 0.072
y_red_values = [0] * 256
y_green_values = [0] * 256
y_values = [0] * 256
y_blue_values = [0] * 256

y_red_processed_values = [0] * 256
y_green_processed_values = [0] * 256
y_processed_values = [0] * 256
y_blue_processed_values = [0] * 256

y_red_filtered_values = [0] * 256
y_green_filtered_values = [0] * 256
y_filtered_values = [0] * 256
y_blue_filtered_values = [0] * 256
i = 0
for row in source:
    j = 0
    for elem in row:
        y = c1 * source[i, j, 0] + c2 * source[i, j, 1] + c3 * source[i, j, 2]
        y_values[int(y)] += 1
        y_red_values[source[i, j, 0]] += 1
        y_green_values[source[i, j, 1]] += 1
        y_blue_values[source[i, j, 2]] += 1
        if source[i, j, 0] < 155:
            new_image[i, j, 0] = source[i, j, 0]
        else:
            new_image[i, j, 0] = 255 - source[i, j, 0]

        if source[i, j, 1] < 155:
            new_image[i, j, 1] = source[i, j, 1]
        else:
            new_image[i, j, 1] = 255 - source[i, j, 1]

        if source[i, j, 2] < 155:
            new_image[i, j, 2] = source[i, j, 2]
        else:
            new_image[i, j, 2] = 255 - source[i, j, 2]
        y_processed= c1 * new_image[i, j, 0] + c2 * new_image[i, j, 1] + c3 * new_image[i, j, 2]
        y_processed_values[int(y_processed)] += 1
        y_red_processed_values[new_image[i, j, 0]] += 1
        y_green_processed_values[new_image[i, j, 1]] += 1
        y_blue_processed_values[new_image[i, j, 2]] += 1
        j += 1
    i += 1

Image.fromarray(new_image).show()

# im2 = ImageOps.solarize(img, threshold=155)
#
# im2.show()
filteredImage1 = np.zeros(source.shape, source.dtype)
filteredImage2 = np.zeros(source.shape, source.dtype)
filteredImage = np.zeros(source.shape, source.dtype)
i = 0
for row in source:
    j = 0
    for elem in row:
        if (i + 1 < len(source)) & (j + 1 < len(source[0])):
            filteredImage1[i, j, 0] = math.fabs(int(source[i, j, 0]) - int(source[i + 1, j + 1, 0]))
            filteredImage1[i, j, 1] = math.fabs(int(source[i, j, 1]) - int(source[i + 1, j + 1, 1]))
            filteredImage1[i, j, 2] = math.fabs(int(source[i, j, 2]) - int(source[i + 1, j + 1, 2]))

            filteredImage2[i, j, 0] = math.fabs(int(source[i + 1, j, 0]) - int(source[i, j + 1, 0]))
            filteredImage2[i, j, 1] = math.fabs(int(source[i + 1, j, 1]) - int(source[i, j + 1, 1]))
            filteredImage2[i, j, 2] = math.fabs(int(source[i + 1, j, 2]) - int(source[i, j + 1, 2]))

            filteredImage[i, j, 0] = math.sqrt(int(filteredImage1[i, j, 0]) ** 2 + int(filteredImage2[i, j, 0]) ** 2)
            filteredImage[i, j, 1] = math.sqrt(int(filteredImage1[i, j, 1]) ** 2 + int(filteredImage2[i, j, 1]) ** 2)
            filteredImage[i, j, 2] = math.sqrt(int(filteredImage1[i, j, 2]) ** 2 + int(filteredImage2[i, j, 2]) ** 2)
            y_filtered =c1 * filteredImage[i, j, 0] + c2 * filteredImage[i, j, 1] + c3 * filteredImage[i, j, 2]
            y_filtered_values[int(y_filtered)] += 1
            y_red_filtered_values[filteredImage[i, j, 0]] += 1
            y_green_filtered_values[filteredImage[i, j, 1]] += 1
            y_blue_filtered_values[filteredImage[i, j, 2]] += 1
        j += 1
    i += 1

Image.fromarray(filteredImage).show()
x_values = [0]*256
i = 0
while i < len(x_values):
    x_values[i] = i
    i += 1
plt.grid(True)
plt.title("Гистограмма яркости")
plt.bar(x_values, y_values)
plt.show()

plt.grid(True)
plt.title("Гистограмма яркости красного")
plt.bar(x_values, y_red_values, color = 'red')
plt.show()

plt.grid(True)
plt.title("Гистограмма яркости зелёного")
plt.bar(x_values, y_green_values, color = 'green')
plt.show()

plt.grid(True)
plt.title("Гистограмма яркости синего")
plt.bar(x_values, y_blue_values, color = 'blue')
plt.show()

plt.grid(True)
plt.title("Гистограмма яркости обработанного изображения")
plt.bar(x_values, y_processed_values)
plt.show()

plt.grid(True)
plt.title("Гистограмма яркости красного обработанного изображения")
plt.bar(x_values, y_red_processed_values, color = 'red')
plt.show()

plt.grid(True)
plt.title("Гистограмма яркости зелёного обработанного изображения")
plt.bar(x_values, y_green_processed_values, color = 'green')
plt.show()

plt.grid(True)
plt.title("Гистограмма яркости синего обработанного изображения")
plt.bar(x_values, y_blue_processed_values, color = 'blue')
plt.show()

plt.grid(True)
plt.title("Гистограмма яркости фильтрованного изображения")
plt.bar(x_values, y_filtered_values)
plt.show()

plt.grid(True)
plt.title("Гистограмма яркости красного фильтрованного изображения")
plt.bar(x_values, y_red_filtered_values, color = 'red')
plt.show()

plt.grid(True)
plt.title("Гистограмма яркости зелёного фильтрованного изображения")
plt.bar(x_values, y_green_filtered_values, color = 'green')
plt.show()

plt.grid(True)
plt.title("Гистограмма яркости синего фильтрованного изображения")
plt.bar(x_values, y_blue_filtered_values, color = 'blue')
plt.show()


