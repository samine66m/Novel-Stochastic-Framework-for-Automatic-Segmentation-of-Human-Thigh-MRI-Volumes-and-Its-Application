%==========================================================================
%mask of MRI Volumes
%==========================================================================
%Author: Samineh Mesbah
%==========================================================================
%ALL RIGHTS RESERVED
%==========================================================================
%Reference: "Novel Stochastic Framework for Automatic Segmentation of Human
%Thigh MRI Volumes and Its Applications in Spinal Cord Injured Individuals"
%==========================================================================
%This code calculates the mask of MRI Volumes in Axial view (FS and WS)


function Whole_ROI = Get_Mask(FS_Scan,WS_Scan)

%%===================Whole_ROI segmentation============================
thigh_mus=FS_Scan(:,:,size(FS_Scan,3)-endZ:size(FS_Scan,3)-startZ);
thigh_fat=WS_Scan(:,:,size(WS_Scan,3)-endZ:size(WS_Scan,3)-startZ);
thigh_mus_fat=thigh_mus+thigh_fat;
thigh_mus_fat=round((thigh_mus_fat./max(thigh_mus_fat(:))).*500);
thigh_mus_fat=padarray(thigh_mus_fat,[size(thigh_mus_fat,2)-size(thigh_mus_fat,1) 0],'pre');


Y_gray = uint8(thigh_mus_fat);
q=0:255;                                 % Gray Level
allHist=zeros(1,256);         %Initializing the Origional Image Histogram
for h = 0:max(q)
    [R C F] = find(Y_gray == h);
    allHist(h+1) = sum(F);
end
final_Hist=allHist./sum(allHist);

%%======smoothing the histogram=============================================

for k = 1:5
    final_Hist = medfilt2(final_Hist,[1 3]);
end
objectLegend = 'Dark Tissues'; %just for lalbeling the figure
OthersLegend = 'Light Tissues';
[P_A P_B Thr_1 P_All all_Mus]=modifiedEM_LCDG(final_Hist,objectLegend,OthersLegend);
find_bone = (Y_gray>Thr_1);
Whole_ROI1 = (Y_gray>Thr_1);
for i=1:size(thigh_mus,3)
    Whole_ROI1(:,:,i) = imfill(Whole_ROI1(:,:,i),'holes');
    se = strel('disk',6);
    Whole_ROI1(:,:,i) = imerode(Whole_ROI1(:,:,i),se);
    CC = bwconncomp(Whole_ROI1(:,:,i));
    numPixels = cellfun(@numel,CC.PixelIdxList);
    idx = find(numPixels<max(numPixels));
    Whole_ROI2=Whole_ROI1(:,:,i);
    if ~isempty(idx)
        for l=1:size(idx,2)
            Whole_ROI2(CC.PixelIdxList{idx(l)})=0;
        end
    end
    Whole_ROI(:,:,i) = Whole_ROI2;
end
se = strel('disk',4);
Whole_ROI= imdilate(Whole_ROI,se);
end