%%%%%%%%%%���ƴֶ�λ%%%%%%%%%%%
function rough_locate_image = rough_locate( filtered_image,rgb_image,fig)
figure(fig);
subplot(2,2,1),imshow(filtered_image),title('��̬�˲���ͼ��');
rough_locate_image=double(filtered_image);
%%%%%%%%%%ȷ���е���ʼλ�ú���ֹλ��%%%%%%%%%%%
Y1=sum(rough_locate_image,2);
subplot(2,2,2),plot(Y1);
PY1=find(Y1~=0,1,'first');
PY2=find(Y1~=0,1,'last');
%%%%%%%%%%ȷ���е���ʼλ�ú���ֹλ��%%%%%%%%%%%
X1=sum(rough_locate_image,1);
subplot(2,2,4),plot(X1);
PX1=find(X1~=0,1,'first');
PX2=find(X1~=0,1,'last');

rough_locate_image=rgb_image(PY1:PY2,PX1:PX2,:);
subplot(2,2,3),imshow(rough_locate_image),title('�ֶ�λ��Ĳ�ɫ����ͼ��')
end

