%==========================================================================
% This function is used to read the 3D volumes with different sizes of certain format ( i.e., MAT,
% OBJ, etc.) in a given folder
%==========================================================================
           % obj.volume = getFinalAtlas(path, stripped, grey, thresh_idx_init, initSegmentation);
function Atlas_filtered = getFinalAtlas(dataDir, stripped, grey, initial_labeled, updateAtlas_idx, FileType)
%-----------------
% Function Inputs:
%-----------------
% 1- dataDir         : ATLAS Directory
% 2- stripped        : the BET stripped test brain
% 3- grey            : the updated stripped test brain after thresholding
% 4- initial_labeled : the intial labaled test brain
% 5- updateAtlas_idx : the index for the brain tissue that will be restored
% in the atlas
% 6- FileType        : The format of the files in the gallery

%-----------------
% Function Output:
%-----------------
% 1- Atlas : N-Dimmensional Cell Containg all the 3D volumes in the input directory.

%==========================================================================

if (nargin == 1)||(nargin == 2)||(nargin == 3)
    error('Missing the the stripped or the initial_labeled input brain');
elseif nargin == 4
    d = dir([dataDir '\*.mat']);
    updateAtlas_idx = [];
elseif nargin == 5
    d = dir([dataDir '\*.mat']);
else
    d = dir([dataDir '\*.' FileType]);
end

% Removing subfolders
ifile = ~[d(:).isdir];          % Removing subfolders
brainFiles = {d(ifile).name}';

% Removing parent folders and Thumb.db file
brainFiles(ismember(brainFiles,{'.','..','Thumbs.db'})) = [];

% Total number of Brains
numBrains  = size(brainFiles,1);

% Initializations
index=1;
Atlas      = cell(1,numBrains*2);
Atlas_updated = cell(1,numBrains*2);

% loop to read atlas brains
for k = 1 : numBrains
    
    % reading current brain atlas
%     current_ID = char(brainFiles(k));
    curImg     = load([dataDir '\' char(brainFiles(k))]);
    
    % original atlas
    labeled              = curImg.labeled;
    original             = (labeled>0) .* (fillHoles(curImg.original) + curImg.original);
%     original(original<0) = 1;
    Atlas{1,index}       = original;
    Atlas{1,index+1}     = labeled;
    
    % update atlas
    if ~isempty(updateAtlas_idx)
        labeled(updateAtlas_idx & (curImg.labeled <= 0)) = 4;
        original = (labeled>0) .* (fillHoles(curImg.original) + curImg.original);
    end

    % updated atlas
    Atlas_updated{1,index}   = original;
    Atlas_updated{1,index+1} = labeled;
    index = index+2;
    
end

% filter atlas based on dice similarity between different labels
[Atlas_dic, Atlas_updated_dic] = filterAtlasLabel(Atlas_updated, Atlas, initial_labeled);
Atlas_bin      = getCandidateAtlas_bin(Atlas_updated_dic, Atlas_dic,stripped);
Atlas_filtered = getCandidateAtlas_RBG(Atlas_bin,grey);
numBrains      = length(Atlas_filtered)/2;

fprintf('Final atlas brains number = %d\n', numBrains);
