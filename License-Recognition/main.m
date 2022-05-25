close all
clc
clear
[fn,pn,fi]=uigetfile('Image\*.jpg','ѡ��ͼƬ');
rgb_image=imread([pn fn]);%����ԭʼͼ��
filtered_image=rgb2filtered(rgb_image,1); %ͼ��Ԥ����
imwrite(filtered_image,'filtered_image.png');
rough_locate_image=rough_locate(filtered_image,rgb_image,2); %���ƴֶ�λ
imwrite(rough_locate_image,'rough_locate_image.png');
precise_locate_image=precise_locate(rough_locate_image,3); %���ƾ���λ
imwrite(precise_locate_image,'precise_locate_image.png');
cropped_image=final_crop(precise_locate_image,4); %�����и�
imwrite(cropped_image,'cropped_image.png');
char_images=seperate_characters(cropped_image,5); %�ַ��и�
characters_recognition(char_images,6); %�ַ�ʶ��






