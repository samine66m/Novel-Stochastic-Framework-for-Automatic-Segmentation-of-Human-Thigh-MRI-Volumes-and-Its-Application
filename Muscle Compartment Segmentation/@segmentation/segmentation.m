
classdef segmentation
    
    properties
        inputAtlas
        inputBrain
        parameters
        shapeParameters
        spatialParameters
        
        segShape;
        segShapeSmoothed;
        segShapeIntensity;
        spatialProbVolumes;
        segShapeIntensitySpatial;
        
    end
    
    methods
        
        function obj=segmentation(param1,param2,param3)     
            if (nargin < 2 || nargin>3 ) %create an empty ioVolume object
                error('Segmentation Inputs should be 2(Atlas and input) or 3(Atlas and input and parameters)');
            elseif (nargin == 2 ) %create a ioVolume object from matrix volume
                obj.parameters = getDefaultParameters();
            elseif (nargin == 3 )
                obj.parameters = param3;
            end  
            
            obj.inputAtlas = param1;
            obj.inputBrain = param2;
            obj = adjustParameters(obj);
            
        end
    end
    
    
end


function [obj] = adjustParameters(obj)
    RemovedBackGround = 1;
    obj.shapeParameters = [obj.parameters.shape.windowSize obj.parameters.shape.tolerance obj.parameters.shape.maxWindowSize obj.parameters.shape.tlrIncreStep obj.parameters.shape.Thr];
    obj.spatialParameters = [RemovedBackGround obj.parameters.spatial.KeepLabel];
end

function Parameters = getDefaultParameters()
Parameters.shape.windowSize = 7;
Parameters.shape.maxWindowSize = 10;
Parameters.shape.tolerance = 5;
Parameters.shape.tlrIncreStep = 3;
Parameters.shape.Thr = 0.0;

Parameters.spatial.KeepLabel= 1;
end







