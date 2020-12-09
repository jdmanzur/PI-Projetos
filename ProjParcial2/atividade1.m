clear all 
close all
clc

pkg load image

%%%%%%%%%%%%%% Filtros por Direção %%%%%%%%%%%%%%%%

norte = [1 1 1 ; 1 -2 1; -1 -1 -1]; %NORTE
sul = [-1 -1 -1 ; 1 -2 1; 1 1 1]; %SUL
leste = [-1 1 1 ; -1 -2 1; -1 1 1]; %LESTE
oeste = [1 1 -1 ; 1 -2 -1; 1 1 -1]; %OESTE
nordeste = [1 1 1 ; -1 -2 1; -1 -1 1]; %NORDESTE
noroeste = [1 1 1 ; 1 -2 -1; 1 -1 -1]; %NOROESTE
sudeste = [-1 -1 1 ; -1 -2 1; 1 1 1]; %SUDESTE
sudoeste = [1 -1 -1 ; 1 -2 -1; 1 1 1]; %SUDOESTE

%-------------------------------------------------

img = imread("batatas.tif");
%img = rgb2gray(img);
figure, imshow(img);


%------------------ Convolução Aperíodica -------------------%

function conv_aperiodica(img, conv_ap)
  
  conv_ap
  
  [linha coluna] = size(img);

  img_res = zeros([linha coluna]);

  
  for i=1:linha
      for j=1:coluna
        
          soma = 0;
          k = 1;
          
          for indice_linha = i-1:i+1
              
             l = 1;   
             
             for indice_coluna = j-1:j+1
                  %checando se está dentro da matriz
                  if(indice_linha >= 1 && indice_linha <= linha && indice_coluna >= 1 && indice_coluna <= coluna)
                    soma=soma+(img(indice_linha,indice_coluna)*conv_ap(k,l));
                  endif
                  %se não estiver dentro, nada é acrescentado à soma
                  
                  l = l + 1;
            
             end
              k = k + 1;        
          end 
          
          if(soma < 0)  
            img_res(i,j) = 0 ;
          
          else
            if(soma > 255)
              img_res(i,j) = 255;
              
            else
              img_res(i,j) = soma;
              
            endif
              
          endif
            
          
          
     end
  end

  img_res = uint8(img_res);

  figure, imshow(img_res);
  
 endfunction
 
 conv_aperiodica(img, norte); %1
 
 conv_aperiodica(img, sul); %2
 
 conv_aperiodica(img, leste); %3
 
 conv_aperiodica(img, oeste); % 4
 
 conv_aperiodica(img, nordeste); %5
 
 conv_aperiodica(img, sudeste); %6

 conv_aperiodica(img, noroeste); %7
 
 conv_aperiodica(img, sudoeste); %8