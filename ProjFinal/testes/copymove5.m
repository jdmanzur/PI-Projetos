
function copymove5(img)
      
  i2 = rgb2gray(img)
  [row, col]= size(i2);
  counti=0;
  countj=0;
  % S=zeros(1,2);
  % add2=zeros(size(S));
  %................OVERLAPPING BLOCKS.............................
  Blocks2 = cell(row/8,col/8);
  for x=1:row-7
      counti = counti + 1;
      countj = 0;
      for j=1:col-7
          
          countj = countj + 1;
          Blocks2{counti,countj} = i2(x:x+7,j:j+7);   
      end                                              
  end

   %...................Subtract each block with every other block.......  
  output=zeros([row, col]);                      
  for y= 1:57
      for j=1:57
           A2=Blocks2{y,j};
  %         [row1, col1]= size(A2);                       
          for k=y+1:57                                  
              for L=j+1:57 
                  A3= Blocks2{k,L};
                              Z= A3-A2;
                              Z(A3 == 255)= max(Z(:));
                              if all(Z > 0)
                              if all(Z == Z(1))
                                  output(y:y+7,j:j+7)=1;        
                                  output(k:k+7,L:L+7)=1;
                              end
                              end
               end
           end
      end
  end
         
  figure,imshow(output);
  title('output'); 
  
  
        compare_images = imabsdiff(i2,output);
        % Sizes match.  Subtract them and display the differences.
        figure;
        imshow(compare_images);

         
endfunction