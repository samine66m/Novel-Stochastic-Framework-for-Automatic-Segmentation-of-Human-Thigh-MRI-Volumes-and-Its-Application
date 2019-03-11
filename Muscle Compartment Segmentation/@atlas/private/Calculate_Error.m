%==========================================================================
% Calculation of Different Error Statistics for both 2D and 3D data
%==========================================================================
function [TPos FPos TNeg FNeg DSCs Sens Spec PPV] = Calculate_Error(curGTh,curSeg)

%-----------------
% Function Inputs:
%-----------------
%1- curGTh  : Ground Truth object.
%2- curSeg : Segemented Object.

%-----------------
% Function Outputs:
%-----------------
%1- TPos : True Postive Value.
%2- FPos : False Postive Value.
%3- TNeg : True Negative Value.
%3- FNeg : False Negative Value.
%4- DSCs : Dice Similarity Coefficient.
%5- Sens : Sensitivity.
%6- Spec : Specificity.
%7- Spec : Positive Predictive Value.

%--------------------------------------------------------------------------
curGTh = curGTh >0;
curSeg = curSeg >0;

FPos_Vol = curSeg & (~curGTh);
FNeg_Vol = curGTh & (~curSeg);
TPos_Vol = curSeg & curGTh;
TNeg_Vol = (~(curSeg | curGTh));

FPos = sum(FPos_Vol(:));
FNeg = sum(FNeg_Vol(:));
TPos = sum(TPos_Vol(:));
TNeg = sum(TNeg_Vol(:));

DSCs = 2*TPos / (2*TPos+FNeg+FPos);
Sens = TPos / (TPos+FNeg);
Spec = TNeg / (TNeg+FPos);
PPV = TPos / (TPos+FPos);

end



