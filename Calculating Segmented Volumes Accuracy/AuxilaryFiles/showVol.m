function showVol(volume)
Z=size(volume,3);
    for i=1:Z
    I=volume(:,:,i);
    imshow(I,[]);
    pause(0.02)
    end
    