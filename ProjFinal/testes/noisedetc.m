%incompleto 

function output = noisedetc(img, theta, limiar)
  
  grayscale = rgb2gray(img);
  
  [linha,coluna] = size(img)
  
  %calculando borda usando convolucao e o operador de sobel
  sobel=(1/4)*[-1 -2 -1; 0 0 0; 1 2 1];
  
  edge = conv(grayscale, sobel); %a borda é obtida aplicando o op. de sobel com convolução na imagem em grayscale
  
  R = zeros([linha, coluna]);
  D = imgradient(edge);
  
  %R = 1 se D está entre [0, theta] U [pi/2 - theta, pi/2 + theta] U [pi - theta, pi];
  
  %calculando diferença de segunda ordem d;  
  d = zeros([linha, coluna]);

  %weak horizontal edges
  for m=1 i:linha
    for n=1 j:coluna
        
        R(m, n) = (D(m, n) >= 0 && D(m, n) <= theta && D(m, n) >= pi/2 - theta && D(m, n) <= pi/2 + theta && D(m, n) >= pi - theta && D(m,n) <= pi);
        
        if(m + 1 > linha)
         Iplus = 0;
        else
          Iplus = img(m+1,n);
        end
        
        if(m-1 < 1)
          Iminus = 0;;
        
        else
          Iminus = img(m-1,n);
        end
                
                
        %|2*img(m,n) + I(m+1,n) + I(m-1,n)| 
        d(m, n) = abs(img(m,n)*2 + Iplus + Iminus);
        %diferenças maiores do que o limiar ou R=1 são descartadas
        if(R(m, n) == 1 || d(m,n) > limiar) d(m, n) = 0;      
        
    endfor
  endfor
  
  
  a = zeros([linha coluna]);
  a_r = zeros([linha coluna]);
  
  for m=1 i:linha
    for n=1 j:coluna
      for i = n-16:16
        if(i >=1 && i <= coluna)
          a(m, n) += d(m, i); 
        end
      endfor
      
       if(m - 16 < 1) k = 0;
       else k = m - 16;
       end
       if(m + 16 > linha) l = linha;
       else l = m + 16;
       end
     
      temp = a(k:l, n);
      a_r(m, n) = a(m, n) - median(temp, 'All');
    endfor
  endfor
 
  t = [];
  j = 1;
  %b - weak horizontal
  for m = 1: linha
    for n = 1: coluna
      for i = m-16:8:m+16
        if(i >= 1 && i <= linha)
            t[j] = a(i, n);
            j++
        end
      endfor
      b_h(m, n) = median(t, 'All');
    endfor
  endfor
  
  
  
  
  for m=1 i:linha
    for n=1 j:coluna
        
        R(m, n) = (D(m, n) >= 0 && D(m, n) <= theta && D(m, n) >= pi/2 - theta && D(m, n) <= pi/2 + theta && D(m, n) >= pi - theta && D(m,n) <= pi);
        
        if(n + 1 > coluna)
         Iplus = 0;
        else
          Iplus = img(m,n+1);
        end
        
        if(n-1 < 1)
          Iminus = 0;;
        
        else
          Iminus = img(m,n-1);
        end
                
                
        %|2*img(m,n) + I(m+1,n) + I(m-1,n)| 
        d(m, n) = abs(img(m,n)*2 + Iplus + Iminus);
        %diferenças maiores do que o limiar ou R=1 são descartadas
        if(R(m, n) == 1 || d(m,n) > limiar) d(m, n) = 0;      
        
    endfor
  endfor
  
  
  for m=1 i:linha
    for n=1 j:coluna
      for i = n-16:16
        if(i >=1 && i <= linha)
          a(m, n) += d(i, n); 
        end
      endfor
      
       if(n - 16 < 1) k = 0;
       else k = n - 16;
       end
       if(n + 16 > coluna) l = coluna;
       else l = n + 16;
       end
     
      temp = a(m, k:l);
      a_r(m, n) = a(m, n) - median(temp, 'All');
    endfor
  endfor
  
  
    t = [];
  j = 1;
  %b - weak vertical
  for m = 1: linha
    for n = 1: coluna
      for i = m-16:8:m+16
        if(i >= 1 && i <= coluna)
            t[j] = a(m, i);
            j++
        end
      endfor
      b_v(m, n) = median(t, 'All');
    endfor
  endfor
  
  BAG = b_v + b_h;  
  
 
  
endfunction
