close all
clear all
[fn,pn,fi]=uigetfile('*.*','选择图片');%选择图片
I=imread([pn fn]);
[m, n, k]=size(I);
%I=rgb2gray(I);

figure,imshow(I);
%J=imresize(I,0.5);%缩小图像0.5倍
I1=rgb2gray(I);
T=graythresh(I1);
J=im2bw(I1,T);
%J=im2bw(I);
%J=medfilt2(J,[3 3]);
figure,imshow(J);

%统计每行文字像素点个数
num=zeros(m,1);
for i=1:m
    for j=1:n
        num(i)=num(i)+~J(i,j);
    end
end
x=1:1:m;    
figure,bar(x,num,'b');%绘制统计直方图
%用于记录区域边界的行坐标
rowreg=zeros(20,1);
rowregnum=0;
if num(1)~=0    rowreg(1)=1;rowregnum=1;    end%初始化第一行文字的起始行号
for i=2:m
    if (~num(i)&&num(i-1))||(num(i)&&~num(i-1))%区域边界点的判断
        rowregnum=rowregnum+1;
        rowreg(rowregnum)=i;%记录区域边界点的行号
    end
end
if num(m)~=0 %确定最后一个区域下边界行号
     rowregnum=rowregnum+1;
     rowreg(rowregnum)=m;
end
%输出分割出的每一行文字
line=1;
while line<=rowregnum
     figure,imshow(J(rowreg(line):rowreg(line+1)-1,1:n),[]); 
     line=line+2;
end

%接下来，请去掉行高太小的区域,对上面分割出的每一行文字，去掉前后多余的空白部分
%方法与上面分割出每行文字的方法类似，也可以参考namecard1.m的方法。
        
    
    

