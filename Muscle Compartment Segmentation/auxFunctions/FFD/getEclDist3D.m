%==========================================================================
% This function is used to apply the FFD deformation to register a moving 
% (source) image to a fixed(target) image using the FFD deformation 
% approach 
%==========================================================================
% Written by:
% -----------
% Ahmed Soliman 
%=========================================================================
% function [Deformed,sourceRigestered,dy,dx,dz,dyI,dxI,dzI] = getEclDist3D(TR,SR,DR)
function [Distance, Jacb] = getEclDist3D(TR,SR,D)
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

DR = strcat(D,'.mhd');
system(sprintf('"auxFunctions/FFD/dropreg3d.exe" %s %s %s auxFunctions/FFD/param3D.txt',SR,TR,DR));

dx = raw2mat_01(strcat(D ,'_x.mhd'));
dy = raw2mat_01(strcat(D ,'_y.mhd'));
dz = raw2mat_01(strcat(D ,'_z.mhd'));

dx = matReflect(dx);
dy = matReflect(dy);
dz = matReflect(dz);

% dx = raw2mat(strcat(D ,'_x.mhd'));
% dy = raw2mat(strcat(D ,'_y.mhd'));
% dz = raw2mat(strcat(D ,'_z.mhd'));

Distance = sqrt(dx.^2 + dy.^2 + dz.^2);
Jacb = motion_field_jacobian(dx,dy,dz);

end


