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
pkg load signal

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%img = imread("images/4.jpg");
%img_metadata = imfinfo("images/1.jpg"); %l� os metadados da imagem
%img_metadata %an�lise de metadados da imagen
%output = ela(img, 70); %chama a fun��o de error level analysis


%figure;
%subplot(2, 2, 1), imagesc(img), title("Imagem Original"); 
%mostra as imagens na tela usando imagesc
%subplot(2, 2, 2), imagesc(output), title("ELA - Imagem Original");


%img_edited = imread("images/4-edited.jpg");

%edited_metadata = imfinfo("images/4-edited.jpg");
%edited_metadata

%output = ela(img_edited, 70);
%subplot(2, 2, 3), imagesc(img_edited), title("Imagem Editada");
%subplot(2, 2, 4), imagesc(output), title("ELA - Imagem Editada");


%teste
img_cpytest = imread("images/1-edited.jpg");
copymove2(img_cpytest);
