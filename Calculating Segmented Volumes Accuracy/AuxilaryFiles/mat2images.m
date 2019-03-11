%> mat2images(matVol,outputPath,imgFormat)
%> @file mat2images.m
%> @author Ahmed Soliman
%> @date   January, 2014
%> @version 2.0
% ======================================================================
%> @brief mat2images function
%>
%> This function .................................
% ======================================================================

function mat2images(matVol,outputPath,imgFormat)

if nargin ==2
    imgFormat='bmp';
end
% imgFormat=strcat('.',imgFormat);

if isequal(exist(outputPath, 'dir'),7) % 7 = directory.
else
%     outputPath=strcat(cd,'\',outputPath)
    mkdir(outputPath)
end


for i=1:size(matVol,3)
    
    saveName = sprintf('%s%s%.3d.%s',outputPath,'\Slice_',i,imgFormat);
%    imwrite(matVol(:,:,i),saveName);
    imwrite(matVol(:,:,i)./max(max(max(matVol))),saveName,imgFormat);
%      imwrite(matVol(:,:,i)./255,saveName);
    
end
