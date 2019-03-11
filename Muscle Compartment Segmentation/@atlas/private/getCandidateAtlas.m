
function atlas=getCandidateAtlas(totalAtlas,grey,threshold)
no=1;
for i=1:2:size(totalAtlas,2)
    NCC=normalized_Cross_Corr_3D(grey,totalAtlas{1,i});
%     NCC(no)=normalized_Cross_Corr_3D_RBG(grey,totalAtlas{1,i});
    if NCC >= threshold
        atlas{1,no}=totalAtlas{1,i};
        atlas{1,no+1}=totalAtlas{1,i+1};
        no=no+2;
    end
end

% mean(NCC)
% std(NCC)
