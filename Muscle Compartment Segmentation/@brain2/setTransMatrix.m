function [obj] = setTransMatrix(obj,path)

% Load the transformation Matrix from Specific path stored as .mat file

[~,~,ext] = fileparts(path);
    
    if(strcmp(ext,'.mat'))
        
        test = load(path);
        fn = fieldnames(test);
        obj.TransformationMatrix  = eval(sprintf('test.%s',fn{1}));

    else
        error('Unknown Format :: Try load .nii file')
    end


% obj.TransformationMatrix = load(path);