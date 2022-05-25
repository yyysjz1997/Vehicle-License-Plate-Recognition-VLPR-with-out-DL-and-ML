%%%%%%%%%%1、图像预处理%%%%%%%%%%%
function filtered_image=rgb2filtered(rgb_image,fig)
figure(fig);subplot(1,2,1),imshow(rgb_image),title('原始图像');

del=sum(rgb_image,3)<50; %去除彩色噪声
gray_image=(rgb_image(:,:,3)-(rgb_image(:,:,1)+rgb_image(:,:,2))/2)./rgb_image(:,:,3); %提取蓝色
%gray_image=(rgb_image(:,:,3)-(rgb_image(:,:,1)+rgb_image(:,:,2))/2)./rgb_image(:,:,3); %可以选择提取的背景车牌颜色
gray_image=gray_image./max(gray_image,[],3)*255;
gray_image(del)=0;

gray_image=bwmorph(gray_image,'open');
subplot(1,2,2),imshow(gray_image),title('灰度图像');

imLabel = bwlabel(gray_image);% 对连通区域进行标记
stats = regionprops(gray_image,'Area');
[b,index]=sort([stats.Area],'descend');
if length(index)>10
    gray_image=ismember(imLabel,index(1:10));
else
    gray_image=ismember(imLabel,index(1));
end

se3=strel('rectangle',[25,25]); %矩形结构元素
filled_image=imclose(gray_image,se3);%图像聚类、填充图像

imLabel = bwlabel(filled_image);% 对连通区域进行标记
stats = regionprops(filled_image,'Area');
[b,index]=max([stats.Area]);
filtered_image=ismember(imLabel,index(1));
end

