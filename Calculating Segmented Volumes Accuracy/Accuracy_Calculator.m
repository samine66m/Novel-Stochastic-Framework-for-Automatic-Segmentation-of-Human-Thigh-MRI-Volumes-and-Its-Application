%==========================================================================
%Accuracy_Calculator
%==========================================================================
%Authors: Samineh Mesbah
%==========================================================================
%ALL RIGHTS RESERVED
%==========================================================================
%Reference: "Novel Stochastic Framework for Automatic Segmentation of Human
%Thigh MRI Volumes and Its Applications in Spinal Cord Injured Individuals"
%==========================================================================
%This code Compares the segmented volums to the Ground Truth and calculates
%Dice Similariy Index (SI), Precision (P), Recall (R) and Hausdorff Distance (HD)
%==========================================================================
%Input: Segmented_ROI: Water-Suppressed 3-D Scan of one Thigh (Axial)
%       Scan_Resolution: x,y,z resolution of 3-D scans (located in MRI
%       images header)
%Output: Dice Similariy Index (SI), Precision (P), Recall (R) and Hausdorff Distance (HD)
%==========================================================================
function [SI,P,R,HD] = Accuracy_Calculator(Segmented_ROI,GroundTruth,Scan_Resolution)
Manual_Binary=double(GroundTruth);
Automatic_Binary=double(Segmented_ROI);
a = unique(Automatic_Binary);
for j=a(2):a(end)
    manual = double(Manual_Binary==j);
    auto = double(Automatic_Binary==j);
    auto_manual = double(Manual_Binary==j & Automatic_Binary==j);
    auto_manual2 = double(Manual_Binary==j | Automatic_Binary==j);
    volumeA = sum(manual(:)).*(Scan_Resolution(1)*Scan_Resolution(2)*Scan_Resolution(3));
    volumeB = sum(auto(:)).*(Scan_Resolution(1)*Scan_Resolution(2)*Scan_Resolution(3));
    volumeAB = sum(auto_manual(:)).*(Scan_Resolution(1)*Scan_Resolution(2)*Scan_Resolution(3));
    volumeAorB = sum(auto_manual2(:)).*(Scan_Resolution(1)*Scan_Resolution(2)*Scan_Resolution(3));
    
    SI(j) = 2*volumeAB./(volumeA + volumeB);
    R(j) = volumeAB./volumeA;
    P(j) = volumeAB./volumeB;
    %
    %HD meassure
    HD(j) = Hausdorff(manual,auto);
end
end