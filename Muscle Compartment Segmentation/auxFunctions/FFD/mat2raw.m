%> volume = mat2raw(volumeO,outputPath, fileName, dataType)
%> @file mat2raw.m
%> @author Ahmed Soliman
%> @date   January, 2014
%> @version 2.0
% ======================================================================
%> @brief mat2raw reader function
%>
%> This function converts a mat file to raw file.
% ======================================================================
function volume = mat2raw(volumeO,outputPath, fileName, dataType)

if(nargin<4)
    dataType = 'single';
end

if(nargin<3)
    fileName = 'rawVolum.raw';
    if(nargin == 1)
        outputPath = cd;
    end
end

volume = zeros(size(volumeO,2),size(volumeO,1),size(volumeO,3));
for i = 1:size(volumeO,3)
%         volume(:,:,i)=imrotate(volumeO(:,:,i),90);
        volume(:,:,i) = volumeO(:,:,i)';
end
          
if isequal(exist(outputPath, 'dir'),7) 
else
    outputPath=strcat(cd,'\',outputPath);
    mkdir(outputPath)
end

fid=fopen([outputPath '\' fileName '.raw'],'w+');
eval(sprintf('cnt=fwrite(fid,volume,''%s'');',dataType));
fclose(fid);
