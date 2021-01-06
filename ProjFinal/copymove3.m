function copymove3(img)
  color=[0,0,255];
  RGBimage = img;
  grayimage=double(rgb2gray(RGBimage)); % converter RGB to gray
  [M ,N]=size(grayimage); %pega o tamanho da imagem
  
  B=8;%tamanho do bloco em que a imagem será dividida
  search_th=10;%threshold for search length in matching
  distance_th=80;
  num_blocks=(M-B+1)*(N-B+1);%number of blocks
  FVsize=4;%Feature Vector Length
  Similarity_threshold=0.0015;%factor of similarity
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
  
  % get feature matrix (extract feature of all overlapped blocks)
  circle=false(B,B);
  for i=1:B
      for j=1:B
          if norm([i-(B+1)/2,j-(B+1)/2])<=B/2
              circle(i,j)=true;
          end
      end
  end
  %Quarters of square
  quarter1_mask=[zeros(B/2,B/2),ones(B/2,B/2); ...
      zeros(B/2,B/2), zeros(B/2,B/2)];
  quarter2_mask=[ones(B/2,B/2) , zeros(B/2,B/2); ...
      zeros(B/2,B/2), zeros(B/2,B/2)];
  quarter3_mask=[zeros(B/2,B/2) , zeros(B/2,B/2); ...
      ones(B/2,B/2), zeros(B/2,B/2)];
  quarter4_mask=[zeros(B/2,B/2) , zeros(B/2,B/2); ...
      zeros(B/2,B/2), ones(B/2,B/2)];
  %Quarters of circle
  q1=quarter1_mask & circle;
  q2=quarter2_mask & circle;
  q3=quarter3_mask & circle;
  q4=quarter4_mask & circle;
  area_quarter=sum(sum(q1));
  q1=q1/area_quarter;
  q2=q2/area_quarter;
  q3=q3/area_quarter;
  q4=q4/area_quarter;
  %
  [M ,N]=size(grayimage);
  num_blocks=(M-B+1)*(N-B+1);%number of blocks
  FeatureMatrix=zeros(num_blocks,FVsize);
  Locations=zeros(num_blocks,2);
  rownum=0;%row number in FeatureMatrix
  for x=1:N-B+1
      for y=1:M-B+1
          block=grayimage(y:y+B-1,x:x+B-1);
          rownum=rownum+1;
          %Store Features
          dct_block=dct2(block);%getting feature vectors
          FeatureMatrix(rownum,:)=[sum(sum(q1.*dct_block)), sum(sum(q2.*dct_block)),sum(sum(q3.*dct_block)),sum(sum(q4.*dct_block))];
          Locations(rownum,:)=[x,y];
      end
  end

  % Sorting
  [FeatureMatrix,index]=sortrows(FeatureMatrix);
  Locations=Locations(index,:);
  % Matching (finding similar blocks)
  start = 1;
  MatchList=[];
  size_featurematrix=size(FeatureMatrix,1);
  num=0;
  for u=1:size_featurematrix-search_th
      for v=1:search_th
          if norm(Locations(u,:)-Locations(u+v,:))>distance_th %filtering by Distance Of Blocks == filter near blocks
              if norm(FeatureMatrix(u,:)- FeatureMatrix(u+v,:)) <= Similarity_threshold%filtering by Similarity
                  % u and u+v  are similar
                  num=num+1;
                  MatchList(num,:)=[start+u-1  start+u+v-1];
              end
          end
      end
  end
  
  mask=false(B,B);
  for i=1:B
      for j=1:B
          if norm([i-(B+1)/2,j-(B+1)/2])<=B/2
              mask(i,j)=true;
          end
      end
  end
  [M,N,~]=size(RGBimage);
  num_matches=size(MatchList,1);
  %Mark Each Match in Map (binary image)
  map=false(M,N);
  if(~isempty(MatchList))
      for i=1:num_matches
          u=MatchList(i,1);
          v=MatchList(i,2);
          x1=Locations(u,1);
          y1=Locations(u,2);
          x2=Locations(v,1);
          y2=Locations(v,2);
          map(y1:y1+B-1,x1:x1+B-1)=mask|map(y1:y1+B-1,x1:x1+B-1);
          map(y2:y2+B-1,x2:x2+B-1)=mask|map(y2:y2+B-1,x2:x2+B-1);
      end
  end
  %Create Ultimate Result
  UltimateResult=RGBimage;
  Red=RGBimage(:,:,1);
  Green=RGBimage(:,:,2);
  Blue=RGBimage(:,:,3);
  Red(map(:))=color(1);
  Green(map(:))=color(2);
  Blue(map(:))=color(3);
  UltimateResult(:,:,1)=Red;
  UltimateResult(:,:,2)=Green;
  UltimateResult(:,:,3)=Blue;

  figure;
  imshow(RGBimage);
  title('Original');
  
  figure;
  imshow(map);
  title('Copy-Move Map');
  
  figure;
  imshow(UltimateResult);
  title('Copy-Move Detected');


endfunction