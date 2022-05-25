close all
clc
clear
[fn,pn,fi]=uigetfile('Image\*.jpg','选择图片');
rgb_image=imread([pn fn]);%输入原始图像
filtered_image=rgb2filtered(rgb_image,1); %图像预处理
imwrite(filtered_image,'filtered_image.png');
rough_locate_image=rough_locate(filtered_image,rgb_image,2); %车牌粗定位
imwrite(rough_locate_image,'rough_locate_image.png');
precise_locate_image=precise_locate(rough_locate_image,3); %车牌精定位
imwrite(precise_locate_image,'precise_locate_image.png');
cropped_image=final_crop(precise_locate_image,4); %车牌切割
imwrite(cropped_image,'cropped_image.png');
char_images=seperate_characters(cropped_image,5); %字符切割
characters_recognition(char_images,6); %字符识别






