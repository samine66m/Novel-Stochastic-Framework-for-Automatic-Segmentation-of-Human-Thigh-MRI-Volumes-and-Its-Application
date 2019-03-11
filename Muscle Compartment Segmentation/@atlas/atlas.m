
classdef atlas
    
    properties
        originalAtlas
        volume
        atlasPath
    end
    
    methods
        
        function obj=atlas(path, brain_Obj)
            
            if(nargin < 1)
                % Initialize an empty object
            elseif (nargin == 1)
                
                obj.atlasPath = path;
                obj.originalAtlas = getAtlas(path);
                obj = getStrippedAtlas(obj);
                
            elseif (nargin == 2)
                
                obj.atlasPath = path;
                obj.originalAtlas = getAtlas(path);
                obj = getStrippedAtlas(obj);
                obj = Filter(obj, brain_Obj);
                
            else
                error('Too many Parameters :: at path or path and brain only')                
            end
        end
        
        function obj = getStrippedAtlas(obj)
            
            obj.volume = obj.originalAtlas;
            for i =1:2:size(obj.originalAtlas,2)
                obj.volume{i} = (obj.originalAtlas{i+1}>0).*obj.originalAtlas{i};
            end
        end
        
    end
    
    
end

