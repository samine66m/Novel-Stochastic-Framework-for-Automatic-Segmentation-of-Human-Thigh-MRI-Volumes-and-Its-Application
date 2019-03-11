function  displayResults2(volume_01,volume_02,volume_03,volume_04,volume_05,volume_06,volume_07,volume_08,volume_09,volume_10)



for i=1 : size(volume_01,3)
    i
    
    if nargin ==1
        fig=volume_01(:,:,i)./max(max(max(volume_01)));
    elseif nargin ==2
        fig=[volume_01(:,:,i)./max(max(max(volume_01))) volume_02(:,:,i)./max(max(max(volume_02)))];
    elseif nargin ==3
        fig=[volume_01(:,:,i)./max(max(max(volume_01))) volume_02(:,:,i)./max(max(max(volume_02))) volume_03(:,:,i)./max(max(max(volume_03)))];
    elseif nargin ==4
        fig=[volume_01(:,:,i)./max(max(max(volume_01))) volume_02(:,:,i)./max(max(max(volume_02))) volume_03(:,:,i)./max(max(max(volume_03))) volume_04(:,:,i)./max(max(max(volume_04)))];
    elseif nargin ==5
        fig=[volume_01(:,:,i)./max(max(max(volume_01))) volume_02(:,:,i)./max(max(max(volume_02))) volume_03(:,:,i)./max(max(max(volume_03))) volume_04(:,:,i)./max(max(max(volume_04))) volume_05(:,:,i)./max(max(max(volume_05)))];
    elseif nargin ==6
        fig=[volume_01(:,:,i)./max(max(max(volume_01))) volume_02(:,:,i)./max(max(max(volume_02))) volume_03(:,:,i)./max(max(max(volume_03))) volume_04(:,:,i)./max(max(max(volume_04))) volume_05(:,:,i)./max(max(max(volume_05))) volume_06(:,:,i)./max(max(max(volume_06)))];
    elseif nargin ==7
        fig=[volume_01(:,:,i)./max(max(max(volume_01))) volume_02(:,:,i)./max(max(max(volume_02))) volume_03(:,:,i)./max(max(max(volume_03))) volume_04(:,:,i)./max(max(max(volume_04))) volume_05(:,:,i)./max(max(max(volume_05))) volume_06(:,:,i)./max(max(max(volume_06))) volume_07(:,:,i)./max(max(max(volume_07)))];
    elseif nargin ==8
        fig=[volume_01(:,:,i)./max(max(max(volume_01))) volume_02(:,:,i)./max(max(max(volume_02))) volume_03(:,:,i)./max(max(max(volume_03))) volume_04(:,:,i)./max(max(max(volume_04))) volume_05(:,:,i)./max(max(max(volume_05))) volume_06(:,:,i)./max(max(max(volume_06))) volume_07(:,:,i)./max(max(max(volume_07))) volume_08(:,:,i)./max(max(max(volume_08)))];
    elseif nargin ==9
        fig=[volume_01(:,:,i)./max(max(max(volume_01))) volume_02(:,:,i)./max(max(max(volume_02))) volume_03(:,:,i)./max(max(max(volume_03))) volume_04(:,:,i)./max(max(max(volume_04))) volume_05(:,:,i)./max(max(max(volume_05))) volume_06(:,:,i)./max(max(max(volume_06))) volume_07(:,:,i)./max(max(max(volume_07))) volume_08(:,:,i)./max(max(max(volume_08))) volume_09(:,:,i)./max(max(max(volume_09)))];
    elseif nargin ==10
        fig=[volume_01(:,:,i)./max(max(max(volume_01))) volume_02(:,:,i)./max(max(max(volume_02))) volume_03(:,:,i)./max(max(max(volume_03))) volume_04(:,:,i)./max(max(max(volume_04))) volume_05(:,:,i)./max(max(max(volume_05))) volume_06(:,:,i)./max(max(max(volume_06))) volume_07(:,:,i)./max(max(max(volume_07))) volume_08(:,:,i)./max(max(max(volume_08))) volume_09(:,:,i)./max(max(max(volume_09))) volume_10(:,:,i)./max(max(max(volume_10)))];
    end
    
    imshow(fig);  

    set(gcf,'position',get(0,'screensize'));
    pause
    
end




