function intensity2 = getShapeSpatialIntensity(grey,InitialSeg,ProbVolumes,Spatial)



%%
maxm=max(max(max(grey)));
tot_L=zeros(1,maxm);

% Get Total Number of points for normalization issues
[~, ~, f]=find(grey>0);
TOTAL_No=length(f);

% Calculation of Grey Matter PDF
GM_Mask=(InitialSeg==1);
GM=double(GM_Mask).*grey;
P_GM=Image_Histogram(GM);
P_GM=tot_L+[P_GM zeros(1,length(tot_L)-length(P_GM))]./TOTAL_No;

% Calculation of White Matter PDF
WM_Mask=(InitialSeg==2);
WM=double(WM_Mask).*grey;
P_WM=Image_Histogram(WM);
P_WM=tot_L+[P_WM zeros(1,length(tot_L)-length(P_WM))]./TOTAL_No;

% Calculation of CSF Matter PDF
CSF_Mask=(InitialSeg==3);
CSF=double(CSF_Mask).*grey;
P_CSF=Image_Histogram(CSF);
P_CSF=tot_L+[P_CSF zeros(1,length(tot_L)-length(P_CSF))]./TOTAL_No;

% Calculation of Other PDF
OTHR_Mask=(InitialSeg==4);
OTHR=double(OTHR_Mask).*grey;
P_OTHR=Image_Histogram(OTHR);
P_OTHR=tot_L+[P_OTHR zeros(1,length(tot_L)-length(P_OTHR))]./TOTAL_No;


intensity2=xctFusion3D_new(grey,P_GM,P_WM,P_CSF,P_OTHR,ProbVolumes,Spatial);


%% Plot The Result
% outFigure1=figure
% myHH01=axes ('FontSize',44,'fontweight','bold','LineStyleOrder','-','LineWidth',8,'NextPlot','replacechildren','Box','on');
% set(outFigure1,'position',get(0,'screensize'),'color','w');
% 
% plot(P_GM,'r','LineWidth',8);
% hold on
% plot(P_WM,'G','LineWidth',8);
% hold on
% plot(P_CSF,'b','LineWidth',8);
% hold on
% plot(P_OTHR,'m','LineWidth',8);
% 
% xlabel('Grey Level (q)')
% ylabel('Probability Density Function')
% axes(myHH01)





