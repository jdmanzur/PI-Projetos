%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Trabalho Final de Processamento de Imagens %
% Implementação por:                         %
% Bruno Carraza e Jade Manzur                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%limpa a tela
clear all 
close all
clc
%importa a biblioteca de imagens
pkg load image


function output =  ela(img, compression)

  %implementação de Error Level Analysis
  %salva a imagem em jpg, gerando compressao

  imwrite(img,'tmp.jpg','Quality',compression); 
  %salva uma imagem temporaria, comprimindo-a com uma certa taxa de qualidade
  img_ela = imread('tmp.jpg'); %lê a imagem salva


  %faz a subtração da imagem original com a imagem comprimida para observar as diferenças geradas pela compressao
  output = (abs(double(img)-double(img_ela))*15);

  %transforma a saída em grayscale;
  output=mean(output,3);
  
endfunction


img = imread("images/4.jpg");
img_metadata = imfinfo("images/4.jpg"); %lê os metadados da imagem
img_metadata %análise de metadados da imagen
output = ela(img, 70); %chama a função de error level analysis

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
