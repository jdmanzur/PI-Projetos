clear all 
close all
clc

pkg load image

%--------------------Filtros-------------------------------------------

%passabaixa = (1/9)*[1 1 1;1 1 1;1 1 1]; 
%passabaixa = (1/5)*[0 1 0;1 1 1; 0 1 0]; 
%passabaixa = (1/32)*[1 3 1;3 16 3;1 3 1];
passabaixa = (1/8)*[0 1 0; 1 4 1; 0 1 0];
%passabaixa = (1/25)*[1 1 1 1 1;1 1 1 1 1;1 1 1 1 1;1 1 1 1 1;1 1 1 1 1];
passaalta = [-1 -1 -1;-1 8 -1;-1 -1 -1]; 

%------------------Leitura da imagem -------------------------------------------

img = imread("cameraman.png");
img = im2double(img);

img_ruidosa = imnoise(img, 'salt & pepper', 0.4);

%mostrando os subplots com as imagens original e com ruido
subplot(1, 2, 1), subimage(img), title('Original')
subplot(1, 2, 2), subimage(img_ruidosa), title('Com ruído')  

% Dimensões da imagem em linha e coluna
[linha coluna] = size(img);
% calcula a maior dimensão da imagem e guarda em maxd
maxd = max([linha coluna]);

% calculo do teto da dimensão máxima da imagem e sua respectiva potencia de 2
menor_pot = log2(maxd);
menor_pot = 2^ceil(menor_pot);

%como as imagens tem as mesmas dimensões, basta calcular apenas uma vez

%--------------------------Transformações de Fourier

%utilizando transformacao rapida de fourier para aplicar passa alta e passa baixa nas imagens
img_fft = fft2(img, menor_pot, menor_pot); %transformação da imagem original
img_fft_ruido = fft2(img_ruidosa, menor_pot, menor_pot); %trans. da imagem ruidosa

filtro_passaalta = fft2(passaalta, menor_pot, menor_pot);
filtro_passabaixa = fft2(passabaixa, menor_pot, menor_pot); %transformação dos filtros passa baixa e alta


% filtragem realizada pelo produto ponto-a-ponto das transformadas da imagem ruidosa com os filtros
ruido_highpass = img_fft_ruido .* filtro_passaalta; 
ruido_lowpass = img_fft_ruido .* filtro_passabaixa;

%espectros de fourier
spec_img = abs(fftshift(img_fft));
spec_ruido = abs(fftshift(img_fft_ruido));

spec_passaalta = abs(fftshift(filtro_passaalta));
spec_passabaixa = abs(fftshift(filtro_passabaixa));

spec_r_highpass = abs(fftshift(ruido_highpass));
spec_r_lowpass = abs(fftshift(ruido_lowpass));


%-------------------------Plot dos Espectros------------------------------------

figure;
subplot(1, 4, 1), imshow(log(spec_img+1),[]); title('Espectro da imagem original');
subplot(1, 4, 2), imshow(log(spec_ruido+1), []); title('Espectro da imagem ruidosa');
ubplot(1, 4, 3), imshow(log(spec_r_highpass+1),[]); title('Espectro da imagem ruidosa + passa alta');
subplot(1, 4, 4), imshow(log(spec_r_lowpass+1), []); title('Espectro da imagem ruidosa + passa baixa');
%subplot(1, 6, 5), imshow(log(spec_passaalta+1),[]); title('Espectro do passa alta');
%subplot(1, 6, 6), imshow(log(spec_passabaixa+1), []); title('Espectro passa baixa');


%--------------------Transformadas Inversas-------------------------------------

res = ifft2(img_fft); %transformada inversa da imagem original
res = res(1:linha, 1:coluna);

res_r = ifft2(img_fft_ruido); %transformada inversa da imagem ruidosa
res_r = res_r(1:linha, 1:coluna);


%res = img_fft_ruido .* filtro_passaalta; 
res_highpass = ifft2(ruido_highpass); %transformada inversa da imagem filtrada com passa alta
res_highpass = res_highpass(1:linha, 1:coluna);

%res = img_fft_ruido .* filtro_passabaixa;
res_lowpass = ifft2(ruido_lowpass); %transformada inversa da imagem filtrada com passa baixa
res_lowpass = res_lowpass(1:linha, 1:coluna);

%------------Plot das Imagens----------------------------------------------------
figure; 
subplot(1, 4, 1), imshow(res), title('IDFT da imagem original');
subplot(1, 4, 2), imshow(res_r), title('IDFT da imagem ruidosa');
subplot(1, 4, 3), imshow(res_highpass), title('IDFT da imagem ruidosa + passa alta');
subplot(1, 4, 4), imshow(res_lowpass), title('IDFT da imagem ruidosa + passa baixa');

%--------------------------------------------------------------------------------