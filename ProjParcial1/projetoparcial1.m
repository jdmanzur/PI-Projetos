%Projeto Parcial 1 - Processamento de Imagens
%Bruno Fr�toli Carrazza - RA: 770993
%Jade Manzur de Almeida - RA: 771025
%------------------------------------------------------
close all; %fecha todas as janelas abertas
clear;     %limpa a mem�ra
clc;       %limpa a �rea de trabalho
%------------------------------------------------------

pkg load image 

img = imread("Banco_de_Imagens/rice.png");

max_imagens = 6

%ajeitar os limiares baseado no histograma
%repetir todos os processos pras demais imagens

%-----------------------Função start-------------------------------------
figure, imhist(img);
figure, subplot(1,max_imagens , 1), subimage(img), title('Imagem Original')


%se a imagem estiver em rgb, colocar em escala de cinza;
if isrgb(img) == 1
  img = rgb2gray(img);
endif

[linha coluna] = size(img);

%----------------------AUTOESCALA----------------------

img_autoescola = zeros(linha,coluna);
f_max = max(max(img));
f_min = min(min(img));

for i =1:linha
  for j =1:coluna
    
    img_autoescala(i, j) =  (255 / (f_max - f_min)) * (img(i,j) - f_min);  
    
  end
end

subplot(1, max_imagens , 2), subimage(img_autoescala), title('Autoescala') 


%----------------------BINARIZAÇÃO---------------------

limiar = 100; %todo enfeitar

img_binaria = img;

for i =1:linha
  for j =1:coluna
    
    if img_binaria(i,j) >= limiar
      
        img_binaria(i,j) = 255;
    
    else
        img_binaria(i,j) = 0 ;
    end
    
  end
end

subplot(1, max_imagens, 3), subimage(img_binaria), title('Binarização') 


%----------------------QUANTIZAÇÃO---------------------
passo = f_max / 8;

for i = 1:linha
  for j = 1:coluna
    
    img_quantizacao(i,j) = round(img(i,j)/passo)*passo;
    
    %garantindo que o arredondamento nao passe dos valores limite de cinza
    if img_quantizacao(i,j) > 255
        img_quantizacao(i,j) = 255
    else
        
        if img_quantizacao(i,j) < 0
          img_quantizacao(i,j) = 0;
        endif
    endif    
  endfor
endfor


subplot(1, max_imagens, 4), subimage(img_quantizacao), title('Quantização') 

%----------------------SPLITTING-----------------------
limiar_splitting = 50;
constante = 50;


for i = 1:linha
  for j = 1:coluna
      
      if img(i,j) >= limiar
        img_splitting(i,j) = img(i,j) + constante;
        
        if(img_splitting(i,j) > 255)
          img_splitting = 255;
        end
        
    
      
      else 
        
        img_splitting(i,j) = img(i,j) - constante;
        
          if(img_splitting(i,j) < 0)
            img_splitting = 0;
          end
      
      end
      
      
  end
end  

subplot(1, max_imagens, 5), subimage(img_splitting), title('Splitting') 



%----------------------EQUALIZAÇÃO---------------------
img_equalizada = histeq(img);



subplot(1, max_imagens, 6), subimage(img_equalizada), title('Equalização') 
