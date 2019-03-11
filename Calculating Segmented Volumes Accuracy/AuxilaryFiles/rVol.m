function volume = rVol(inDir)

pgmfiles = dir([inDir '*.bmp']);
for ii = 1 : length(pgmfiles)
    %fprintf('readVolume: slice = %d of %d ...\n',ii,length(pgmfiles));
    volume(:,:,ii) = imread([inDir pgmfiles(ii).name]);
end