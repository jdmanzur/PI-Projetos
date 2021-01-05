clear all 
close all
clc

pkg load image


function output =  ela(img, compression)

  %implementação de Error Level Analysis
  %salva a imagem em jpg, gerando compressao

  imwrite(img,'tmp.jpg','Quality',compression);
  img_ela = imread('tmp.jpg');


  %faz a subtração da imagem original com a imagem comprimida para observar as diferenças geradas pela compressao
  output = (abs(double(img)-double(img_ela))*15);

  output=mean(output,3);
  
endfunction




img = imread("images/4.jpg");
img_metadata = imfinfo("images/4.jpg");
img_metadata

output = ela(img, 70);
figure, imagesc(img);
figure, imagesc(output);


img_edited = imread("images/4-edited.jpg");
edited_metadata = imfinfo("images/4-edited.jpg");
edited_metadata

output = ela(img_edited, 70);

figure, imagesc(img_edited);

figure, imagesc(output);