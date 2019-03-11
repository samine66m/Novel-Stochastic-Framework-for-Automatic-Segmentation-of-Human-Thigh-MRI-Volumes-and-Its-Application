function bias_corrected_nii = biascorrect(volumeGry,volumeSeg)
mkdir('tmp');
original   = make_nii(round(255*mat2gray(volumeGry)));         % T1_volume
brain_mask = make_nii(double(volumeSeg>0));     % Intial brain mask_volume
save_nii(original, 'tmp\original.nii',128);
save_nii(brain_mask, 'tmp\brain_mask.nii',128);

bias_correction = sprintf('N4BiasFieldCorrection -d 3 -i %s -x %s -s 1 -c [55x55x55x55,0.000001] -b 200 -o %s',['"' 'tmp\original.nii' '"'],...
     ['"' 'tmp\brain_mask.nii' '"'], ['"' 'tmp\bias_corrected.nii' '"']);

bias_correction = sprintf('N4BiasFieldCorrection -d 3 -i %s -x %s -s 1 -c [55x55x55x55,0.000001] -b 200 -o %s',['"' 'tmp\original.nii' '"'],...
     ['"' 'tmp\brain_mask.nii' '"'], ['"' 'tmp\bias_corrected.nii' '"']);
 
% 
% bias_correction = sprintf('N4BiasFieldCorrection -d 3 -i %s -x %s -s 1 -c [15x15x15x15,0.000001] -b 200 -o %s',['"' 'tmp\original.nii' '"'],...
%      ['"' 'tmp\brain_mask.nii' '"'], ['"' 'tmp\bias_corrected.nii' '"']);

 
system(bias_correction);
bias_corrected_nii = load_nii('tmp\bias_corrected.nii');
rmdir('tmp','s');


