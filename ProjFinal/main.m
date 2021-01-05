%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Trabalho Final de Processamento de Imagens %
% Implementa��o por:                         %
% Bruno Carraza e Jade Manzur                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%limpa a tela
clear all 
close all
clc
%importa a biblioteca de imagens
pkg load image


function output =  ela(img, compression)

  %implementa��o de Error Level Analysis
  %salva a imagem em jp gerando compressao

  imwrite(img,'tmp.jpg','Quality',compression); 
  %salva uma imagem temporaria, comprimindo-a com uma certa taxa de qualidade
  img_ela = imread('tmp.jpg'); %l� a imagem salva


  %faz a subtracao da imagem original com a imagem comprimida para observar as diferen�as geradas pela compressao
  output = (abs(double(img)-double(img_ela))*15);

  %transforma a saida em grayscale;
  output=mean(output,3);
  
endfunction

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

img = imread("images/4.jpg");
img_metadata = imfinfo("images/4.jpg"); %l� os metadados da imagem
img_metadata %an�lise de metadados da imagen
output = ela(img, 70); %chama a fun��o de error level analysis

figure;
subplot(2, 2, 1), imagesc(img), title("Imagem Original"); 
%mostra as imagens na tela usando imagesc
subplot(2, 2, 2), imagesc(output), title("ELA - Imagem Original");


img_edited = imread("images/4-edited.jpg");
edited_metadata = imfinfo("images/4-edited.jpg");
edited_metadata

output = ela(img_edited, 70);

subplot(2, 2, 3), imagesc(img_edited), title("Imagem Editada");
subplot(2, 2, 4), imagesc(output), title("ELA - Imagem Editada");
