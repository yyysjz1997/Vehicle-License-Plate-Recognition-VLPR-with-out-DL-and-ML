clear
I=imread('Image/（2）WJ03-警0037.jpg');              %读取图像
I1=im2double(rgb2gray(I));
[m,n]=size(I1);
I1=medfilt2(I1);

%进行预处理操作
I2=I1;
A0=[-1 -2 -1;0 0 0 ;1 2 1];
A1=A0';
I3=padarray(I2,[1 1],'symmetric');              %使用镜像的方式在图像边界上的点进行填充
for i=2:m
    for j=2:n
        block=I3(i-1:i+1,j-1:j+1);
        b0=A0.*block;
        b1=A1.*block;
        bb0=(sum(b0(:)));
        bb1=(sum(b1(:)));
        I2(i,j)=sqrt(bb0^2+3*bb1^2);
    end
end

%二值化图像
N=11;TH=std2(I2);
if(sum(I1(:))/(m*n)<0.2)
    TH=0.5*TH;
end
I4=zeros(m,n);
I3=I2;
for i=1+(N-1)/2:m-(N-1)/2
    for j=1+(N-1)/2:n-(N-1)/2
        block=I3(i,j-(N-1)/2:j+(N-1)/2);
        var=std2(block);
        if(var>TH)        %不同的图像可能需要取不同的TH大小(亮度高：TH；亮度低：0.5*TH)
            I4(i,j)=1;
        end
    end
end

I6=I4;
I4(1:round(m/2),:)=0;
I4(round(0.85*m):m,:)=0;
se=strel('square',3);
I4=imclose(I4,se);
I4=imfill(I4,'holes');
I4=bwareaopen(I4,1000);             %删除像素点个数少于1000的像素点
[I5,num]=bwlabel(I4,8);

b=zeros(1,num);p=zeros(1,num);
for i=1:num                         %计算连通域的长宽比和矩形度
    [y,x]=find(I5==i);
    x0=min(x(:));
    x1=max(x(:));
    y0=min(y(:));
    y1=max(y(:));
    b(i)=(x1-x0)/(y1-y0);
    if(b(i)>2.3&&b(i)<10)
        p(i)=(sum(I5(:)==i))/((x1-x0)*(y1-y0));          %计算区域为矩形的概率
        if((y1-y0)>m/2||(x1-x0)>n/2)
            p(i)=0;
        end
        if((y1-y0)<m/30||(x1-x0)<n/30)
            p(i)=0;
        end
    end
end
P_max=max(p(:));
i=find(p==P_max);
if(P_max==0)                    %如果阈值设置不合理，导致所有区域都被排除，找出长宽比和4最接近的
    cha=3.5*ones(1,num);
    cha=b-cha;cha=abs(cha);
    i=find(cha==(min(cha(:))));
end
I5(~(I5==i))=0;
I5(I5==i)=1;

[y,x]=find(I5~=0);
x0=min(x(:));
x1=max(x(:));
y0=min(y(:));
y1=max(y(:));

[I7,num]=bwlabel(I4,8);
for j=1:num
    if(j~=i)
        [yy,xx]=find(I7==j);
        xx0=min(xx(:));
        xx1=max(xx(:));
        yy0=min(yy(:));
        yy1=max(yy(:));
        h0=y1-y0;
        hh0=yy1-yy0;
        y_sect=intersect(y,yy);
        hhh0=min(h0,hh0);
        dish=min(abs(x1-xx0),abs(x0-xx1));
        w=sqrt((x1-x0)*(xx1-xx0));
        I=(max(y_sect(:))-min(y_sect(:)))/hhh0-dish/w;
        if(I>0.8)
            x1=max(x1,xx1);
            x0=min(x0,xx0);
            y1=max(y1,yy1);
            y0=min(y0,yy0);
        end
    end
end
I1=I1(y0:y1,x0:x1);
I7=edge(I1,'canny',0.1);
I7=bwmorph(I7,'skel',Inf);

figure(2);subplot(231),imshow(I7);