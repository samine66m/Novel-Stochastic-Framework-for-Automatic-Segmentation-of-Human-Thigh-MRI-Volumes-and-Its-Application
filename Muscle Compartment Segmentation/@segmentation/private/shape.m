
function [Labeled, ProbVolume] = shape(Atlas, Volume, T, Parm)
%     [Labeled, ProbVolume, ~] = xctShapeProb3D_CPU(Atlas, Volume, inv(T), Parm);
    [Labeled, ProbVolume, ~] = xctShapeProb3D(Atlas, Volume, inv(T), Parm);
end 