import cv2
import numpy as np
from matplotlib import pyplot as plt

img = cv2.imread('/Users/haritjaiswal/Downloads/2020-chevrolet-corvette-stingray.png',0)
rows, cols = img.shape
print(rows,cols)
#cv2.namedWindow('Original image', cv2.WINDOW_NORMAL)
#cv2.imshow("Original image",img)
#cv2.waitKey(800)
#cv2.destroyAllWindows()
#cv2.destroyAllWindows()
print("before")
f = np.fft.fft2(img)
fshift = np.fft.fftshift(f) 
f_ishift = np.fft.ifftshift(fshift)
img_back = np.fft.ifft2(f_ishift)
print("done")
img_back = np.abs(img_back)
cv2.namedWindow('Retrieved image', cv2.WINDOW_NORMAL)
cv2.imshow("Retrieved image",img_back)
cv2.waitKey(800)
