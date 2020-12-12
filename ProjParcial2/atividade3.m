clear all 
close all
clc

pkg load image
tam_fonte = 12; 
img = imread("rice_binary.png");

%img_pos_estruturante = imerode(img, strel('diamond',1));
%img_pos_estruturante = imdilate(img_pos_estruturante, strel('disk',1,0));
%img_pos_estruturante = imdilate(img_pos_estruturante, strel('disk',1,0));

img_pos_estruturante = imerode(img,strel('line',1,50));
img_pos_estruturante = imopen(img_pos_estruturante, strel('line', 2, 90));
img_pos_estruturante = imerode(img_pos_estruturante, strel('diamond', 1));
img_pos_estruturante = imopen(img_pos_estruturante, strel('rectangle', [2 2]));

%siovani essa combinação é a que funcionou melhor, 
%praticamente sem perdas de grãos pequenos e com uma boa separação de todo o resto

%figure, imshow(img);

%figure, imshow(img_pos_estruturante);

%rotulando as imagens originais com conectividade 4 e 8
rotulada4 = bwlabel(img, 4)
rotulada8 = bwlabel(img, 8);
rotulada_pos=bwlabel(img_pos_estruturante); % aplica o bwlabel para a imagem com abertura e erosao

figure, subplot(1, 3, 1), imshow(img),title("Original - Vizinhança 4");
qtd_regioes = max(max(rotulada4)); % qtd regiões rotuladas

props = regionprops(rotulada4,'Centroid', 'Area'); % centróides
for k = 1 : qtd_regioes % insere os rótulos das regiões
    pos_Centroid = props(k).Centroid;
    text(pos_Centroid(1)-2, pos_Centroid(2), num2str(k), 'FontSize', tam_fonte, 'FontWeight', 'Bold','Color', 'Red');
end


subplot(1, 3, 2), imshow(img),title("Original - Vizinhança 8");;
qtd_regioes = max(max(rotulada8)); % qtd regiões rotuladas

props = regionprops(rotulada8,'Centroid', 'Area'); % centróides
for k = 1 : qtd_regioes % insere os rótulos das regiões
    pos_Centroid = props(k).Centroid;
    text(pos_Centroid(1)-2, pos_Centroid(2), num2str(k), 'FontSize', tam_fonte, 'FontWeight', 'Bold','Color', 'Red');
end



subplot(1, 3, 3), imshow(img_pos_estruturante),title("Imagem Resultante");;
qtd_regioes = max(max(rotulada_pos)); % qtd regiões rotuladas

props = regionprops(rotulada_pos,'Centroid', 'Area'); % centróides
for k = 1 : qtd_regioes % insere os rótulos das regiões
    pos_Centroid = props(k).Centroid;
    text(pos_Centroid(1)-2, pos_Centroid(2), num2str(k), 'FontSize', tam_fonte, 'FontWeight', 'Bold','Color', 'Red');
end
