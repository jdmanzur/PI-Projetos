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