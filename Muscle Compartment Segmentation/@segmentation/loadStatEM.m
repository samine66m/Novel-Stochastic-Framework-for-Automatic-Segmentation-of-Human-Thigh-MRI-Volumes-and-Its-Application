function obj = loadStatEM(obj,filepath)
fprintf('statEM :: loading from file\n');
load(filepath,'statEMSave');

fprintf('statEM :: saving to file\n');
obj.inputBrain = statEMSave.inputBrain;
obj.segShape = statEMSave.segShape ;
obj.segShapeSmoothed  = statEMSave.segShapeSmoothed ;
obj.segShapeIntensity = statEMSave.segShapeIntensity;
obj.segShapeIntensitySpatial = statEMSave.segShapeIntensitySpatial; % #ok<STRNU>

clear statEMSave
end