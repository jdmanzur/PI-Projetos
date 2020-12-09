clear all 
close all
clc

pkg load image


img = imread("cameraman.png");
img_ruidosa = imnoise(img, 'salt & pepper', 0.5);

%mostrando os subplots com as imagens original e com ruido
subplot(1, 2, 1), subimage(img), title('Original')
subplot(1, 2, 2), subimage(img_ruidosa), title('Com ruído')  

%utilizando transformacao rapida de fourier em ambas as imagens
img = fft2(img);
img_ruidosa = fft2(img_ruidosa);

%aplicnado passa alta e passa baixa nas imagens

