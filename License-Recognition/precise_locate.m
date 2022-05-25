%%%%%%%%%%车牌精定位%%%%%%%%%%%
function precise_locate_image = precise_locate( rough_locate_image,fig )
figure(fig)
precise_locate_image=imresize(rough_locate_image,[140,440]); %uniformly resize image
thresh=graythresh(precise_locate_image); 
precise_locate_image=im2bw(precise_locate_image,thresh); %binarise the image
precise_locate_image=bwmorph(precise_locate_image,'open'); %open operate
precise_locate_image=bwareaopen(precise_locate_image,50); %get main objects
characters=get_character(precise_locate_image,'tight'); %get all connected regions
%%%%%%%%%% ANALISING HISTOGRAM %%%%%%%%%%%%% 
subplot(3,2,1),imshow(precise_locate_image)
Y1=sum(precise_locate_image,2);
%Y1=histeq(Y1/sum(Y1));
subplot(3,2,3),plot(Y1);
X1=sum(precise_locate_image,1);
%X1=histeq(X1/sum(X1));
subplot(3,2,5),plot(X1);
%%%%%%%%%% ROTATE IMAGE %%%%%%%%%%%%%%
angle=(characters(2:end,2)-characters(1:end-1,2))./(characters(2:end,1)-characters(1:end-1,1));
angle=atan(mean(angle))/2/pi*360;
precise_locate_image=imrotate(precise_locate_image,angle,'bicubic','crop');
%%%%%%%%%% HORIZONTAL IMAGE CROP %%%%%%%%%%%%%%
characters=get_character(precise_locate_image,'tight');
higher_bound=int16(min(characters(:,2)));
lower_bound=int16(max(characters(:,2))+max(characters(:,4)));
precise_locate_image(1:higher_bound,:)=0;
precise_locate_image(lower_bound:end,:)=0;
precise_locate_image=bwmorph(precise_locate_image,'open');
c_height=mean(characters(:,4));
c_width=mean(characters(:,3));
image_width=int16(440/c_width/2.05*c_height);
precise_locate_image=imresize(precise_locate_image,[140,image_width]);
subplot(3,2,2),imshow(precise_locate_image)
%%%%%%%%%% ANALISING HISTOGRAM %%%%%%%%%%%%% 
Y1=sum(precise_locate_image,2);
%Y1=histeq(Y1/sum(Y1));
subplot(3,2,4),plot(Y1);
X1=sum(precise_locate_image,1);
%X1=histeq(X1/sum(X1));
subplot(3,2,6),plot(X1);
end

