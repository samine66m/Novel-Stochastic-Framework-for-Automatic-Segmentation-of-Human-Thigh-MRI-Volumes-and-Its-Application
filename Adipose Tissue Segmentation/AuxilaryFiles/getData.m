%==========================================================================
% This function is used to read the images of certain format ( i.e., bmp, 
% JPG, etc.) in a given folder 
%==========================================================================
function Data_Imgs = getData(dataDir,ImageType)
%-----------------
% Function Inputs:
%-----------------
%1- dataDir   : Gallery Directory
%2- ImageType : The format of the images in the gallery

%-----------------
% Function Output:
%-----------------
%1- Data_Imgs : N-Dimmensional Matrix Containg all the images in the input directory.

%==========================================================================

if nargin ==1
    d = dir([dataDir '\*.bmp']);
else
    
    d = dir([dataDir '\*.' ImageType]);
end

% Removing subfolders
ifile = ~[d(:).isdir];          % Removing subfolders
imgfiles = {d(ifile).name}';        

% Removing parent folders and Thumb.db file
imgfiles(ismember(imgfiles,{'.','..','Thumbs.db'})) = [];   


numImgs = size(imgfiles,1);                           % Total number of Images
First_Img = double(imread([dataDir '\' char(imgfiles(1))]));
First_Img = First_Img(:,:,1);
[rows,cols] = size(First_Img);
Data_Imgs = zeros(rows,cols,numImgs);

for k = 1 : numImgs

     curImg = double(imread([dataDir '\' char(imgfiles(k))]));
    curImg = curImg(:,:,1);
    Data_Imgs(:,:,k) = curImg;
end

