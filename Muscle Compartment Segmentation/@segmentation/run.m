function [obj] = run(obj)

[obj.segShape, ~] = shape(obj.inputAtlas.volume, obj.inputBrain.volume, obj.inputBrain.TransformationMatrix, obj.shapeParameters);

[obj.segShapeSmoothed, obj.spatialProbVolumes] = spatial(obj.segShape, obj.spatialParameters);

% obj.segShapeIntensitySpatial = getIntensitySegmentation_Modified(obj.inputBrain.volume, obj.segShapeSmoothed, obj.spatialProbVolumes);
% [obj.segShapeIntensitySpatial, obj.spatialProbVolumes]  = spatial(obj.segShapeIntensitySpatial, obj.spatialParameters);
[obj.segShapeIntensitySpatial, obj.spatialProbVolumes]  = spatial(obj.segShapeSmoothed, obj.spatialParameters);

% Refinment Step, it will kill seperat points 
obj.segShapeIntensitySpatial  = killSeperatePoints(double(obj.segShapeIntensitySpatial),3,1);