%%%%%%%%%% FINAL CROP %%%%%%%%%%%%% 
function [ cropped_image ] = final_crop(precise_locate_image,fig)
figure(fig);
X1=sum(precise_locate_image,1);
image_width=size(precise_locate_image,2);

characters=get_character(precise_locate_image,'tight');
higher_bound=int16(min(characters(:,2)));
height=int16(max(characters(:,4)));
width=min(int16(height*4.65),image_width);
lower_bound=int16(max(characters(:,2))+height);

left_border=zeros(image_width);
for i=1:image_width-width
    left_border(i)=sum(X1(i))+sum(X1(i+width));
end

subplot(1,2,1),plot(left_border(1:image_width-width));
[a,left_bound]=min(left_border);
left_bound=left_bound(1);
right_bound=left_bound+width-1;
cropped_image=precise_locate_image(higher_bound:lower_bound,left_bound:right_bound);
subplot(1,2,2),imshow(cropped_image);
end

