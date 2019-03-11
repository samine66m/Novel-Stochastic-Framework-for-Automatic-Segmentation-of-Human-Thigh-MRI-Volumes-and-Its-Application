%==========================================================================
% This function is used to calculate the 2D distance map of a binary image
%==========================================================================
% Written by:
% -----------
% Fahmi Khalifa
%==========================================================================
function [distMap,distMin,Xcx,Ycx] = distMap(inputImg,mapType)
%==========================================================================
%-----------------
% Function Inputs:
%-----------------
%1-inputImg : Binary input image.
%2- mapType : The type of the distance map +/- inside and +/- outside.

%-----------------
% Function Outputs:
%-----------------
%1- distMap : The calculated distance map matrix
%2- distMin : Minmum distance value.
%3- Xcx     : X coordinate for centroid point.
%4- Ycx     : Y coordinate for centroid point.

%==========================================================================
if nargin<2
    mapType = 'BiNegative';
end

inputImg = double(inputImg>0).*255;
[EdgeMap edgePnts] = Edges_2D(inputImg);
[r c f] = find(EdgeMap ==255);

[rows cols] = size(inputImg);
distMap = zeros(rows,cols);

switch mapType
    case 'UniPositive'
        for k1 = 1:rows
            for k2 = 1:cols
                g = inputImg(k1,k2);
                distVec = sqrt((k1 - r).^2 + (k2 - c).^2);
                minDist_Val = min(distVec);
                
                if g>100
                    distMap(k1,k2) = minDist_Val;
                else
                    distMap(k1,k2) = 0;
                end
            end
        end
        distMin=max(distMap(:));
        
        %==================================================================
    case 'UniNegative'
        for k1 = 1:rows
            for k2 = 1:cols
                g = inputImg(k1,k2);
                distVec = sqrt((k1 - r).^2 + (k2 - c).^2);
                minDist_Val = min(distVec);
                
                if g>100
                    distMap(k1,k2) = -minDist_Val;
                else
                    distMap(k1,k2) = 0;
                end
            end
        end
        distMin=min(distMap(:));
        
        %==================================================================
    case 'BiNegative'
        for k1 = 1:rows
            for k2 = 1:cols
                g = inputImg(k1,k2);
                distVec = sqrt((k1 - r).^2 + (k2 - c).^2);
                minDist_Val = min(distVec);
                
                if g>100
                    distMap(k1,k2) = -minDist_Val;
                else
                    distMap(k1,k2) = minDist_Val;
                end
            end
        end
        distMin=min(distMap(:));
        
        %==================================================================
    case 'BiPositive'
        for k1 = 1:rows
            for k2 = 1:cols
                g = inputImg(k1,k2);
                distVec = sqrt((k1 - r).^2 + (k2 - c).^2);
                minDist_Val = min(distVec);
                
                if g>100
                    distMap(k1,k2) = minDist_Val;
                else
                    distMap(k1,k2) = -minDist_Val;
                end
            end
        end
        distMin=max(distMap(:));
        
        %==================================================================
    otherwise
        error(' You must specify  "UniNegative" or " UniPositive" or "BiNegative" or "BiPositive" ')
        
end
[Xcx Ycx] = find(distMap == distMin);
end