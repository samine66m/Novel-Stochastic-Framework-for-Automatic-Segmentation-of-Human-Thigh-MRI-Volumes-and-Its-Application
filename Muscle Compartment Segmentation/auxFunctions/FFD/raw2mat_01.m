%> volume = volume = raw2mat(FilePath)
%> @file raw2mat.m
%> @author Ahmed Soliman
%> @date   January, 2014
%> @version 2.0
% ======================================================================
%> @brief raw2mat reader function
%>
%> This function converts a raw file to mat file.
% ======================================================================

function volume = raw2mat_01(FilePath)

% [rootPath fileName extension] = fileparts(FilePath);
[rootPath, ~, ~] = fileparts(FilePath);

assert(exist(FilePath,'file')~=0);  % Assert that the file exist

fid = fopen(FilePath,'r'); % Open text file
InputText=textscan(fid,'%s',20,'delimiter','\n');  % Read strings delimited by a carriage return
FileIines = InputText{1};
for index = 1 : size(FileIines,1)
    InputLine=textscan(FileIines{index},'%s',5,'delimiter',' ');
    LineWords = InputLine{1};
    switch LineWords{1}
        case 'ElementDataFile'
            volume_name = LineWords{3};
        case 'ElementType'
            dataType = LineWords{3};
        case 'DimSize'
            DimSize = [0 0 0];
            DimSize(1) = eval(LineWords{3});
            DimSize(2) = eval(LineWords{4});
            if(length(LineWords) == 5)
                DimSize(3) = eval(LineWords{5});
            else
                DimSize(3)= 1;
            end
    end
end
fclose(fid);

mdataType = getMDataType(dataType);
fin=fopen(strcat(rootPath,'\',volume_name),'r');
eval(sprintf('I=fread(%f,%d,''%s=>%s'');', fin, DimSize(1)*DimSize(2)*DimSize(3), mdataType, mdataType));
% Z = reshape(I,DimSize(1),DimSize(2),DimSize(3));
% volume = zeros(DimSize(2),DimSize(1),DimSize(3));


% % Z = reshape(I,DimSize(2),DimSize(1),DimSize(3));
% % volume = zeros(DimSize(1),DimSize(2),DimSize(3));
% % for i=1:size(volume,3)
% %     volume(:,:,i)=Z(:,:,i)';
% % end
volume = reshape(I,DimSize(1),DimSize(2),DimSize(3));
end

function mdataType = getMDataType(dataType)
switch dataType
    case 'MET_CHAR'
        mdataType = 'int8';
    case 'MET_UCHAR'
        mdataType = 'uint8';
    case 'MET_SHORT'
        mdataType = 'int16';
    case 'MET_USHORT'
        mdataType = 'uint16';
    case 'MET_INT'
        mdataType = 'int32';
    case 'MET_UINT'
        mdataType = 'uint32';
    case 'MET_FLOAT'
        mdataType = 'single';
    case 'MET_DOUBLE'
        mdataType = 'double';
        
end
end

