function [origData origLabel] = read_specific_no_of_data_from_file(filename,nooffeatures,noOfRecords)
% Reads the data from file(in the following format) and returns a data
% matrix and label matrix
% input: filename - Data file name (including the full path)
%              File format:
%                <f1>,<f2>,<f3>,...,<fn-1>,<fn>#N  -- For normal data (+ve examples)
%                <f1>,<f2>,<f3>,...,<fn-1>,<fn>#A  -- For anomalous data (-ve examples)
%                
%                 f1, f2, ...fn  -- attributes of data
%      nooffeatures - No of features

%open to find out number of data
fid=fopen(filename);
if (fid < 0)
   error(['Could not open ',filename,' for reading']);
end

if (noOfRecords > 0)
    nrc = noOfRecords;
else
    %find no of rows in the file
    nrc = 0;
    while 1
       tline = fgetl(fid);
       if ~ischar(tline)
            break;
       end;
       nrc = nrc + 1;
    end;
    fclose(fid);
end;

%open again and read data
fid=fopen(filename);
if fid < 0
   error(['Could not open ',filename,' for reading']);
end


%create empty data matrix
d = zeros(nrc,(nooffeatures)); % colums are for data features
L = zeros(nrc,1); % For original labels 
%d = zeros(noOfRecords,(nooffeatures)); % colums are for data features
%L = zeros(noOfRecords,1); % For original labels %read the data and assign it to matrix
rc = 0; %keep the row count

while rc < nrc
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end
    rc = rc + 1;
    tempDLine = tline;
    
    %read the original label 
    [token2, rem2] = strtok(tempDLine,'#');
    [token3, rem3] = strtok(rem2,'#');
    if (strcmp(token3,'N') == 1)
        L(rc,1) = 1;
    elseif (strcmp(token3,'A') == 1)
        L(rc,1) = -1;
    else
        fclose(fid);
        msg = sprintf('%s %d','Unrecignised label found in the original data!! at row num:',rc);
        error(msg);
    end;
    
    %read the attributes/fetures
    rem = token2;
    [token, rem] = strtok(rem,',');
    
    for (fc = 1:nooffeatures) % for each feature/attribute
        
        if (isempty(token))
            fclose(fid);
            msg = sprintf('%s %d','Data has missing features! at row num:',rc);
            error (msg);
        end;
        
        d(rc,fc) = str2num(token);
        [token, rem] = strtok(rem,',');
        
        if ((fc == nooffeatures) & (~isempty(token)))
            fclose(fid);
            msg = sprintf('%s %d','More than the required no of features found in the data file!! at row num:',rc);
            error(msg);
            return;
        end;
                   
    end;
   
end
fclose(fid);

origData = d;
origLabel = L;

return;
