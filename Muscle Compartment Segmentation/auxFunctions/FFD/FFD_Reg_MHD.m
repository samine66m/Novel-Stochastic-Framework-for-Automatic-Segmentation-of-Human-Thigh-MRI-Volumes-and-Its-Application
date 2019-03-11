%==========================================================================
% This function is used to apply the FFD deformation to register a moving 
% (source) image to a fixed(target) image using the FFD deformation 
% approach 
%==========================================================================
% Written by:
% -----------
% Ahmed Soliman 
%=========================================================================
function [Deformed,sourceRigestered,dy,dx,dz,dyI,dxI,dzI] = FFD_Reg_MHD(TR,SR,curPath)
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

    % mkdir('tmp'); addpath('tmp');
    % curPath = 'tmp';
    % SR = strcat([curPath '\Source'],'.mhd');
    % TR = strcat([curPath '\Target'],'.mhd');
    DR = strcat([curPath '\Deformed'],'.mhd');

    system(sprintf('"auxFunctions/FFD/dropreg3d.exe" %s %s %s auxFunctions/FFD/param3D.txt -I',SR,TR,DR));

    dx = raw2mat(strcat([curPath '\Deformed'],'_x.mhd'));
    dy = raw2mat(strcat([curPath '\Deformed'],'_y.mhd'));
    dz = raw2mat(strcat([curPath '\Deformed'],'_z.mhd'));

    dxI = double(raw2mat(strcat([curPath '\Deformed'],'_inv_x.mhd')));
    dyI = double(raw2mat(strcat([curPath '\Deformed'],'_inv_y.mhd')));
    dzI = double(raw2mat(strcat([curPath '\Deformed'],'_inv_z.mhd')));

    Source = raw2mat(SR);       %SourceN = Source-min(Source(:));
    Target = raw2mat(TR);       TargetN = Target-min(Target(:));
    Deformed = raw2mat(DR);      %Deformed = Deformed-min(Deformed(:));
    % Deformed = matReflect(Deformed);

    spacTarget = getDataFromMHD(TR,'ElementSpacing');
    spacSource = getDataFromMHD(SR,'ElementSpacing');

    tm = eye(4);
    Spacing =  spacTarget ./ spacSource;
    tm(1,1) =  Spacing(1);
    tm(2,2) =  Spacing(2);
    tm(3,3) =  Spacing(3);

    [~, inputVolumeResized] = privateCorrectScaling(Target,Source);
    inputRsizedResampled = xctShapeProb3D2(inputVolumeResized, double(tm));
    % sourceRigestered = xctAppDeformation(Source,dy,dx,dz,spacSource);
    sourceRigestered = xctAppDeformation(inputRsizedResampled,dy,dx,dz,spacSource);

    % [SegVolume, ProbVolumes] = xctAppDeformationSeg(int16(Atlas),int16(inputRsizedResampled),single(invDeformationField(:,:,:,2)),...
    %     single(invDeformationField(:,:,:,1)),single(invDeformationField(:,:,:,3)),opts.spacTarget,opts.parameters);

    % if(opts.returnDomain == 1)
    %     SegVolume = xctShapeProb3D2(double(SegVolume), double(inv(tm)));
    %     ProbVolumes(:,:,:,1) = xctShapeProb3D2(double(ProbVolumes(:,:,:,1)), double(inv(tm)));
    %     ProbVolumes(:,:,:,2) = xctShapeProb3D2(double(ProbVolumes(:,:,:,2)), double(inv(tm)));
    %     
    %     [~, SegVolumeOrgnl] = privateCorrectScaling(double(inputVolume),SegVolume);
    %     [~, ProbVolumesOrgnl(:,:,:,1)] = privateCorrectScaling(double(inputVolume),ProbVolumes(:,:,:,1));
    %     [~, ProbVolumesOrgnl(:,:,:,2)] = privateCorrectScaling(double(inputVolume),ProbVolumes(:,:,:,2));
    % end

end


