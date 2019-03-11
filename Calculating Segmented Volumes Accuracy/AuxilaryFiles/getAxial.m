function NewVolume=getAxial(volume)
[X,Y,Z]=size(volume);
NewVolume=zeros(Y,Z,X);
for i=1:X
    axil=volume(i,:,:);
    axil=reshape(axil,Y,Z);
    %axil=axil';
    %imshow(axil,[]);pause;.
%     axil=rot90(rot90(rot90(axil)));
    NewVolume(:,:,i)=flip(flip(axil,2),1);
end
NewVolume=flip(NewVolume,3);