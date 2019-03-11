function [P_1 P_2 T_1 Bothpdfs allMus]=modifiedEM_LCDG(im_hist,objectLegend,otherLegend)
%==========================================================================
%-----------------
% Function Inputs:
%-----------------
%1- CT_RD   : Input Image

%-----------------
% Function Outputs:
%-----------------
%1- P_1    : First Class pdf
%2- P_2    : Second Class pdf
%3- T_1    : The Threshold value

%==========================================================================
scrSize = get(0,'screensize');
for k = 1:5
    im_hist = medfilt2(im_hist,[1 3]);
end
ZZ=im_hist;
emperical_density = ZZ./sum(ZZ);
volume_hist = emperical_density;
volume_hist(1)=0;
volume_hist = volume_hist./sum(volume_hist);
IN_Image = volume_hist ;

% % Samnieh
 Mu1_old = 10;
 Mu2_old = 100;

%  Mu1_old = 60;
%  Mu2_old = 200;

% %kidney Dr. Aly
% Mu1_old = 100;
% Mu2_old = 200;

Prob1_old = 1./2;
Prob2_old = 1./2;

segma1_old = 10;
segma2_old = 10;

density_class1 = zeros(1,length(IN_Image));
density_class2 = zeros(1,length(IN_Image));

No_iteration = 100;

hgif01 = figure;
myHH01 = axes ('FontSize',38,'LineStyleOrder','-','LineWidth',6,'NextPlot','replacechildren','Box','on');
set(hgif01,'position',scrSize,'color','w');
x_image = [0:1:length(volume_hist)-1];
x_image2 = 0:1600;
plot(x_image,IN_Image,'.-','color',[126 215 22]./255,'markersize',12,'markerfacecolor',[126 215 22]./255,'MarkerEdgeColor',[126 215 22]./255,'linewidth',6)

for k = 1:No_iteration
    for i=1:length(IN_Image)
        gray = x_image(i);
        
        p_class1= Gauss_aym(gray,Mu1_old,segma1_old);
        p_class2= Gauss_aym(gray,Mu2_old,segma2_old);
        
        if ((Prob1_old.*p_class1 + Prob2_old.*p_class2) == 0);
            density_class1(i) = 0;
            density_class2(i) = 0;
        else
            density_class1(i) = IN_Image(i).*((Prob1_old.*p_class1)./(Prob1_old.*p_class1 + Prob2_old.*p_class2));
            density_class2(i) = IN_Image(i).*((Prob2_old.*p_class2)./(Prob1_old.*p_class1 + Prob2_old.*p_class2));
        end
        
    end
    
    
    % To compute the proportion
    Prob1_New = (sum(density_class1))./(length(IN_Image));
    Prob2_New = (sum(density_class2))./(length(IN_Image));
    
    Mu1_New = (sum(density_class1.*x_image))./sum(sum(density_class1));
    Mu2_New = (sum(density_class2.*x_image))./sum(sum(density_class2));
    
    segma1_New =  sum(sum(density_class1.*(x_image - Mu1_New).^2))./sum(sum(density_class1));
    segma2_New =  sum(sum(density_class2.*(x_image - Mu2_New).^2))./sum(sum(density_class2));
    
    Prob1_old = Prob1_New./(Prob1_New + Prob2_New);
    Prob2_old = Prob2_New./(Prob1_New + Prob2_New);
    
    Mu1_old = Mu1_New;
    Mu2_old = Mu2_New;
    
    segma1_old = segma1_New;
    segma2_old = segma2_New;
end
Prob1_old = Prob1_New./(Prob1_New + Prob2_New);
Prob2_old = Prob2_New./(Prob1_New + Prob2_New);

for k = 1:length(volume_hist)
    A_const = 1./((2.*pi.*segma1_old).^0.5);
    B_const = (((k-1)- Mu1_old).^2)./(2.*segma1_old);
    denst_lung(k) = Prob1_old.*A_const.*exp(-B_const);
end
allMus=[Mu1_old Mu2_old ];

for k = 1:length(volume_hist)
    A_const = 1./((2.*pi.*segma2_old).^0.5);
    B_const = (((k-1)- Mu2_old).^2)./(2.*segma2_old);
    denst_chest(k) =Prob2_old.*A_const.*exp(-B_const);
end

maxVal = max(max(denst_chest),max(denst_lung));
maxVal2 = max(maxVal,max(volume_hist));
density_estimation = denst_chest + denst_lung;
density_estimation = density_estimation./sum(density_estimation);
hold on

plot(x_image,density_estimation,'.-','color',[133 48 48]./255,'markersize',12,'markerfacecolor',[133 48 48]./255,'MarkerEdgeColor',[133 48 48]./255,'linewidth',6)
axis([0 max(x_image2) 0 max(max(IN_Image),max(density_estimation))+.005])
Hleg_01=legend('Empirical Density','Initial Estimated Density',1);
set(Hleg_01,'linewidth',6);
axis([0 max(x_image2) 0 max(max(IN_Image),max(density_estimation))+.001])
xlabel('Hounsfield Values (q)')
ylabel('Probability Density Functions')
axes(myHH01)
saveas(hgif01,'Estimated_Empirical_Initial_pdf.fig');


hgif02=figure;
myHH01=axes ('FontSize',38,'LineStyleOrder','-','LineWidth',6,'NextPlot','replacechildren','Box','on');
set(hgif02,'position',scrSize,'color','w');
plot(x_image,IN_Image,'.-','color',[126 215 22]./255,'markersize',12,'markerfacecolor',[126 215 22]./255,'MarkerEdgeColor',[126 215 22]./255,'linewidth',6)
hold on;
% plot(x_image,denst_lung,'r.-','markersize',12,'markerfacecolor','r','MarkerEdgeColor','r','linewidth',6);
hold on
% plot(x_image,denst_chest,'b.-','markersize',12,'markerfacecolor','b','MarkerEdgeColor','b','linewidth',6);
axis([0 max(x_image2) 0 maxVal2+.0015])
Hleg_02 = legend('Empirical Density',objectLegend,otherLegend,1);
set(Hleg_02,'linewidth',6);
xlabel('Hounsfield Values (q)')
ylabel('Probability Density Functions')
axes(myHH01)
saveas(hgif02,'Empirical_Classes_Initial_pdf.fig');
%==========================================================================
%=================== Automatic determination of Error =====================
error = volume_hist - density_estimation;

hgif03=figure;
myHH01=axes ('FontSize',38,'LineStyleOrder','-','LineWidth',6,'NextPlot','replacechildren','Box','on');
set(hgif03,'position',scrSize,'color','w');
% plot(x_image,error,'.-','color',[207 171 46]./255,'markersize',12,'markerfacecolor',[207 171 46]./255,'MarkerEdgeColor',[207 171 46]./255,'linewidth',6)
hold on
% plot(x_image,abs(error),'.-','color',[80 190 225]./255,'markersize',15,'markerfacecolor',[80 190 225]./255,'MarkerEdgeColor',[80 190 225]./255,'linewidth',6)
Hleg_03 = legend('Deviations','Absolute Deviations',1);
set(Hleg_03,'linewidth',6);
axis([0 max(x_image2) min(min(error),min(abs(error)))-0.0001 max(max(error),max(abs(error)))+.001])
xlabel('Hounsfield Values (q)')
ylabel('Deviation')
axes(myHH01)
saveas(hgif03,'Deviations_Absolute.fig');

c = 1;
Error_sign = sign(error);
Position(1) = 0;
for k = 1:length(Error_sign) - 1
    if (Error_sign(k)~=Error_sign(k+1))
        c = c + 1;
        Position(c) = k;
    end
end
c;
Position(c+1) = max(x_image)-1;
c = 0;
for k = 1:length(Position) - 1
    if (Position(k + 1) - Position(k) > 1);
        c = c + 1;
        Initial_Mu(c) = (Position(k + 1) + Position(k))/2;
%     else
%         c = c + 1;
%         Initial_Mu(c) = 1;
    end
end

Number_Gaussian = c
No_iteration = 500;
const = sum(abs(error));
IN_Image = abs(error)./sum(abs(error));
[pdf_array,M,V] = General_EM(IN_Image,Initial_Mu,x_image,No_iteration,Number_Gaussian);


hgif04=figure;
myHH01=axes ('FontSize',38,'LineStyleOrder','-','LineWidth',6,'NextPlot','replacechildren','Box','on');
set(hgif04,'position',scrSize,'color','w');
plot(IN_Image,'.-','color',[80 190 225]./255,'markersize',12,'markerfacecolor',[80 190 225]./255,'MarkerEdgeColor',[80 190 225]./255,'linewidth',6)
hold on
% plot(sum(pdf_array)./sum(sum(pdf_array)),'k:','markersize',12,'markerfacecolor','k','MarkerEdgeColor','k','linewidth',6)
Hleg_04 = legend('Absolute Deviations','Absolute Deviations Estimate',1);
set(Hleg_04,'linewidth',6);
xlabel('Hounsfield Values (q)')
ylabel('Probability Density Function')
axis([0 max(x_image2) 0 max(max((sum(pdf_array)./sum(sum(pdf_array)))),max(IN_Image))+.001])
% axes(myHH01)
saveas(hgif04,'Deviations_Estimate.fig');

Z = round(M);

%  Plot The gaussian Components
%-------------------------------
[nRows,nCols]=size(pdf_array);
allSigns = zeros(nRows,nCols);
for ee = 1:Number_Gaussian
    if Z(ee)==0
        Z(ee)=1;
    end
    curSigns = sign(error(Z(ee)));
    allSigns(ee,:) =curSigns*ones(1,nCols);
end
scaledDGs = const*allSigns.*pdf_array;
maxDGs = max(scaledDGs(:));
minDGs = min(scaledDGs(:));
%-------------------
hgif05=figure;
myHH01=axes ('FontSize',38,'LineStyleOrder','-','LineWidth',6,'NextPlot','replacechildren','Box','on');
set(hgif05,'position',scrSize,'color','w');
hold on
plot(x_image,denst_lung,'r.-','markersize',12,'markerfacecolor','r','MarkerEdgeColor','r','linewidth',6);
hold on
plot(x_image,denst_chest,'b.-','markersize',12,'markerfacecolor','b','MarkerEdgeColor','b','linewidth',6);
hold on

for k = 1:Number_Gaussian
    plot(const.*sign(error(Z(k))).*pdf_array(k,:),'markersize',12,'color', [100 50 0]./255,'MarkerEdgeColor',[100 50 0]./255,'linewidth',4);
    hold on
end
S_01 = ['Dominant ' objectLegend ' Comp'];
S_02 = ['Dominant ' otherLegend ' Comp'];
Hleg_05 = legend(S_01,S_02,'Discrete Gaussian Components',1);
set(Hleg_05,'linewidth',6);
xlabel('Hounsfield Values (q)')
ylabel('Probability Density Functions')
axis([0 max(x_image2) minDGs-0.001 max(maxDGs,maxVal)+.001])
axes(myHH01)
saveas(hgif05,'LCDG_Components.fig');

   axis([0 255 min(min(denst_chest),min(min(pdf_array(:)),min(denst_lung)))-.0001 max(max(denst_chest),max(max(pdf_array(:)),max(denst_lung)))+.001])
%==========================================================================
% Final Density Estimation
%==========================================================================
Density_Error = const.*sign(error).*(sum(pdf_array)./(sum(sum(pdf_array))));
Bothpdfs = abs(denst_lung + denst_chest + Density_Error);


hgif06=figure;
myHH01=axes ('FontSize',38,'LineStyleOrder','-','LineWidth',6,'NextPlot','replacechildren','Box','on');
set(hgif06,'position',scrSize,'color','w');
plot(volume_hist,'.-','color',[126 215 22]./255,'markersize',12,'markerfacecolor',[126 215 22]./255,'MarkerEdgeColor',[126 215 22]./255,'linewidth',6)
hold on
% plot(Bothpdfs,':','color',[133 48 48]./255,'markersize',12,'markerfacecolor',[133 48 48]./255,'MarkerEdgeColor',[133 48 48]./255,'linewidth',6)
Hleg_06 = legend('Empirical Density','Final Estimated Density',1);
set(Hleg_06,'linewidth',6);
axis([0 max(x_image2) 0 max(max(volume_hist),max(Bothpdfs))+.001])
xlabel('Hounsfield Values (q)')
ylabel('Probability Density Functions Level')
axes(myHH01)
saveas(hgif06,'Estimated_Empirical_Final_pdf.fig');
%============================= Threshold===================================

T_1 = 50;
while (denst_lung(T_1) > denst_chest(T_1))
    T_1 = T_1 + 1;
    if  T_1>256
        break
    end
end
T_1;

P_1 = denst_lung;
P_2 = denst_chest;

for k = 1:Number_Gaussian
    if M(k)<= T_1+10
        P_1 = P_1 + const.*sign(error).*pdf_array(k,:);
    else
        P_2 = P_2 + const.*sign(error).*pdf_array(k,:);
    end
end
P_1 = abs(P_1);
P_2 = abs(P_2);

hgif07=figure;
myHH01=axes ('FontSize',38,'LineStyleOrder','-','LineWidth',6,'NextPlot','replacechildren','Box','on');
set(hgif07,'position',scrSize,'color','w');
plot(x_image,P_1,'r.-','markersize',12,'markerfacecolor','r','MarkerEdgeColor','r','linewidth',6);
hold on
plot(x_image,P_2,'b.-','markersize',12,'markerfacecolor','b','MarkerEdgeColor','b','linewidth',6);
Hleg_07 = legend(objectLegend,otherLegend,1);
set(Hleg_07,'linewidth',6);
axis([0 max(x_image2) 0 max(max(P_1),max(P_2))+.001])
xlabel('Hounsfield Values (q)')
ylabel('Probability Density Functions')
axes(myHH01)
saveas(hgif07,'Classes_Final_pdf.fig');

T_1 =50;
while (P_1(T_1) > P_2(T_1))
    T_1 = T_1 + 1;
    if  T_1>256
        break
    end
end
T_1
% close all