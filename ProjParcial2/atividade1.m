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

%---------------------Leitura da Imagem -----------------------------------------

img = imread("rice_binary.png");

%img = rgb2gray(img);
%figure, imshow(img);


%------------------ Convolução Aperíodica -------------------%
 
 function img_final = conv_aperiodica(img, conv_ap)
    
  
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
            soma = 0 ;
          
          else
            if(soma > 255)
              soma = 255;
             endif
          endif
          
          img_res(i,j) = soma;
                        
     end
  end
  
  img_final = img_res;

  %img_res = uint8(img_res);
    
 endfunction
 
 


 
 %------------------ Convolução Períodica -------------------%

 function img_final = conv_periodica(img, conv_p)
   
  [linha coluna] = size(img);

  img_res = zeros([linha coluna]);

  
  for i=1:linha
      for j=1:coluna
          k = 1;
          
        
          soma = 0;
          for indice_linha = i-1:i+1
              
             l = 1;   
             
             for indice_coluna = j-1:j+1
               
                  temp_l = indice_linha;
                  temp_c = indice_coluna;
                  
                  
                  %checando se estoura pra cima
                  if(indice_linha < 1)
                    temp_l = linha;
                  endif
                                    
                  %checando se estoura pra baixo
                  if(indice_linha > linha)
                    temp_l = 1;
                  endif
                  
                  %checando se estoura pra esquerda
                  if(indice_coluna < 1)
                    temp_c = coluna;
                  endif
                   
                 %checando se estoura pra direita
                  if(indice_coluna > coluna)
                    temp_c = 1;
                  endif
                  
                  
                  soma=soma+(img(temp_l, temp_c)*conv_p(k,l));
         
                  l = l + 1;
        
             end
     
             k = k + 1;        
        
        end 
          
          if(soma < 0)  
            soma = 0 ;
          
          else
            if(soma > 255)
              soma = 255;
             endif
          endif
          
          img_res(i,j) = soma;
                        
     end
  end
  
  img_final = img_res;
  %img_res = uint8(img_res);
  
 endfunction



 
 %--------------------PLOTS-----------------------------------------------------
 
 img_norte = conv_periodica(img, norte); %chamando convolução períodica para o filtro norte
 figure
 subplot(2, 4 , 1), imshow(img_norte)
 title('Filtro Norte - Conv. Periodica')
 
 img_sul = conv_periodica(img, sul); %chamando conv. periodica para o filtro sul
 subplot(2, 4, 2), imshow(img_sul)
 title('Filtro Sul - Conv. Periodica')
 
 img_leste = conv_periodica(img, leste); %filtro leste
 subplot(2, 4 , 3), imshow(img_leste) 
 title('Filtro Leste - Conv. Periodica')

 img_oeste = conv_periodica(img, oeste); %filtro oeste
 subplot(2, 4, 4), imshow(img_oeste)
 title('Filtro Oeste - Conv. Periodica')
 
 img_norte2 = conv_aperiodica(img, norte); %chamando convolução aperíodica para o filtro norte
 subplot(2, 4, 5), imshow(img_norte2)
 title('Filtro Norte - Conv. Aperiodica')

 img_sul2 = conv_aperiodica(img, sul); %chamando conv. aperiodica para o filtro sul
 subplot(2, 4, 6), imshow(img_sul2)
 title('Filtro Sul - Conv. Aperiodica')
 
 img_leste2 = conv_aperiodica(img, leste); %filtro leste 
 subplot(2, 4, 7), imshow(img_leste2)
 title('Filtro Leste - Conv. Aperiodica')
 
 img_oeste2 = conv_aperiodica(img, oeste); %filtro oeste
 subplot(2, 4, 8), imshow(img_oeste2)
 title('Filtro Oeste - Conv. Aperiodica')
 
 %diff = img_norte2 - img_norte;
 %figure
 %imshow(diff)
