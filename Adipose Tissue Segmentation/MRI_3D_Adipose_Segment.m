%==========================================================================
%Adipose tissue segmentation
%==========================================================================
%Authors: Samineh Mesbah - Ahmed Shalaby
%==========================================================================
%ALL RIGHTS RESERVED
%==========================================================================
%Reference: "Novel Stochastic Framework for Automatic Segmentation of Human
%Thigh MRI Volumes and Its Applications in Spinal Cord Injured Individuals"
%==========================================================================
%This code is designed to segment the adipose tissue (SAT, IMAT and MUSCLE
%Area) for FS abd WS MRI 3-D Scans of Human Thighs
%==========================================================================
%Input: WS_Scan: Water-Suppressed 3-D Scan of one Thigh (Axial)
%       FS_Scan: Fat_Suppressed 3-D Scan of one Thigh  (Axial)
%       Start_Slice: The starting slice of the part of scan that needs to
%       be segmented
%       End_Slice: The ending slice of the part of scan that needs to
%       be segmented
%Output: Segmented Volumes: SAT, IMAT, Bone, Muscle Area
%==========================================================================
function [SAT, IMAT, Bone, Muscle_Area] = MRI_3D_Adipose_Segment(WS_Scan,FS_Scan,Start_Slice,End_Slice)
Threshold = 1.2; %%change this value based on the intensity quality of the MRI scans
addpath('AuxilaryFiles');
startZ = Start_Slice;
endZ = End_Slice;

%%===================Whole_ROI segmentation============================
Whole_ROI = Get_Mask(FS_Scan,WS_Scan);

%%%============fat segmentation============================================
Y_gray = uint8(thigh_fat.*Whole_ROI);
% Calculate Its Histogram

q=0:255;                                 % Gray Level
allHist=zeros(1,256);         %Initializing the Origional Image Histogram
for h = 0:max(q)
    [R C F] = find(Y_gray == h);
    allHist(h+1) = sum(F);
end
final_Hist=allHist./sum(allHist);

%======smoothing the histogram=============================================

for k = 1:5
    final_Hist = medfilt2(final_Hist,[1 3]);
end

[P_A P_B Thr_1 P_All all_Mus]=modifiedEM_LCDG(final_Hist,objectLegend,OthersLegend);

dark_Tissues_mask = (Y_gray>Threshold*Thr_1);
for i=1:size(thigh_mus,3)
    CC = bwconncomp(dark_Tissues_mask(:,:,i));
    numPixels = cellfun(@numel,CC.PixelIdxList);
    idx = find(numPixels<max(numPixels));
    fat_mask1=dark_Tissues_mask(:,:,i);
    if ~isempty(idx)
        for l=1:size(idx,2)
            fat_mask1(CC.PixelIdxList{idx(l)})=0;
        end
    end
    fat_mask(:,:,i) = fat_mask1;
    Whole_ROI2(:,:,i) = imfill(fat_mask(:,:,i),'holes');
end


%%%==========Muscle Area segmentation===========================================
if sum(nonzeros(Whole_ROI2))> sum(nonzeros(Whole_ROI))
    Y_gray = uint8(thigh_mus.*Whole_ROI2);
else
    Y_gray = uint8(thigh_mus.*Whole_ROI);
end

% Calculate Its Histogram

q=0:255;                                 % Gray Level
allHist=zeros(1,256);         %Initializing the Origional Image Histogram
for h = 0:max(q)
    [R C F] = find(Y_gray == h);
    allHist(h+1) = sum(F);
end
final_Hist=allHist./sum(allHist);

%======smoothing the histogram===============================================================

for k = 1:5
    final_Hist = medfilt2(final_Hist,[1 3]);
end

objectLegend = 'Dark Tissues'; %just for lalbeling the figure
OthersLegend = 'Light Tissues';

[P_A P_B Thr_1 P_All all_Mus]=modifiedEM_LCDG(final_Hist,objectLegend,OthersLegend);

Light_Tissues_mask =(Y_gray>1.2*Thr_1);
Light_Tissues_mask(dark_Tissues_mask==1)=0;
dark_Tissues_mask(Light_Tissues_mask==1)=0;
for i=1:size(thigh_mus,3)
    CC = bwconncomp(Light_Tissues_mask(:,:,i));
    numPixels = cellfun(@numel,CC.PixelIdxList);
    idx = find(numPixels<=30);
    muscles_mask1=Light_Tissues_mask(:,:,i);
    if ~isempty(idx)
        for l=1:size(idx,2)
            muscles_mask1(CC.PixelIdxList{idx(l)})=0;
        end
    end
    muscles_mask(:,:,i) = muscles_mask1;
end
muscles_mask(fat_mask==1)=0;
fat_mask(muscles_mask==1)=0;
% figure,showVol(Y_gray)
% figure,showVol(muscles_mask)
%%=======================Bone segmentation=============================
se = strel('disk',1);
find_bone = imerode(find_bone,se);
bone=find_bone;
bone_flag = zeros(size(thigh_mus,3),1);
for i=1:size(thigh_mus,3)
    CC = bwconncomp(bone(:,:,i));
    numPixels = cellfun(@numel,CC.PixelIdxList);
    bone_ring2=bone(:,:,i);
    if size(numPixels,2)==1 || numPixels(2)==1
        bone_flag(i)=1;
    end
    [biggest,idx] = max(numPixels);
    numPixels(idx) = 0;
    [biggest,idx] = max(numPixels);
    bone_ring2(CC.PixelIdxList{idx})=0;
    bone_ring(:,:,i) = bone_ring2;
end
se = strel('disk',1);
bone_ring = imdilate(bone_ring,se);
bone2=1-bone_ring;
for i=1:size(thigh_mus,3)
    CC = bwconncomp(bone2(:,:,i));
    numPixels = cellfun(@numel,CC.PixelIdxList);
    [biggest,idx] = max(numPixels);
    numPixels(idx) = 0;
    [biggest,idx] = max(numPixels);
    bone_ring1=zeros(size(bone2(:,:,i)));
    bone_ring1(CC.PixelIdxList{idx})=1;
    bone_ring1 = imfill(bone_ring1,'holes');
    bone1(:,:,i) = bone_ring1;
end

se = strel('disk',1);
bone1 = imdilate(bone1,se);

%         for i=1:size(thigh_mus,3)
%         CC1 = bwconncomp(bone1(:,:,i));
%         numPixels1 = cellfun(@numel,CC1.PixelIdxList);
%         diff(i) = max(numPixels1);
%         end
% %         ref = [1:size(thigh_mus,3)];
% %         ref(idx) = [];
%         [b,idx,outliers] = deleteoutliers(diff);
%         if ~isempty(idx)
%             for k=1:size(idx,2)
%                 bone1(:,:,idx(k)) = bone1(:,:,idx(k)-1);
%             end
%         end
%%============second method=======================================
%         bone=thigh_mus.*Whole_ROI;
%         bone_ring=(bone<=10);
%         % figure;imshow(bone_ring(:,:,20),[])
%         se = strel('disk',15);
%         Whole_ROI3 = imerode(Whole_ROI,se);
%         bone=bone_ring.*Whole_ROI3;
%         CC = bwconncomp(bone);
%         numPixels = cellfun(@numel,CC.PixelIdxList);
%         [biggest,idx] = max(numPixels);
%         bone_help=zeros(size(bone));
%         bone_help(CC.PixelIdxList{idx})=1;
%         for k=1:size(thigh_mus,3)
%             bone_help(:,:,k)=bwconvhull(bone_help(:,:,k));
%         end
%         se = strel('disk',1);
%         bone_help = imdilate(bone_help,se);
%         for i=1:size(thigh_mus,3)
%         CC1 = bwconncomp(bone1(:,:,i));
%         numPixels1 = cellfun(@numel,CC1.PixelIdxList);
%         CC1 = bwconncomp(bone_help(:,:,i));
%         numPixels2 = cellfun(@numel,CC1.PixelIdxList);
%         diff(i,:) = [max(numPixels1) max(numPixels2)];
%         end
%%============compare two method==================================
%         for i=1:size(thigh_mus,3)
%             if bone_flag(i)==1
%                 bone1(:,:,i) = bone_help(:,:,i);
%             end
%         end

%%================================================================
smoothed_muscles_mask1=imfill(muscles_mask,'holes');
for i=1:size(thigh_mus,3)
    smoothed_muscles_mask(:,:,i)=bwconvhull(smoothed_muscles_mask1(:,:,i));
end
se = strel('disk',1);
smoothed_muscles_mask = imerode(smoothed_muscles_mask,se);
subcu_fat = Whole_ROI.*(1-smoothed_muscles_mask);
inter_fat_bone = smoothed_muscles_mask.*(1-Light_Tissues_mask);
inter_fat_without_bone = inter_fat_bone.*(1-bone1);



Muscle_Area = (muscles_mask.*(1-bone1)).*(1-inter_fat_without_bone);
SAT = subcu_fat;
IMAT = inter_fat_without_bone;
Bone = bone1;

figure,showVol(Muscle_Area)
figure,showVol(SAT)
figure,showVol(IMAT)
figure,showVol(Bone)
end


