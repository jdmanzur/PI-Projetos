function [MatchList ,num]=getMatches(FeatureMatrix,Locations,search_th,threshold,distance_th,size_matchlist,start)

 start=1;


 MatchList=[];
 MatchList=zeros(size_matchlist,2);

size_featurematrix=size(FeatureMatrix,1);
num=0;
for u=1:size_featurematrix-search_th
    for v=1:search_th
        if norm(Locations(u,:)-Locations(u+v,:))>distance_th %filtering by Distance Of Blocks == filter near blocks
            if isSimilar(FeatureMatrix(u,:),FeatureMatrix(u+v,:),threshold)%filtering by Similarity
                % u and u+v  are similar
                num=num+1;
                MatchList(num,:)=[start+u-1  start+u+v-1];
            end
        end
    end
end
end