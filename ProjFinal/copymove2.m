function copymove2(RGBimage)

grayimage=rgb2gray(RGBimage); % converter RGB to gray
[M ,N]=size(grayimage); %pega o tamanho da imagem
grayimage = resize(grayimage, [M/4, N/4]);
[M, N] = size(grayimage);
B=4; %bloco usado para analisar a imagem, dimensao B x B
num_blocks=(M-B+1)*(N-B+1); %numero de blocos na imagem
FVsize=4; %tamanho do vetor de atributoes
FeatureMatrix=zeros(num_blocks,FVsize+3); 

search_th=50; %threshold de procura
MinDistance=80; %distancia minima entre elementos
Similarity_th=0.5; %threshold de similaridade

%%Cria uma mascara circular
circle=ones(B,B);
for i=1:B
    for j=1:B
        if norm([i-(B+1)/2,j-(B+1)/2])<=B/2
            circle(i,j)=1;
        end
    end
end

%Quarters of square
quarter2_mask=[zeros(B/2,B/2),ones(B/2,B/2);zeros(B/2,B/2), zeros(B/2,B/2)];
quarter1_mask=[ones(B/2,B/2) , zeros(B/2,B/2);zeros(B/2,B/2), zeros(B/2,B/2)];
quarter3_mask=[zeros(B/2,B/2) , zeros(B/2,B/2);ones(B/2,B/2), zeros(B/2,B/2)];
quarter4_mask=[zeros(B/2,B/2) , zeros(B/2,B/2);zeros(B/2,B/2), ones(B/2,B/2)];
    
%Quarters of circle
quarter1_mask=quarter1_mask & circle;
quarter2_mask=quarter2_mask & circle;
quarter3_mask=quarter3_mask & circle;
quarter4_mask=quarter4_mask & circle;
area_quarter=sum(sum(quarter1_mask));

%Blocking & Extração de Atributos
rownum=1;
for i=1:M-B+1
    for j=1:N-B+1
        block=grayimage(i:i+B-1,j:j+B-1);
        Block_DCT=dct2(block);%DCT of Block
        v=([ uint8(sum(sum(quarter1_mask*Block_DCT)) ), uint8( sum(sum(quarter2_mask*Block_DCT)) ),uint8(sum(sum(quarter3_mask*Block_DCT))),uint8(sum(sum(quarter4_mask*Block_DCT)))]) /(B.^2/4);%Feature Vector
        %put block in a row
        FeatureMatrix(rownum,:)=[v ,i,j,std(double(block(:)),1)];
        rownum=rownum+1;
    end
end
max_std=max(FeatureMatrix(:,FVsize+3));
min_std=min(FeatureMatrix(:,FVsize+3));



%Ordenação
FeatureMatrix=sortrows(FeatureMatrix,1:FVsize);

%Combinando blocos similares e filtrando por distancia
mask=false(M,N);%ultimate mask of copy-move regions

matchlist=[];
dot=B;
min_th=0.0;
max_th=0.5;
%Similarity_factor=(max_th-min_th)/(max_std);
Similarity_factor = 0.0015;
for u=1:num_blocks
    search_depth=min(num_blocks-u,search_th);
    %num_blocks-u == number de blocos restantes
    threshold=Similarity_factor*FeatureMatrix(u,FVsize+3)+min_th;
    
    for v=1:search_depth
        if norm(FeatureMatrix(u,FVsize+1:FVsize+2)-FeatureMatrix(u+v,FVsize+1:FVsize+2))>MinDistance %filtering by Distance Of Blocks -- filter near blocks
            if norm(FeatureMatrix(u,1:FVsize)-FeatureMatrix(u+v,1:FVsize))<= threshold %Similarity_th %filtering by Similarity measure
                % u and u+v  are similar
                % mark in mask image
                mask(FeatureMatrix(u,FVsize+1):FeatureMatrix(u,FVsize+1)+dot-1,FeatureMatrix(u,FVsize+2):FeatureMatrix(u,FVsize+2)+dot-1)=1;
                mask(FeatureMatrix(u+v,FVsize+1):FeatureMatrix(u+v,FVsize+1)+dot-1,FeatureMatrix(u+v,FVsize+2):FeatureMatrix(u+v,FVsize+2)+dot-1)=1;
            end
        end
    end
end
%remove isolated regions
%area=round(0.001*M*N);
%mask=bwareaopen(mask,area,4);
% %Closing for fill holes
%mask=imclose(mask,[1 1 1;1 1 1; 1 1 1]);

%Mark Ultimate Result
ultimate= RGBimage;
red_channel=RGBimage(:,:,1);
green_channel=RGBimage(:,:,2);
blue_channel=RGBimage(:,:,3);
red_channel(mask(:))=255;
green_channel(mask(:))=255;
blue_channel(mask(:))=255;
ultimate(:,:,1)= red_channel;
ultimate(:,:,2)= green_channel;
ultimate(:,:,3)= blue_channel;
%show ultimate result
figure, imshow(ultimate);
figure, imshow(mask);
title('Ultimate Result');

endfunction