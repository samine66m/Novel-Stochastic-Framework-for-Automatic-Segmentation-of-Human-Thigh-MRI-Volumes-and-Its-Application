%==========================================================================
% This function is used to apply the FFD deformation to register a moving
% (source) image to a fixed(target) image using the FFD deformation
% approach
%==========================================================================
% Written by:
% -----------
% Ahmed Soliman
%=========================================================================
function [Deformed,sourceRigestered,dy,dx,dz,dyI,dxI,dzI] = FFD_Registeration(Target,Source,savePath)
%==========================================================================
%-----------------
% Function Inputs:
%-----------------
%1- Target: Fixed Volume
%2- Source: Moving Volume

%-----------------
% Function Outputs:
%-----------------
%1- Deformed: Registered Volume but the intensity has been changed to match
% fixed Image
%2- sourceRigestered: Registered Volume but the intensity has been changed
% to matchmfixed Image
%3- dy,dx,dz : Deformation Fields in X- Y- and Z-directions
%==========================================================================
if ~isequal(exist(savePath, 'dir'),7) % 7 = directory.
    mkdir(savePath);
end

if(isequal(class(Target),'char'))
    [Deformed,sourceRigestered,dy,dx,dz,dyI,dxI,dzI] = FFD_Reg_MHD(Target,Source,savePath);
else
    [Deformed,sourceRigestered,dy,dx,dz,dyI,dxI,dzI] = FFD_Reg_MAT(Target,Source,savePath);
end

end


