clear, clc, close all;
img = imread('cameraman.png');
img = imnoise(img, 'salt & pepper', 0.4);
figure, imshow(img);
img = im2double(img);

% Definição dos filtros
%h = (1/9)*[1 1 1;1 1 1;1 1 1]; %v = [0 -1 0;0 0 0; 0 1 0]; passa-baixa
h = (1/5)*[0 1 0;1 1 1;0 1 0]; %v = [0 -1 0;0 0 0; 0 1 0]; passa-baixa
%h = (1/32)*[1 3 1;3 16 3;1 3 1]; %v = [0 -1 0;0 0 0; 0 1 0]; passa-baixa
%h = [-1 -1 -1;-1 8 -1;-1 -1 -1]; %v = [0 -1 0;0 0 0; 0 1 0]; passa-alta

% Dimensões da imagem
s = size(img);

% Maior dimensão da imagem
DimMax = max(s);

% Cálculo da menor potência de 2 maior que dimensão máxima da imagem
M = log2(DimMax);
M = 2^ceil(M);

% Obtenção das DFTs e dos espectros de potência
FT = fft2(img,M,M); 
FTH = fft2(h,M,M);
SPEC_img = abs(fftshift(FT));
SPEC_h = abs(fftshift(FTH));
figure; imshow(log(SPEC_img+1),[]); title('Espectro original da FT da imagem');
figure; imshow(log(SPEC_h+1),[]); title('Espectro original da FT na direção de h');

% Filtragem realizada pelo produto ponto-a-ponto das transformadas
Y_h = FT.*FTH; 
y_h = ifft2(Y_h); 
y_h = y_h(1:s(1),1:s(2));

%Imagens resultantes
figure, imshow(y_h);
title('IDFT da imagem com filtro diferenciador na direção h');