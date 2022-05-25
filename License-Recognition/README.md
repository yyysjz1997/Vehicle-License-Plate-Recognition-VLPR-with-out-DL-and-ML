1、rgb2filtered.m
预处理图片+蓝色过滤+去除粗噪声
利用中国车牌蓝色定位车牌区域

2、rough_locate.m
粗定位车牌区域

3、precise_locate.m
精准定位车牌位置+旋转为水平

4、final_crop.m
切割车牌，只保留文字部分

5、seperate_characters.m
分割字符

6、characters_recognition.m
利用图像差分运算识别字符

函数：get_character.m
利用字符形状特征进行连通区域的划分。相比于图像投影法，小噪声对算法稳健性影响较小。
