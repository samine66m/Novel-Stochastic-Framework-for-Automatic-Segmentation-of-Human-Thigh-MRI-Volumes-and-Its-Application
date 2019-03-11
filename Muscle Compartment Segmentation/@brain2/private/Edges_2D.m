%==========================================================================
% This function is used to find the edges of an object in a binary image
%==========================================================================
% Written by:
% -----------
% Fahmi Khalifa
%==========================================================================
function [edgeImg,edgePnts] = Edges_2D(inputImg)

%-----------------
% Function Input:
%-----------------
%1-inputImg : Input Binary Image

%-----------------
% Function Output:
%-----------------
%1-edgeImg: : Output Image with 255's (object edges) and 0's (otherwise).
%2-edgePnts : XY-locations of the edges (two column matrix)

%==========================================================================
inputImg = inputImg>0;
[rows cols] = size(inputImg);
edgeImg = zeros(rows,cols);


[Xedge Yedge] = find(inputImg ==1);
edgePnts = zeros(length(Xedge),2);
neededIndx = false(length(Xedge),1);
curCount = 0;

for k1 = 1:length(Xedge)
    curX = Xedge(k1);
    curY = Yedge(k1);
    qim = inputImg(curX,curY);
    
    if qim ==1
        
        if curX==1|curY==1|curX==rows|curY==cols% Points on Image edges
            edgeImg(curX,curY) = 255;
        else
            tempImg = inputImg(curX-1:curX+1,curY-1:curY+1);
            tempImg(2,2) = 0;   % Exclude the center point b/c it's already 1
            allPts = sum(tempImg(:));
            
            allPts2 = inputImg(curX-1,curY)+inputImg(curX+1,curY)+inputImg(curX,curY-1)+inputImg(curX,curY+1);
            if allPts<8 & allPts2<4
                curCount = curCount+1;
                edgeImg(curX,curY) = 255;
                edgePnts(curCount,1) = curX;
                edgePnts(curCount,2) = curY;
                neededIndx(curCount) = true;
                
            end
        end
        
    end
    
end
edgePnts = edgePnts(neededIndx,:);


end

