%% expandEdges is a simple function to expand the edges for a 3D binary object

function [restored_img, xxRegion] = expandEdges(input_img, no_pixels)

% Initialization
restored_img = zeros(size(input_img));

% get current object and fill holes
brainObj = input_img~=0;
brainObj_Fill = imfill(brainObj,'holes');
newImg = brainObj_Fill;

% compute the required expanded region
if sum(newImg(:))~=0
    curDist_Map = distMap(newImg);
    xxRegion = (curDist_Map>=0)& (curDist_Map<=no_pixels);
else
    xxRegion = false(size(brainObj));
end

% restore the expanded region
restored_img = newImg;
restored_img(xxRegion) = max(newImg(:));

end
