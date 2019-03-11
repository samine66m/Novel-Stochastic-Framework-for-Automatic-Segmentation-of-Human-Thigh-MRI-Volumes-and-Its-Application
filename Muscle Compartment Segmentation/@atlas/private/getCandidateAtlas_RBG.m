
function atlas=getCandidateAtlas_RBG(totalAtlas,grey)


no=1;
for i=1:2:size(totalAtlas,2)
    NCC(no)=normalized_Cross_Corr_3D_RBG(grey,totalAtlas{1,i});  
    no = no+1;
end

avg = mean(NCC);
sd  = std(NCC);

% initializations
no=1;
index=1;
bad_atlas = 0;

for i=1:2:size(totalAtlas,2)
    if NCC(index) >= (avg-sd)
        atlas{1,no}=totalAtlas{1,i};
        atlas{1,no+1}=totalAtlas{1,i+1};
        no=no+2;
    else
        bad_atlas =  bad_atlas + 1;
    end
    index=index+1;
end
fprintf('Number of removed atlas due to gray levels correlation = %d\n', bad_atlas);
