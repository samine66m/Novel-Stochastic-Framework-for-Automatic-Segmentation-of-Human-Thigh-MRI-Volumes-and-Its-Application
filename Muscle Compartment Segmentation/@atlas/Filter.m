function [obj] = Filter(obj, brain_Obj,seg_Obj)


if(isobject(brain_Obj))
   brainVolume =  brain_Obj.volume;
else
    brainVolume = brain_Obj;
end

if(size(brainVolume) ~= size(obj.volume{1}))
    error('Atlas and input brain dimensions should be equal')
end


if(nargin == 2)
        obj.volume = getInitialAtlas(obj.volume, brainVolume);    
elseif(nargin == 3)
    if(isobject(seg_Obj))
        obj.volume = getFinalAtlas(obj.atlasPath, brain_Obj.volume, brain_Obj.grey, seg_Obj.segShapeIntensitySpatial, brain_Obj.thresh_idx);
    else
        obj.volume = getFinalAtlas(obj.atlasPath, brain_Obj.volume, brain_Obj.grey, seg_Obj, brain_Obj.thresh_idx);
    end
else
    
end

