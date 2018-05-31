function [ClusterIndex] = ReFindClusterIndex(InputData ,matA, centers)
count=size(matA,1);
dim = size(matA,2);
newMatA = zeros(count,dim,dim);
newCenters = zeros(count,dim);
sigmaboundary= chi2inv(0.99,dim);%sqrt(dim*4*100/9);%chi2inv(0.99,dim);
ClusterIndex = zeros(size(InputData,1),1);
for i=1:1:count
    matB = squeeze(matA(i,:,:));
    center = centers(i,:);
    mahaldist=(InputData(:,1:dim)-repmat(center,size(InputData,1),1))*matB.*(InputData(:,1:dim)-repmat(center,size(InputData,1),1));
    mahaldist = sum(mahaldist,2);
    [row col] = find(mahaldist<=sigmaboundary);
    for j=1:1:numel(row)
        if ClusterIndex(row(j),1)==0
            ClusterIndex(row(j),1)=i;
        else
           if norm(InputData(row(j),1:dim)-centers(ClusterIndex(row(j),1),:)) > norm(InputData(row(j),1:dim)-centers(i,:))
               ClusterIndex(row(j),1)=i;
           end   
            
        end
    end
end