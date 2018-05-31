function [ENOF]=ENOF_llv(matA,center)
D=2;
numrow = size(matA,1);
k= round(0.25*numrow); %k nearest neighbour ellipsoids,25% coverage
% k= round(0.5*numrow); 
% k= round(1*numrow); 
% if k==0 %only form one ellipsoid,no neighbour
%     k=1;
% end
z=1; %determines the sensitivity of the detector.
effRadTH = chi2inv(0.99,D);
for i=1:numrow
    CurEllipseMatrixA = squeeze(matA(i,:,:));
    CurEllipseCenter = center(i,:);
    for j=1:numrow       
        if (j==i)
            FocalSim(i,j) = 0;  %distance to itself is zero
        else
            FocalSim(i,j) = FocalDistancemd(CurEllipseMatrixA/effRadTH,CurEllipseCenter,squeeze(matA(j,:,:))/effRadTH,center(j,:));
        end;
    end
    FocalSim_sorted=sort(FocalSim(i,:));
    kd(i)=FocalSim_sorted(k+1); %each row has a '0'
    %a set of k nearest neighbour ellipsoids denoted by NNk(i)
    for n=1:k
    NNK(i,n)=find(FocalSim(i,:)==FocalSim_sorted(n+1));
    end
    NNK_length(i)=k;  
end
for i=1:numrow
    sum=0;
    for j=1:numrow 
        RDK(i,j)=max(kd(j),FocalSim(i,j)); 
        if any(j==NNK(i,:))
            sum=sum+RDK(i,j);
        end
        NRD(i)=NNK_length(i)/sum;
    end
end
for i=1:numrow
    sum=0;
    for j=1:numrow 
        if any(j==NNK(i,:))
            sum=sum+NRD(j);
        end
        ENOF(i)=1/NRD(i)*sum/NNK_length(i);
    end
end
end