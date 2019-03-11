function new_volume = fillHoles(volume)

[x y z]=size(volume);
new_volume=zeros(x,y,z);
mask=zeros(x,y);

for i=1:z
    mask = fHoles(volume(:,:,i), [2 2], 0);
    new_volume(:,:,i)=double(~(mask>0));
end