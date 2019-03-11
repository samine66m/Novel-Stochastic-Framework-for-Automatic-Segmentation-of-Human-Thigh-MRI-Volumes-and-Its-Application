function intensity2 = getIntensitySegmentation_Modified(grey,InitialSeg,ProbVolumes)

maxm = max(max(max(grey)));
noLabels = max(max(max(InitialSeg)));
IntensityProbVolume = zeros(maxm,noLabels);

% Get Total Number of points for normalization issues
[~, ~, f]=find(grey>0);
TOTAL_No=length(f);

for i=1 : noLabels
    label_Mask = (InitialSeg == i);
    label = double(label_Mask).*grey;
    P_label = Image_Histogram(label);
    IntensityProbVolume(1:length(P_label),i) = P_label;
end
IntensityProbVolume = IntensityProbVolume./TOTAL_No;

intensity2=xctFusion3D_new_Modified(grey,IntensityProbVolume,ProbVolumes);
%% Plot The Result
% outFigure1=figure
% myHH01=axes ('FontSize',44,'fontweight','bold','LineStyleOrder','-','LineWidth',8,'NextPlot','replacechildren','Box','on');
% set(outFigure1,'position',get(0,'screensize'),'color','w');
% 
% plot(IntensityProbVolume(:,1),'r','LineWidth',8);
% hold on
% plot(IntensityProbVolume(:,2),'G','LineWidth',8);
% hold on
% plot(IntensityProbVolume(:,3),'b','LineWidth',8);
% % hold on
% % plot(IntensityProbVolume(:,4),'m','LineWidth',8);
% 
% xlabel('Grey Level (q)')
% ylabel('Probability Density Function')
% axes(myHH01)




