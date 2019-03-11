%==========================================================================
% This function is used to apply the FFD deformation to register a moving 
% (source) image to a fixed(target) image using the FFD deformation 
% approach 
%==========================================================================
% Written by:
% -----------
% Ahmed Soliman 
%=========================================================================
function [Deformed,sourceRigestered,dy,dx,dz,dyI,dxI,dzI] = FFD_Reg_MAT(Target,Source,curPath)
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

addpath(curPath);
copyfile('auxFunctions\FFD\empHeader.mhd',[curPath '\empHeader.mhd']);

ElementSize = [1.5 1.5 1.5];
ElementSpacing = [1.5 1.5 1.5];

[S] = replaceFields(ElementSize,ElementSpacing,size(Source),'int16','Source');
volumeS = mat2raw(Source,curPath, 'Source', 'int16');

[T] = replaceFields(ElementSize,ElementSpacing,size(Target),'int16','Target');
volumeT = mat2raw(Target,curPath, 'Target', 'int16');

movefile('Source.mhd',[curPath '\Source.mhd']);
movefile('Target.mhd',[curPath '\Target.mhd']);

SR = strcat([curPath '\Source'],'.mhd');
TR = strcat([curPath '\Target'],'.mhd');
DR = strcat([curPath '\Deformed'],'.mhd');

system(sprintf('"auxFunctions/FFD/dropreg3d.exe" %s %s %s auxFunctions/FFD/param3D.txt -I',SR,TR,DR));

dx = raw2mat_01(strcat([curPath '\Deformed'],'_x.mhd'));
dy = raw2mat_01(strcat([curPath '\Deformed'],'_y.mhd'));
dz = raw2mat_01(strcat([curPath '\Deformed'],'_z.mhd'));

dxI = double(raw2mat_01(strcat([curPath '\Deformed'],'_inv_x.mhd')));
dyI = double(raw2mat_01(strcat([curPath '\Deformed'],'_inv_y.mhd')));
dzI = double(raw2mat_01(strcat([curPath '\Deformed'],'_inv_z.mhd')));

SourceN = raw2mat_01(SR);       SourceN = Source-min(Source(:));
TargetN = raw2mat_01(TR);       TargetN = Target-min(Target(:));
Deformed = raw2mat_01(DR);      Deformed = Deformed-min(Deformed(:));
Deformed = matReflect(Deformed);

dx = matReflect(dx);
dy = matReflect(dy);
dz = matReflect(dz);

dxI = matReflect(dxI);
dyI = matReflect(dyI);
dzI = matReflect(dzI);

spacTarget = [1.5 1.5 1.5];
spacSource = [1.5 1.5 1.5];

tm = eye(4);
Spacing = 1./(spacTarget ./ spacSource);
tm(1,1) =  Spacing(1);
tm(2,2) =  Spacing(2);
tm(3,3) =  Spacing(3);

sourceRigestered = xctAppDeformation(double(Source),double(dy),double(dx),double(dz),spacSource);
end


