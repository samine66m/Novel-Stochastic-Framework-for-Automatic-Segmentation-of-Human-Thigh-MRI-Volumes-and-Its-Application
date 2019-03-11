function [new_atlas_orig, filteredAtlas] = filterAtlasLabel(totalAtlas, atlas_orig, labeled)

% initialization
labeled_csf = double(labeled==1);
labeled_GM  = double(labeled==2);
labeled_WM  = double(labeled==3);
labeled_OT  = double(labeled==4);
D_total     = zeros(1,size(totalAtlas,2)/2);
wCSF = sum(labeled_csf(:));
wGM  = sum(labeled_GM(:));
wWM  = sum(labeled_WM(:));
wOT  = sum(labeled_OT(:));

% main loop
idx = 1;
for i=1:2:size(totalAtlas,2)
    % get labeled atlas
    atlas_csf = double((totalAtlas{1,i+1})==1);
    atlas_GM  = double((totalAtlas{1,i+1})==2);
    atlas_WM  = double((totalAtlas{1,i+1})==3);
    atlas_OT  = double((totalAtlas{1,i+1})==4);
    
    % dice calculations
    [~,~,~,~, D_CSF, ~,~,~] = Calculate_Error(atlas_csf,labeled_csf);
    [~,~,~,~, D_GM , ~,~,~] = Calculate_Error(atlas_GM,labeled_GM);
    [~,~,~,~, D_WM , ~,~,~] = Calculate_Error(atlas_WM,labeled_WM);
    [~,~,~,~, D_OT , ~,~,~] = Calculate_Error(atlas_OT,labeled_OT);
    D_total(idx) = (wCSF*D_CSF+ wGM*D_GM + wWM*D_WM + wOT*D_OT)*100/(wCSF+wGM+wWM+wOT);
    idx = idx+1;
end

% find the average and standerd deviation for the total dice
avg_dice = mean(D_total);
sd_dice  = std(D_total);

% initilaization
bad_atlas = 0;

% remove bad atlases
idx1=1;
idx2=1;
for i=1:2:size(totalAtlas,2)
    if (D_total(idx1) >= (avg_dice-sd_dice))
        filteredAtlas{1,idx2}   = totalAtlas{1,i};
        filteredAtlas{1,idx2+1} = totalAtlas{1,i+1};
        new_atlas_orig{1,idx2}   = atlas_orig{1,i};
        new_atlas_orig{1,idx2+1} = atlas_orig{1,i+1};
        idx2 = idx2+2;
    else
        bad_atlas = bad_atlas+1;
    end
    idx1 = idx1+1;
end
fprintf('Number of removed atlas due to the dice similarity = %d\n', bad_atlas);
