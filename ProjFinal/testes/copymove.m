function copymove(img)

  color=[0,0,255];
  RGBimage=img;
  grayimage=double(rgb2gray(RGBimage)); % convert RGB to gray
  [M ,N]=size(grayimage);
  B=50;%Block Dimension =B x B
  search_th=70;%threshold for search length in matching
  distance_th=70;
  num_blocks=(M-B+1)*(N-B+1);%number of blocks
  FVsize=13;%Feature Vector Length
  Similarity_threshold=0.5;%factor of similarity
  
  % get feature matrix (extract feature of all overlapped blocks)
  [FeatureMatrix,Locations]=getFeatureMatrix(grayimage,B,FVsize);
  % Sorting
  [FeatureMatrix,index]=sortrows(FeatureMatrix);
  Locations=Locations(index,:);
  % Matching (finding similar blocks)
  MatchList=getMatches(FeatureMatrix,Locations,Similarity_threshold,search_th,distance_th, 100, 1);
  num_matches=size(MatchList,1);
  % filtering

  % show result
  showMatches(RGBimage,MatchList,Locations,B,color,1,1,"result.jpg");

    
endfunction