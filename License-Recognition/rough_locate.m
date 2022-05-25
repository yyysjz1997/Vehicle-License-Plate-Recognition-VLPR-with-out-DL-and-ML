%%%%%%%%%%车牌粗定位%%%%%%%%%%%
function rough_locate_image = rough_locate( filtered_image,rgb_image,fig)
figure(fig);
subplot(2,2,1),imshow(filtered_image),title('形态滤波后图像');
rough_locate_image=double(filtered_image);
%%%%%%%%%%确定行的起始位置和终止位置%%%%%%%%%%%
Y1=sum(rough_locate_image,2);
subplot(2,2,2),plot(Y1);
PY1=find(Y1~=0,1,'first');
PY2=find(Y1~=0,1,'last');
%%%%%%%%%%确定列的起始位置和终止位置%%%%%%%%%%%
X1=sum(rough_locate_image,1);
subplot(2,2,4),plot(X1);
PX1=find(X1~=0,1,'first');
PX2=find(X1~=0,1,'last');

rough_locate_image=rgb_image(PY1:PY2,PX1:PX2,:);
subplot(2,2,3),imshow(rough_locate_image),title('粗定位后的彩色车牌图像')
end

