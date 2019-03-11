%==========================================================================
% This function is used to read the 3D volumes with different sizes of certain format ( i.e., MAT,
% OBJ, etc.) in a given folder
%==========================================================================
function Atlas = getAtlas(dataDir,FileType)
%-----------------
% Function Inputs:
%-----------------
%1- dataDir   : ATLAS Directory
%2- FileType : The format of the files in the gallery

%-----------------
% Function Output:
%-----------------
%1- Atlas : N-Dimmensional Cell Containg all the 3D volumes in the input directory.

%==========================================================================

if nargin ==1
    d = dir([dataDir '\*.mat']);
else
    
    d = dir([dataDir '\*.' FileType]);
end

% Removing subfolders
ifile = ~[d(:).isdir];          % Removing subfolders
brainFiles = {d(ifile).name}';

% Removing parent folders and Thumb.db file
brainFiles(ismember(brainFiles,{'.','..','Thumbs.db'})) = [];


numBrains = size(brainFiles,1);    % Total number of Brains



Atlas      = cell(1,numBrains*2);
index=1;

% loop to read atlas brains
for k = 1 : numBrains
    
    % reading current brain atlas
    curImg     = load([dataDir '\' char(brainFiles(k))]);
    
    % original atlas
    labeled              = curImg.labeled;
    original             = curImg.original;
    original(original<0) = 1;
    
    Atlas{1,index}       = original;
    Atlas{1,index+1}     = labeled;
    index = index+2;

end
    %current_ID = char(brainFiles(k));
    fprintf('Total number of Atlas Brains = %d\n', numBrains);
 
