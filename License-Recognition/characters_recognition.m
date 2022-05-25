function [ result ] = characters_recognition( char_images,fig )
figure(fig);
for i=1:34
    im=imread(['characters/character/',num2str(i-1),'.bmp'],'bmp');
    im=~im2bw(im,0.5);
    chars{1,i}=im;
end

for i=1:2
    im_hanzi=imread(['characters/c_character/',num2str(i),'.jpg'],'jpg');
    chars_hanzi{1,i}=double(im_hanzi);
end

i=1;
diff=[];
for j=1:2
    h=min(size(char_images{i},1),size(chars_hanzi{j},1));
    w=min(size(char_images{i},2),size(chars_hanzi{j},2));
    im1=imresize(char_images{i},[h,w]);
    im2=imresize(chars_hanzi{j},[h,w]);

    diff_image=im1.*im2;
    imLabel = bwlabel(diff_image);% 对连通区域进行标记
    stats = regionprops(diff_image,'Area');
    [b,index]=max([stats.Area]);
    diff_image=ismember(imLabel,index(1));
    diff_image=(im1+im2).*(~diff_image);

    %subplot(6,6,j),imshow(diff_image);
    diff=[diff,sum(sum(diff_image))/(h*w)];

end
[a,index]=min(diff);
ind_hanzi(i)=index;


for i=2:7
    diff=[];
    for j=1:34
        h=min(size(char_images{i},1),size(chars{j},1));
        w=min(size(char_images{i},2),size(chars{j},2));
        im1=imresize(char_images{i},[h,w]);
        im2=imresize(chars{j},[h,w]);
        
        diff_image=im1.*im2;
        imLabel = bwlabel(diff_image);% 对连通区域进行标记
        stats = regionprops(diff_image,'Area');
        [b,index]=max([stats.Area]);
        diff_image=ismember(imLabel,index(1));
        diff_image=(im1+im2).*(~diff_image);
        
        %subplot(6,6,j),imshow(diff_image);
        diff=[diff,sum(sum(diff_image))/(h*w)];
        
    end
    subplot(1,8,i),plot(diff);
    [a,index]=min(diff);
    ind(i)=index;
end

disp("车牌号码为：");
if ind_hanzi(1)==1     
    fprintf("粤");
elseif ind_hanzi(1)==2
    fprintf("鲁");
elseif ind_hanzi(1)==3
    fprintf("闽");
elseif ind_hanzi(1)==4
    fprintf("豫");
elseif ind_hanzi(1)==5
    fprintf("辽");
else
    fprintf("");
end





for i=2:7
    subplot(7,8,i*8),imshow(chars{ind(i)})
    if ind(i)==11      
        fprintf("A");
    elseif ind(i)==12
        fprintf("B");
    elseif ind(i)==13
        fprintf("C");
    elseif ind(i)==14
        fprintf("D");
    elseif ind(i)==15
        fprintf("E");
    elseif ind(i)==16
        fprintf("F");
    elseif ind(i)==17
        fprintf("G");
    elseif ind(i)==18
        fprintf("H");
    elseif ind(i)==19
        fprintf("J");
    elseif ind(i)==20
        fprintf("K");
    elseif ind(i)==21
        fprintf("L");
    elseif ind(i)==22
        fprintf("M");
    elseif ind(i)==23
        fprintf("N");
    elseif ind(i)==24
        fprintf("P");
    elseif ind(i)==25
        fprintf("Q");
    elseif ind(i)==26
        fprintf("R");
    elseif ind(i)==27
        fprintf("S");
    elseif ind(i)==28
        fprintf("T");
    elseif ind(i)==29
        fprintf("U");
    elseif ind(i)==30
        fprintf("V");
    elseif ind(i)==31
        fprintf("W");
    elseif ind(i)==32
        fprintf("X");
    elseif ind(i)==33
        fprintf("Y");
    elseif ind(i)==34
        fprintf("Z");
    else
        fprintf("%d",ind(i)-1);
    end
end


