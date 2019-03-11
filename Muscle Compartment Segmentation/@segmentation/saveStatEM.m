function [] = saveStatEM(obj,filepath)

fprintf('statEM :: saving to file\n');
statEMSave.inputBrain = obj.inputBrain;
statEMSave.segShape = obj.segShape;
statEMSave.segShapeSmoothed = obj.segShapeSmoothed;
statEMSave.segShapeIntensity = obj.segShapeIntensity;
statEMSave.segShapeIntensitySpatial = obj.segShapeIntensitySpatial; %#ok<STRNU>

save(filepath,'statEMSave');
clear statEMSave

end