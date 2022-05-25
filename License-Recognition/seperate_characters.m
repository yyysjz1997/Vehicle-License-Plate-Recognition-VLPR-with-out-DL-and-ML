function [ char_images ] = seperate_characters( cropped_image,fig)
char_images=[];
characters=get_character(cropped_image,'loose');
distance=characters(2:end,1)-characters(1:end-1,1);
gap=int16(mean(distance(2:end)));
upper=int16(mean(characters(:,2)));
height=int16(mean(characters(:,4)));
width=int16(mean(characters(:,3)));
if characters(1,1)-gap>0
    c_char=[characters(1,1)-gap,upper,width,height];
    characters=[c_char;characters];
end
while characters(end,1)+gap<size(cropped_image,2)
    c_char=[characters(end,1)+gap,upper,width,height];
    characters=[characters;c_char];
end
figure(fig);
for i=1:7
    up=int16(characters(i,2));
    down=min(up+height,size(cropped_image,1));
    left=int16(characters(i,1));
    right=min(left+width,size(cropped_image,2));
    char_images{i}=cropped_image(up:down,left:right);
end
if size(char_images{7},2)<width
    sub=zeros(size(char_images{7},1),width-size(char_images{7},2));
    sub=logical(sub);
    char_images{7}=[char_images{7} sub];
end
for i=1:7
    subplot(1,7,i),imshow(char_images{i})
end
