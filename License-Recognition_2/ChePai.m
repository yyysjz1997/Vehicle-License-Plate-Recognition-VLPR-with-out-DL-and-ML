close all
clc
[fn,pn,fi]=uigetfile('/*.jpg','ѡ��ͼƬ');
YuanShi=imread([pn fn]);%����ԭʼͼ��
figure(1);subplot(3,2,1),imshow(YuanShi),title('ԭʼͼ��');
%%%%%%%%%%1��ͼ��Ԥ����%%%%%%%%%%%
YuanShiHuiDu=rgb2gray(YuanShi);%ת��Ϊ�Ҷ�ͼ��
subplot(3,2,2),imshow(YuanShiHuiDu),title('�Ҷ�ͼ��');

BianYuan=edge(YuanShiHuiDu,'canny',0.4);%Canny���ӱ�Ե���
subplot(3,2,3),imshow(BianYuan),title('Canny���ӱ�Ե����ͼ��');

se1=[1;1;1]; %���ͽṹԪ�� 
FuShi=imerode(BianYuan,se1);    %��ʴͼ��
subplot(3,2,4),imshow(FuShi),title('��ʴ���Եͼ��');

se2=strel('rectangle',[25,25]); %���νṹԪ��
TianChong=imclose(FuShi,se2);%ͼ����ࡢ���ͼ��
subplot(3,2,5),imshow(TianChong),title('����ͼ��');

YuanShiLvBo=bwareaopen(TianChong,2000);%�Ӷ������Ƴ����С��2000��С����
figure(2);
subplot(2,2,1),imshow(YuanShiLvBo),title('��̬�˲���ͼ��');
%%%%%%%%%%2�����ƶ�λ%%%%%%%%%%%
[y,x]=size(YuanShiLvBo);%size������������������ص���һ�������������������������ص��ڶ����������
YuCuDingWei=double(YuanShiLvBo);
%%%%%%%%%%2.1�����ƴֶ�λ֮һȷ���е���ʼλ�ú���ֹλ��%%%%%%%%%%%
Y1=zeros(y,1);%����y��1��ȫ������
for i=1:y
    for j=1:x
        if(YuCuDingWei(i,j)==1)
            Y1(i,1)= Y1(i,1)+1;%��ɫ���ص�ͳ��
        end
    end
end
[temp,MaxY]=max(Y1);%Y����������ȷ��������������temp��MaxY��temp������¼Y1��ÿ�е����ֵ��MaxY������¼Y1ÿ�����ֵ���к�
subplot(2,2,2),plot(0:y-1,Y1),title('ԭͼ�з������ص�ֵ�ۼƺ�'),xlabel('��ֵ'),ylabel('����'); 
PY1=MaxY;
while ((Y1(PY1,1)>=50)&&(PY1>1))
        PY1=PY1-1;
end
PY2=MaxY;
while ((Y1(PY2,1)>=50)&&(PY2<y))
        PY2=PY2+1;
end
IY=YuanShi(PY1:PY2,:,:);
%%%%%%%%%%2.2�����ƴֶ�λ֮��ȷ���е���ʼλ�ú���ֹλ��%%%%%%%%%%%
X1=zeros(1,x);%����1��x��ȫ������
for j=1:x
    for i=PY1:PY2
        if(YuCuDingWei(i,j,1)==1)
                X1(1,j)= X1(1,j)+1;               
         end  
    end       
end
subplot(2,2,4),plot(0:x-1,X1),title('ԭͼ�з������ص�ֵ�ۼƺ�'),xlabel('��ֵ'),ylabel('����');
PX1=1;
while ((X1(1,PX1)<3)&&(PX1<x))
       PX1=PX1+1;
end    
PX3=x;
while ((X1(1,PX3)<3)&&(PX3>PX1))
        PX3=PX3-1;
end
CuDingWei=YuanShi(PY1:PY2,PX1:PX3,:);
subplot(2,2,3),imshow(CuDingWei),title('�ֶ�λ��Ĳ�ɫ����ͼ��')
%%%%%%%%%%2.3�����ƾ���λ֮һԤ����%%%%%%%%%%%
CuDingWeiHuiDu=rgb2gray(CuDingWei); %��RGBͼ��ת��Ϊ�Ҷ�ͼ��
c_max=double(max(max(CuDingWeiHuiDu)));
c_min=double(min(min(CuDingWeiHuiDu)));
T=round(c_max-(c_max-c_min)/3); %TΪ��ֵ������ֵ
CuDingWeiErZhi=im2bw(CuDingWeiHuiDu,T/256);
figure(3);
subplot(2,2,1),imshow(CuDingWeiErZhi),title('�ֶ�λ�Ķ�ֵ����ͼ��')%DingWei
%%%%%%%%%%2.4�����ƾ���λ֮��ȥ���߿����%%%%%%%%%%%
[r,s]=size(CuDingWeiErZhi);%size������������������ص���һ�������������������������ص��ڶ����������
YuJingDingWei=double(CuDingWeiErZhi);%;CuDingWeiErZhi
X2=zeros(1,s);%����1��s��ȫ������
for i=1:r
    for j=1:s
        if(YuJingDingWei(i,j)==1)
            X2(1,j)= X2(1,j)+1;%��ɫ���ص�ͳ��
        end
    end
end
[temp,MaxX]=max(X2);
subplot(2,2,2),plot(0:s-1,X2),title('�ֶ�λ����ͼ���з������ص�ֵ�ۼƺ�'),xlabel('��ֵ'),ylabel('����');
%%%%%%%%%%2.4.1��ȥ�����߿����%%%%%%%%%%%
[g,h]=size(YuJingDingWei);
ZuoKuanDu=0;YouKuanDu=0;KuanDuYuZhi=5;
while sum(YuJingDingWei(:,ZuoKuanDu+1))~=0
    ZuoKuanDu=ZuoKuanDu+1;
end
if ZuoKuanDu<KuanDuYuZhi   % ��Ϊ��������
    YuJingDingWei(:,[1:ZuoKuanDu])=0;%��ͼ��d��1��KuanDu��ȼ�ĵ㸳ֵΪ��
    YuJingDingWei=QieGe(YuJingDingWei); %ֵΪ��ĵ�ᱻ�и�
end
subplot(2,2,3),imshow(YuJingDingWei),title('ȥ�����߿�Ķ�ֵ����ͼ��')
%%%%%%%%%2.4.1��ȥ���Ҳ�߿����%%%%%%%%%%%
[e,f]=size(YuJingDingWei);%��һ���ü���һ�Σ�������Ҫ�ٴλ�ȡͼ���С
d=f;
while sum(YuJingDingWei(:,d-1))~=0
    YouKuanDu=YouKuanDu+1;
    d=d-1;
end
if YouKuanDu<KuanDuYuZhi   % ��Ϊ���Ҳ����
    YuJingDingWei(:,[(f-YouKuanDu):f])=0;%
    YuJingDingWei=QieGe(YuJingDingWei); %ֵΪ��ĵ�ᱻ�и�
end
subplot(2,2,4),imshow(YuJingDingWei),title('��ȷ��λ�ĳ��ƶ�ֵͼ��')
% % % %%%%%%%%%%2.5�����泵��ͼ��%%%%%%%%%%%
% % % % imwrite(DingWei,'DingWei.jpg');
% % % % [filename,filepath]=uigetfile('DingWei.jpg','����һ����λ�ü���ĳ���ͼ��');
% % % % jpg=strcat(filepath,filename);
% % % % DingWei=imread('DingWei.jpg');
% % % %%%%%%%%%%3�������ַ��ָ�%%%%%%%%%%%
% % % %%%%%%%%%%3.1��Ԥ����%%%%%%%%%%%
% % % figure(4);
% % % % subplot(2,2,1),imshow(DingWei),title('����ͼ��')
% % % % ChePaiHuiDu=rgb2gray(DingWei); %��RGBͼ��ת��Ϊ�Ҷ�ͼ��
% % % % subplot(2,2,2),imshow(ChePaiHuiDu),title('���ƻҶ�ͼ��')
% % % % g_max=double(max(max(ChePaiHuiDu)));
% % % % g_min=double(min(min(ChePaiHuiDu)));
% % % % T=round(g_max-(g_max-g_min)/3); %TΪ��ֵ������ֵ
% % % % [m,n]=size(ChePaiHuiDu);
% % % % % ChePaiErZhi=(double(ChePaiHuiDu)>=T); %���ƶ�ֵͼ��
% % % % ChePaiErZhi=im2bw(ChePaiHuiDu,T/256);
% % % % % im2bw:ͨ���趨���Ƚ���ʵ�ͼ��ת��Ϊ��ֵͼ��T/256Ϊ��ֵ����Χ[0,1]
% % % % subplot(2,2,3),imshow(ChePaiErZhi),title('���ƶ�ֵͼ��')
ChePaiErZhi=YuJingDingWei;%logical()
ChePaiLvBo=bwareaopen(ChePaiErZhi,2);
subplot(1,2,1),imshow(ChePaiLvBo),title('��̬ѧ�˲���ĳ��ƶ�ֵͼ��')
ChePaiYuFenGe=double(ChePaiLvBo);

[p,q]=size(ChePaiYuFenGe);
X3=zeros(1,q);%����1��q��ȫ������
for j=1:q
    for i=1:p
       if(ChePaiYuFenGe(i,j)==1) 
           X3(1,j)=X3(1,j)+1;
       end
    end
end
subplot(1,2,2),plot(0:q-1,X3),title('�з������ص�Ҷ�ֵ�ۼƺ�'),xlabel('��ֵ'),ylabel('�ۼ�������');
%%%%%%%%%%3.2���ַ��ָ�%%%%%%%%%%%p��q������ָ�
Px0=q;%�ַ��Ҳ���
Px1=q;%�ַ������
for i=1:6
    while((X3(1,Px0)<3)&&(Px0>0))
       Px0=Px0-1;
    end
    Px1=Px0;
    while(((X3(1,Px1)>=3))&&(Px1>0)||((Px0-Px1)<15))
        Px1=Px1-1;
    end
    ChePaiFenGe=ChePaiLvBo(:,Px1:Px0,:);
    figure(6);subplot(1,7,8-i);imshow(ChePaiFenGe);
    ii=int2str(8-i);
    imwrite(ChePaiFenGe,strcat(ii,'.jpg'));%strcat�����ַ����������ַ�ͼ��
    Px0=Px1;
end
%%%%%%%%%%�Ե�һ���ַ������ر���%%%%%%%%%%%
PX3=Px1;%�ַ�1�Ҳ���
while((X3(1,PX3)<3)&&(PX3>0))
       PX3=PX3-1;
end
ZiFu1DingWei=ChePaiYuFenGe(:,1:PX3,:);
subplot(1,7,1);imshow(ZiFu1DingWei);
imwrite(ZiFu1DingWei,'1.jpg');
%%%%%%%%%%%4�������ַ�ʶ��%%%%%%%%%%%
%%%%%%%%%%%4.1�������ַ�Ԥ����%%%%%%%%%%%
ZiFu1=imresize(~imread('1.jpg'), [110 55],'bilinear');%�÷�ɫʶ��
ZiFu2=imresize(~imread('2.jpg'), [110 55],'bilinear');
ZiFu3=imresize(~imread('3.jpg'), [110 55],'bilinear');
ZiFu4=imresize(~imread('4.jpg'), [110 55],'bilinear');
ZiFu5=imresize(~imread('5.jpg'), [110 55],'bilinear');
ZiFu6=imresize(~imread('6.jpg'), [110 55],'bilinear');
ZiFu7=imresize(~imread('7.jpg'), [110 55],'bilinear');
%%%%%%%%%%%4.2����0-9,A-Z�Լ�ʡ�ݼ�Ƶ����ݴ洢�������%%%%%%%%%%%
HanZi=DuQuHanZi(imread('MuBanKu\sichuan.bmp'),imread('MuBanKu\guizhou.bmp'),imread('MuBanKu\beijing.bmp'),imread('MuBanKu\chongqing.bmp'),...
                imread('MuBanKu\guangdong.bmp'),imread('MuBanKu\shandong.bmp'),imread('MuBanKu\zhejiang.bmp'));
ShuZiZiMu=DuQuSZZM(imread('MuBanKu\0.bmp'),imread('MuBanKu\1.bmp'),imread('MuBanKu\2.bmp'),imread('MuBanKu\3.bmp'),imread('MuBanKu\4.bmp'),...
                   imread('MuBanKu\5.bmp'),imread('MuBanKu\6.bmp'),imread('MuBanKu\7.bmp'),imread('MuBanKu\8.bmp'),imread('MuBanKu\9.bmp'),...
                   imread('MuBanKu\10.bmp'),imread('MuBanKu\11.bmp'),imread('MuBanKu\12.bmp'),imread('MuBanKu\13.bmp'),imread('MuBanKu\14.bmp'),...
                   imread('MuBanKu\15.bmp'),imread('MuBanKu\16.bmp'),imread('MuBanKu\17.bmp'),imread('MuBanKu\18.bmp'),imread('MuBanKu\19.bmp'),...
                   imread('MuBanKu\20.bmp'),imread('MuBanKu\21.bmp'),imread('MuBanKu\22.bmp'),imread('MuBanKu\23.bmp'),imread('MuBanKu\24.bmp'),...
                   imread('MuBanKu\25.bmp'),imread('MuBanKu\26.bmp'),imread('MuBanKu\27.bmp'),imread('MuBanKu\28.bmp'),imread('MuBanKu\29.bmp'),...
                   imread('MuBanKu\30.bmp'),imread('MuBanKu\31.bmp'),imread('MuBanKu\32.bmp'),imread('MuBanKu\33.bmp'));
ZiMu=DuQuZiMu(imread('MuBanKu\10.bmp'),imread('MuBanKu\11.bmp'),imread('MuBanKu\12.bmp'),imread('MuBanKu\13.bmp'),imread('MuBanKu\14.bmp'),...
              imread('MuBanKu\15.bmp'),imread('MuBanKu\16.bmp'),imread('MuBanKu\17.bmp'),imread('MuBanKu\18.bmp'),imread('MuBanKu\19.bmp'),...
              imread('MuBanKu\20.bmp'),imread('MuBanKu\21.bmp'),imread('MuBanKu\22.bmp'),imread('MuBanKu\23.bmp'),imread('MuBanKu\24.bmp'),...
              imread('MuBanKu\25.bmp'),imread('MuBanKu\26.bmp'),imread('MuBanKu\27.bmp'),imread('MuBanKu\28.bmp'),imread('MuBanKu\29.bmp'),...
              imread('MuBanKu\30.bmp'),imread('MuBanKu\31.bmp'),imread('MuBanKu\32.bmp'),imread('MuBanKu\33.bmp'));
ShuZi=DuQuShuZi(imread('MuBanKu\0.bmp'),imread('MuBanKu\1.bmp'),imread('MuBanKu\2.bmp'),imread('MuBanKu\3.bmp'),imread('MuBanKu\4.bmp'),...
                imread('MuBanKu\5.bmp'),imread('MuBanKu\6.bmp'),imread('MuBanKu\7.bmp'),imread('MuBanKu\8.bmp'),imread('MuBanKu\9.bmp')); 
%%%%%%%%%%%4.3�������ַ�ʶ��%%%%%%%%%%%
t=1;
ZiFu1JieGuo=ShiBieHanZi(HanZi,ZiFu1);   ShiBieJieGuo(1,t)=ZiFu1JieGuo;t=t+1;
ZiFu2JieGuo=ShiBieZiMu (ZiMu, ZiFu2);   ShiBieJieGuo(1,t)=ZiFu2JieGuo;t=t+1;
ZiFu3JieGuo=ShiBieSZZM(ShuZiZiMu,ZiFu3);ShiBieJieGuo(1,t)=ZiFu3JieGuo;t=t+1;
ZiFu4JieGuo=ShiBieSZZM(ShuZiZiMu,ZiFu4);ShiBieJieGuo(1,t)=ZiFu4JieGuo;t=t+1;
ZiFu5JieGuo=ShiBieShuZi(ShuZi,ZiFu5);   ShiBieJieGuo(1,t)=ZiFu5JieGuo;t=t+1;
ZiFu6JieGuo=ShiBieShuZi(ShuZi,ZiFu6);   ShiBieJieGuo(1,t)=ZiFu6JieGuo;t=t+1;
ZiFu7JieGuo=ShiBieShuZi(ShuZi,ZiFu7);   ShiBieJieGuo(1,t)=ZiFu7JieGuo;t=t+1;
ShiBieJieGuo
msgbox(ShiBieJieGuo,'���');
fid=fopen('Data.xls','a+');
fprintf(fid,'%s\r\n',ShiBieJieGuo,datestr(now));
fclose(fid);


