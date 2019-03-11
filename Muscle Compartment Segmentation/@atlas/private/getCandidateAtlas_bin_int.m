function atlas = getCandidateAtlas_bin_int(Atlas_orig,grey)

no = 1;

% convert to binary
grey_bin  = double(grey>0);


for i=1:2:size(Atlas_orig,2)
    atlas_bin = double((Atlas_orig{1,i})>0);
    NCC(no) = normalized_Cross_Corr_3D(grey_bin,atlas_bin);
    no=no+1;
end

avg = mean(NCC);
sd  = std(NCC);

no=1;
index=1;
bad_atlas =0;
for i=1:2:size(Atlas_orig,2)
    if (NCC(index) >= (avg-sd))
        atlas{1,no}   = Atlas_orig{1,i};
        atlas{1,no+1} = Atlas_orig{1,i+1};
        no=no+2;
    else
        bad_atlas =  bad_atlas + 1;
    end
    index=index+1;
end
fprintf('Number of removed atlas due to binary correlation = %d\n', bad_atlas);
