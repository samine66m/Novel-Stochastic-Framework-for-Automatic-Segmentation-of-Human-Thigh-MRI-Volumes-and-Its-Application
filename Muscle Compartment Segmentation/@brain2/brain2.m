
classdef brain2
    
    properties
        % data properties
        label
        volume % Stripped Grey Volume
        T1
        IR
        grey % Stripped Grey volume after modification of skull stripping process
        thresh_idx %volume used in updating skull stripping
        TransformationMatrix
    end
    
    methods
        function obj=brain2(path, opt)
            
            if(nargin <1)
                % Initialize an empty object
            elseif (nargin == 1)
                getVolume(obj,path);
                obj.TransformationMatrix = eye(4);
                
                
            elseif (nargin == 2)
                
                if opt ==1                          % Stored as .mat file
                    obj = getVolume(obj,path);
                    obj.TransformationMatrix = eye(4);
                    
                elseif  opt ==2                     % Load some files "Challenge Style" for old data compatability
                    obj = getVolumeChallenge(obj,path);
                    obj.TransformationMatrix = eye(4);
                    
                elseif opt == 3                     % stored as Structure containes all information
                    obj = getVolumeFStructure(obj,path);
                else
                    error('Unknown option in Brain loading :: options range from 1 --> 3');
                end
                
                
            end
        end
    end
    
end

function obj= getVolume(obj,path)

    [~,~,ext] = fileparts(path);

    if(strcmp(ext,'.mat'))

        test = load(path);
        fn = fieldnames(test);
        obj.volume  = eval(sprintf('test.%s',fn{2}));
        
        %% Additional code for test
        mask  = eval(sprintf('test.%s',fn{1}));
        mask(mask>0)=1;
        obj.volume = obj.volume.*mask;
        %% End of additional code of test
        
    elseif(strcmp(ext,'.nii'))
        obj.volume  = double(nii2mat(path));                % read T1
    else
        error('Unknown Format :: Try load .mat or .nii files')
    end
end

function obj= getVolumeChallenge(obj,Folder_Path)
    T1_file       = 'T1.nii';
    IR_file       = 'T1_IR.nii';
    Stripped_file = 'T1_stripped_new.nii';

    obj.T1       = double(nii2mat([Folder_Path '\' T1_file]));                % read T1
    obj.T1((obj.T1)<0)             =1;
    obj.IR       = double(nii2mat([Folder_Path '\' IR_file]));             % read T1_IR
    stripped = (obj.T1).*(double(nii2mat([Folder_Path '\' Stripped_file])>0));   % read the stripped input (BET)
    grey     = fillHoles(stripped) + stripped;  % fill holes
    obj.volume      = grey;           % read T1
end

function obj= getVolumeFStructure(obj,path)
    load(path);
    obj.label = brain.label;
    obj.TransformationMatrix = brain.trans_matrix;
%   obj.T1  = brain.T1_volume;                % read T1
    obj.T1  = round(255*mat2gray(brain.T1_volume)); % Modified Amir
%   obj.volume = brain.T1_volume .* brain.no_skull_mask;
    obj.volume =  obj.T1 .* (brain.no_skull_mask>0); % Modified Amir


end



