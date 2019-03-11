%==========================================================================
% This function is used to read the 3D volumes with different sizes of certain format ( i.e., MAT,
% OBJ, etc.) in a given folder
%==========================================================================
% function Atlas_filtered = getInitialAtlas(dataDir, stripped, grey, updateAtlas_idx, FileType)
function Atlas_filtered = getInitialAtlas(Atlas, stripped)
function [obj] = update(obj, brain_Obj,seg_Obj)
%-----------------
% Function Inputs:
%-----------------
%1- dataDir         : ATLAS Directory
%2- stripped        : the BET stripped test brain
%3- grey            : the updated stripped test brain after thresholding
%4- updateAtlas_idx : the index for the brain tissue that will be restored
%in the atlas
%5- FileType        : The format of the files in the gallery

%-----------------
% Function Output:
%-----------------
%1- Atlas : N-Dimmensional Cell Containg all the 3D volumes in the input directory.

%==========================================================================

Atlas_bin      = getCandidateAtlas_bin_int(Atlas,stripped);

for i =1 : 2 : size(Atlas_bin,2)
    original = Atlas_bin{1,i};
    labeled = Atlas_bin{1,i+1};
    
    labeled( (stripped>0) & (labeled <= 0)) = max(max(max(labeled)));
    original = (labeled>0) .* original;
    
    Atlas_bin{1,i} = original;
    Atlas_bin{1,i+1} = labeled;
end

Atlas_filtered = getCandidateAtlas_RBG(Atlas_bin,stripped);

numBrains      = length(Atlas_filtered)/2;
fprintf('Total remaining atlas brains number = %d\n', numBrains);

