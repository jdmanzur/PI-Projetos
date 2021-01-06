
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
