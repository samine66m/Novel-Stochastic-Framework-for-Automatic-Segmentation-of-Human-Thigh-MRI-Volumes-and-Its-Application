%> displayResults(volume_01,volume_02,volume_03,volume_04,volume_05,volume_06,volume_07,volume_08,volume_09,volume_10)
%> @file displayResults.m
%> @author Ahmed Soliman
%> @date   January, 2014
%> @version 2.0
% ======================================================================
%> @brief displayResults function
%>
%> This function .................................
% ======================================================================

function  displayResults(volume_01,volume_02,volume_03,volume_04,volume_05,volume_06,volume_07,volume_08,volume_09,volume_10)



for i=1 : size(volume_01,3)
    i
    
    if nargin ==1
        volume_01 = volume_01-min(volume_01(:));
        fig=volume_01(:,:,i)./max(volume_01(:));
    elseif nargin ==2
        volume_01 = volume_01-min(volume_01(:));
        volume_02 = volume_02-min(volume_02(:));
        fig=[volume_01(:,:,i)./max(volume_01(:)) volume_02(:,:,i)./max(volume_02(:))];
    elseif nargin ==3
        volume_01 = volume_01-min(volume_01(:));
        volume_02 = volume_02-min(volume_02(:));
        volume_03 = volume_03-min(volume_03(:));
        fig=[volume_01(:,:,i)./max(volume_01(:)) volume_02(:,:,i)./max(volume_02(:)) volume_03(:,:,i)./max(volume_03(:))];
    elseif nargin ==4
        volume_01 = volume_01-min(volume_01(:));
        volume_02 = volume_02-min(volume_02(:));
        volume_03 = volume_03-min(volume_03(:));
        volume_04 = volume_04-min(volume_04(:));
        fig=[volume_01(:,:,i)./max(volume_01(:)) volume_02(:,:,i)./max(volume_02(:)) volume_03(:,:,i)./max(volume_03(:)) volume_04(:,:,i)./max(volume_04(:))];
    elseif nargin ==5
        fig=[volume_01(:,:,i)./max(volume_01(:)) volume_02(:,:,i)./max(volume_02(:)) volume_03(:,:,i)./max(volume_03(:)) volume_04(:,:,i)./max(volume_04(:)) volume_05(:,:,i)./max(volume_05(:))];
    elseif nargin ==6
        fig=[volume_01(:,:,i)./max(volume_01(:)) volume_02(:,:,i)./max(volume_02(:)) volume_03(:,:,i)./max(volume_03(:)) volume_04(:,:,i)./max(volume_04(:)) volume_05(:,:,i)./max(volume_05(:)) volume_06(:,:,i)./max(volume_06(:))];
    elseif nargin ==7
        fig=[volume_01(:,:,i)./max(volume_01(:)) volume_02(:,:,i)./max(volume_02(:)) volume_03(:,:,i)./max(volume_03(:)) volume_04(:,:,i)./max(volume_04(:)) volume_05(:,:,i)./max(volume_05(:)) volume_06(:,:,i)./max(volume_06(:)) volume_07(:,:,i)./max(volume_07(:))];
    elseif nargin ==8
        fig=[volume_01(:,:,i)./max(volume_01(:)) volume_02(:,:,i)./max(volume_02(:)) volume_03(:,:,i)./max(volume_03(:)) volume_04(:,:,i)./max(volume_04(:)) volume_05(:,:,i)./max(volume_05(:)) volume_06(:,:,i)./max(volume_06(:)) volume_07(:,:,i)./max(volume_07(:)) volume_08(:,:,i)./max(volume_08(:))];
    elseif nargin ==9
        fig=[volume_01(:,:,i)./max(volume_01(:)) volume_02(:,:,i)./max(volume_02(:)) volume_03(:,:,i)./max(volume_03(:)) volume_04(:,:,i)./max(volume_04(:)) volume_05(:,:,i)./max(volume_05(:)) volume_06(:,:,i)./max(volume_06(:)) volume_07(:,:,i)./max(volume_07(:)) volume_08(:,:,i)./max(volume_08(:)) volume_09(:,:,i)./max(volume_09(:))];
    elseif nargin ==10
        fig=[volume_01(:,:,i)./max(volume_01(:)) volume_02(:,:,i)./max(volume_02(:)) volume_03(:,:,i)./max(volume_03(:)) volume_04(:,:,i)./max(volume_04(:)) volume_05(:,:,i)./max(volume_05(:)) volume_06(:,:,i)./max(volume_06(:)) volume_07(:,:,i)./max(volume_07(:)) volume_08(:,:,i)./max(volume_08(:)) volume_09(:,:,i)./max(volume_09(:)) volume_10(:,:,i)./max(volume_10(:))];
    end
    
%     axes
    hold on
    imshow(fig);  
%     colormap(jet);
    set(gcf,'position',get(0,'screensize'));
    pause
    hold off
end




% for i = 1:size(distMap3D,3)
% subplot 131
% imshow(input3D(:,:,i),[]);
% subplot 132
% imshow(distMap3D(:,:,i),[]);
% subplot 133
% imshow(mat2gray(distMap3D(:,:,i(:));
% set(gcf,'position', get(0,'screensize'))
% pause
% end