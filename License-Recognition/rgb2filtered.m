%%%%%%%%%%1��ͼ��Ԥ����%%%%%%%%%%%
function filtered_image=rgb2filtered(rgb_image,fig)
figure(fig);subplot(1,2,1),imshow(rgb_image),title('ԭʼͼ��');

del=sum(rgb_image,3)<50; %ȥ����ɫ����
gray_image=(rgb_image(:,:,3)-(rgb_image(:,:,1)+rgb_image(:,:,2))/2)./rgb_image(:,:,3); %��ȡ��ɫ
%gray_image=(rgb_image(:,:,3)-(rgb_image(:,:,1)+rgb_image(:,:,2))/2)./rgb_image(:,:,3); %����ѡ����ȡ�ı���������ɫ
gray_image=gray_image./max(gray_image,[],3)*255;
gray_image(del)=0;

gray_image=bwmorph(gray_image,'open');
subplot(1,2,2),imshow(gray_image),title('�Ҷ�ͼ��');

imLabel = bwlabel(gray_image);% ����ͨ������б��
stats = regionprops(gray_image,'Area');
[b,index]=sort([stats.Area],'descend');
if length(index)>10
    gray_image=ismember(imLabel,index(1:10));
else
    gray_image=ismember(imLabel,index(1));
end

se3=strel('rectangle',[25,25]); %���νṹԪ��
filled_image=imclose(gray_image,se3);%ͼ����ࡢ���ͼ��

imLabel = bwlabel(filled_image);% ����ͨ������б��
stats = regionprops(filled_image,'Area');
[b,index]=max([stats.Area]);
filtered_image=ismember(imLabel,index(1));
end

