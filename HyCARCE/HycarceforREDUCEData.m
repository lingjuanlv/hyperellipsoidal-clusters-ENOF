%======================================================
% Author: Sutharshan Rajasegarar
% Created: 20-07-2011
% Use HyCARCE on REEDUCE data to obtain ellipsoidal clusters 
%=======================================================

%load data
dataSetName = 'REDUCE' 
noOfNodes =  9 
noOfFeatures = 11 
noOfrecords = 2500; 
infilepath = strcat('D:\Uni\Research area\work results\Surrey-Uni-Work\REDUCE\Dataset\DataPerNode\selectedRecords\SelectedNormalised\');


nodeName = 'N'
for i=1:1:noOfNodes+1
    if (i==noOfNodes+1)
       infilename = strcat(infilepath,nodeName,'_N.txt');
    else        
       infilename = strcat(infilepath,nodeName,num2str(i),'_N.txt');
    end;

    %'PIR','vib','mic','temp','light','watts','frequency','RMS_voltage','RMS_current','reactive_power','phase_angle'

    [X1 OrigLabel] = read_specific_no_of_data_from_file(infilename, noOfFeatures,noOfrecords);
    X = [X1(:,6) X1(:,10) X1(:,11)];
    %X = [X1(:,10) X1(:,11)];

    %Inputdata format: (v1,v2,..,vD,1(reserved),weight,clusterlabel)
    %Weight can be a natural number that gives a weight to some of the samples and it only work for 2D data. In all other cases this field should be 1
    data = [X ones(size(X,1),3)];  
    D=size(X,2)
    MatrixA=[];
    Centers=[];
    [matA center clusterindex dCountHistory] = HyCARCE(data,D,0.1); % data, enlarge threshold,dimesion,gridcell size
    if (D==2)
     figure
     for i=1:1:size(matA,1)
         
         Ellipse_Plot(squeeze(matA(i,:,:))/chi2inv(0.99,D),center(i,:),i);
         hold on;
     end
     plot(data(:,1),data(:,2),'s','MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[0 0 1],'MarkerSize',4);
    end
    clear D dataset
end;