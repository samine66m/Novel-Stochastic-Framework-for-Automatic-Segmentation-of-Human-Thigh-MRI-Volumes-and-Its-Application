function save2nii(nii_path, labeled_volume, file_name)

strcat(pwd,'\Segmentation\Code\M Files\lnii2mat_core');
if (exist(strcat(pwd,'\Segmentation\Code\M Files\nii2mat_core'),'dir'))
    addpath(strcat(pwd,'\Segmentation\Code\M Files\nii2mat_core'));
    fprintf(' - nii loading files added\n');
else
    fprintf(' - nii loading files not found!\n');
end

nii_volume = load_untouch_nii(nii_path);
nii_volume.hdr.dime.datatype = 2;
nii_volume.hdr.dime.bitpix = 2;

for i = 1:size(labeled_volume,3)
    
    labeled_volume(:,:,i) = labeled_volume(:,:,i)';
    labeled_volume(:,:,i) = flipud(labeled_volume(:,:,i));
    
end

nii_volume.img = labeled_volume;
save_untouch_nii(nii_volume, file_name)