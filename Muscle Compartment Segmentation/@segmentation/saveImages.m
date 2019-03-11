function [] = saveImages(obj,path,option)
Tmp = obj.segShapeIntensitySpatial;
brainTissues=zeros(size(Tmp));
if(option == 1)
brainTissues(Tmp == 2 | Tmp == 3)=1;
elseif(option == 2)
    brainTissues = Tmp;
else
    error('Invalid option');
end
mat2images([brainTissues.*(max(obj.inputBrain.volume(:))/max(brainTissues(:))),obj.inputBrain.volume],path)