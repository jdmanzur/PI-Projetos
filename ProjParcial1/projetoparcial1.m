%Projeto Parcial 1 - Processamento de Imagens
%Bruno Frítoli Carrazza - RA: 770993
%Jade Manzur de Almeida - RA: 771025
%------------------------------------------------------
close all; %fecha todas as janelas abertas
clear;     %limpa a memória
clc;       %limpa a área de trabalho
%------------------------------------------------------



pkg load image 

%



%ajeitar os limiares baseado no histograma
%repetir todos os processos pras demais imagens

function start(img, limiar_binarizacao,qtd_niveis, limiar_splitting,constante_splitting)
  
      max_imagens = 6;
      %-----------------------Função start-------------------------------------%
      %figure, imhist(img);
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

      %limiar = 100; %todo enfeitar

      img_binaria = img;

      for i =1:linha
        for j =1:coluna
          
          if img_binaria(i,j) >= limiar_binarizacao
            
              img_binaria(i,j) = 255;
          
          else
              img_binaria(i,j) = 0 ;
          end
          
        end
      end

      subplot(1, max_imagens, 3), subimage(img_binaria), title('Binarização') 


      %----------------------QUANTIZAÇÃO---------------------
      passo = f_max / qtd_niveis;

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
      %limiar = 100;
      


      for i = 1:linha
        for j = 1:coluna
            
            if img(i,j) >= limiar_splitting
              img_splitting(i,j) = img(i,j) + constante_splitting;
              
              if(img_splitting(i,j) > 255)
                img_splitting = 255;
              end
              
          
            
            else 
              
              img_splitting(i,j) = img(i,j) - constante_splitting;
              
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

endfunction

%------------------------------------------------------------

rice = imread("Banco_de_Imagens/rice.png");
%figure, imhist(rice);

%Rice limiar binarização = 100;
%Rice qtd_niveis quantização = 8
%Rice limiar splitting = 100;
%Rice constante splitting = 50;

start(rice, 100, 8, 100, 50);

%------------------------------------------------------------

mamografia = imread("Banco_de_Imagens/mamografia.bmp");
%figure, imhist(mamografia);

%Mam limiar binarizacao = 100;
%Mam qtd_niveis quantização = 8;
%Mam limiar splitting = 100;
%Mam constante splitting = 25;

start(mamografia, 100,8, 100, 25);

%------------------------------------------------------------

batatas = imread("Banco_de_Imagens/batatas.tif");
%figure, imhist(rice);

%Batatas limiar binarização = 95
%Batatas qtd_niveis quantização = 8
%Batatas limiar splitting = 95
%Batats constante splitting = 30

start(batatas,95,8,95,30)

%------------------------------------------------------------

solda = imread("Banco_de_Imagens/solda.bmp");
%figure, imhist(solda);

%Solda limiar binarização = 175
%Solda qtd niveis quantização = 8
%Solda limiar splitting = 175
%Solda constante splitting= 35

start(solda, 175, 8, 175, 35);

%------------------------------------------------------------


laranjas = imread("Banco_de_Imagens/laranjas.bmp");
%figure, imhist(laranjas);

%laranjas limiar binarização = 135
%laranjas qtd niveis quantização = 7
%laranjas limiar splitting = 135
%laranjas constante splitting= 35

start(laranjas, 135, 7, 135, 35);




