%> Data_Imgs = getDicom(dataDir)
%> @file getDicom.m
%> @author Ahmed Soliman
%> @date   January, 2014
%> @version 2.0
% ======================================================================
%> @brief getDicom function
%>
%> This function .................................
% ======================================================================

%==========================================================================
% This function is used to read the DICOM images
%==========================================================================
function Data_Imgs = getDicom(dataDir)
%-----------------
% Function Inputs:
%-----------------
%1- dataDir   : Gallery Directory

%-----------------
% Function Output:
%-----------------
%1- Data_Imgs : N-Dimmensional Matrix Containg all the images in the input directory.

%==========================================================================

d = dir(dataDir);
% Removing subfolders
ifile = ~[d(:).isdir];          % Removing subfolders
imgfiles = {d(ifile).name}';

% Removing parent folders and Thumb.db file
imgfiles(ismember(imgfiles,{'.','..','Thumbs.db'})) = [];


numImgs = size(imgfiles,1);                           % Total number of Images
First_Img = double(dicomread([dataDir '\' char(imgfiles(1))]));
First_Img = First_Img(:,:,1);
[rows,cols] = size(First_Img);
Data_Imgs = zeros(rows,cols,numImgs);

for k = 1 : numImgs
    curImg = double(dicomread([dataDir '\' char(imgfiles(k))]));
    curImg = curImg(:,:,1);
    Data_Imgs(:,:,k) = curImg;
end

