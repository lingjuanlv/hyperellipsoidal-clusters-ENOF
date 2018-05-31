%======================================================
% Author: Masud Moshtaghi
% Created: 2009-08-17
% A simple example that uses HyCARCE to obtain cluster in 
% normalized S1 dataset
%=======================================================
load SDataset
D=2;
MatrixA=[];
Centers=[];
dataset = s1normal;
[matA center clusterindex dCountHistory] = HyCARCE(dataset,D,0.1); % data, enlarge threshold,dimesion,gridcell size
if (D==2)
 for i=1:1:size(matA,1)
     Ellipse_Plot(squeeze(matA(i,:,:))/chi2inv(0.99,D),center(i,:),i);
     hold on;
 end
 plot(dataset(:,1),dataset(:,2),'s','MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[0 0 1],'MarkerSize',4);
end
clear D dataset