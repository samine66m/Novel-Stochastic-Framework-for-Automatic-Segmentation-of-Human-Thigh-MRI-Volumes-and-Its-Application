function [thresh_idx, expanded_region] = refineSkullStrip(gray_T1, gray_IR, SG_labeled)

% Remove Negative Values

% T1_shift=min(min(min(gray_T1)));
% IR_shift=min(min(min(gray_IR)));
% 
% gray_T1=gray_T1 + (-1 *T1_shift);
% gray_IR=gray_T1 + (-1 *IR_shift);
% 
% 
% % gray_T1(gray_T1<0)=1;
% % gray_IR(gray_IR<0)=1;
%% Segment CSF from IR-scan

CSF_SGi = (SG_labeled==1);          % CSF mask from segmented

% segment gray matter
GM_SGi = (SG_labeled==2);   % GM mask from segmented


%% histogram calculations
% CSF
CSF_hist_T1 = Image_Histogram(double(gray_T1(CSF_SGi)));
CSF_hist_IR = Image_Histogram(double(gray_IR(CSF_SGi)));
% Gray Matter
GM_hist_T1  = Image_Histogram(double(gray_T1(GM_SGi)));
GM_hist_IR  = Image_Histogram(double(gray_IR(GM_SGi)));

% smoothing
CSF_hist_T1s = medfilt1(CSF_hist_T1,3);
CSF_hist_IRs = medfilt1(CSF_hist_IR,3);
GM_hist_T1s  = medfilt1(GM_hist_T1,3);
GM_hist_IRs  = medfilt1(GM_hist_IR,3);

%% Threshold computing
thresh_T1  = calcThresh(CSF_hist_T1s, GM_hist_T1s);
thresh_IR  = calcThresh(CSF_hist_IRs, GM_hist_IRs);
min_CSF_T1 = min(gray_T1(CSF_SGi));
min_CSF_IR = min(gray_IR(CSF_SGi));

% remove background from T1
T1_BG = logical(regionGrowing3D_Lower(double(gray_T1),[2 2 2], 30));
T1_BG = ~logical(fillHoles(double(~(T1_BG))));

gray_T1(T1_BG) = min_CSF_T1-50;
gray_IR(T1_BG) = min_CSF_IR-50;

%% segmentation based on thresholds
thresh_idx1 = ((gray_T1>min_CSF_T1 | gray_T1<thresh_T1) & (gray_IR>min_CSF_IR & gray_IR<thresh_IR));

% thresh_idx = thresh_idx1;

thresh_idx2 = SG_labeled>0|thresh_idx1;
thresh_idx3 = thresh_idx2;
thresh_idx4 = thresh_idx2;
expanded_region = false(size(thresh_idx2));

for i = 11:size(thresh_idx2,3)-8
    thresh_idx3(:,:,i) = logical(regionGrowing2D(double(thresh_idx2(:,:,i)),...
        [round(size(thresh_idx2,1)/2) round(size(thresh_idx2,2)/2)], 1));
    [thresh_idx4(:,:,i), expanded_region(:,:,i)] = expandEdges(double(thresh_idx3(:,:,i)),1);
end

for i = size(thresh_idx2,3)-8:size(thresh_idx2,3)
     [thresh_idx4(:,:,i), expanded_region(:,:,i)] = expandEdges(double(thresh_idx2(:,:,i)),1);
end

thresh_idx = logical(thresh_idx4);
% displayResultsGray(thresh_idx2, thresh_idx3,thresh_idx4,thresh_idx)


%% test
% plot histograms
% subplot 211
% hold on
% plot(CSF_hist_T1s)
% plot(GM_hist_T1s,'r')
% hold off
%
% subplot 212
% hold on
% plot(CSF_hist_IRs)
% plot(GM_hist_IRs,'r')
% hold off
%
% figure
% displayResultsGray(thresh_idx)

