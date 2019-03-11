

% function NCC = getCrossCorr(dataDir,FileType)
function atlas=getTopCandidateAtlas(totalAtlas,grey,topNo)
no=1;
for i=1:2:size(totalAtlas,2)
    NCC(no,1)=normalized_Cross_Corr_3D(grey,totalAtlas{1,i});
    NCC(no,2)=i;
    
    no=no+1;
    

end

% sort()
NCC
NCC=sort(NCC,1,'descend')
no=1;
for i=1:topNo
        atlas{1,no}=totalAtlas{1,NCC(i,2)};
        atlas{1,no+1}=totalAtlas{1,NCC(i,2)+1};
        no=no+2; 
end
% for i = 1:topNo
%     
% end
%     
%     
%     
%     if NCC >= threshold
%         atlas{1,no}=totalAtlas{1,i};
%         atlas{1,no+1}=totalAtlas{1,i+1};
%         no=no+2;
%     end