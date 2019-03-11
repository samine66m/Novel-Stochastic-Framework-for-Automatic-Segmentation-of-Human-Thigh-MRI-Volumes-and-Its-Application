function [Labeled, ProbVolume] = spatial(Parm1, Parm2, Parm3 )

if(nargin == 2)
    Volume = Parm1;
    Mask = double(Volume>0);
    Parm = Parm2;
elseif(nargin == 3)
    Volume = Parm1;
    Mask = Parm2;
    Parm = Parm3;
end

 [Labeled, ProbVolume] = xctSpatialProb2D(Volume, Mask, Parm);
    
