function volume = matReflect(volumeO)
    volume = zeros(size(volumeO,2),size(volumeO,1),size(volumeO,3));
    for i = 1:size(volumeO,3)
        volume(:,:,i) = volumeO(:,:,i)';
    end
end

