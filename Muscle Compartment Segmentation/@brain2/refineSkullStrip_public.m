function [obj] = refineSkullStrip_public(obj, seg_Obj)

if(isobject(seg_Obj))
   initialSegmentation =  seg_Obj.volume;
else
    initialSegmentation = seg_Obj;
end


[thresh_idx, ~] = refineSkullStrip(obj.T1, obj.IR, initialSegmentation);

obj.thresh_idx = thresh_idx;
obj.grey = obj.volume;
obj.grey(thresh_idx) = obj.T1(thresh_idx);

