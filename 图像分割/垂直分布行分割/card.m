close all
clear all
[fn,pn,fi]=uigetfile('*.*','ѡ��ͼƬ');%ѡ��ͼƬ
I=imread([pn fn]);
[m, n, k]=size(I);
%I=rgb2gray(I);

figure,imshow(I);
%J=imresize(I,0.5);%��Сͼ��0.5��
I1=rgb2gray(I);
T=graythresh(I1);
J=im2bw(I1,T);
%J=im2bw(I);
%J=medfilt2(J,[3 3]);
figure,imshow(J);

%ͳ��ÿ���������ص����
num=zeros(m,1);
for i=1:m
    for j=1:n
        num(i)=num(i)+~J(i,j);
    end
end
x=1:1:m;    
figure,bar(x,num,'b');%����ͳ��ֱ��ͼ
%���ڼ�¼����߽��������
rowreg=zeros(20,1);
rowregnum=0;
if num(1)~=0    rowreg(1)=1;rowregnum=1;    end%��ʼ����һ�����ֵ���ʼ�к�
for i=2:m
    if (~num(i)&&num(i-1))||(num(i)&&~num(i-1))%����߽����ж�
        rowregnum=rowregnum+1;
        rowreg(rowregnum)=i;%��¼����߽����к�
    end
end
if num(m)~=0 %ȷ�����һ�������±߽��к�
     rowregnum=rowregnum+1;
     rowreg(rowregnum)=m;
end
%����ָ����ÿһ������
line=1;
while line<=rowregnum
     figure,imshow(J(rowreg(line):rowreg(line+1)-1,1:n),[]); 
     line=line+2;
end

%����������ȥ���и�̫С������,������ָ����ÿһ�����֣�ȥ��ǰ�����Ŀհײ���
%����������ָ��ÿ�����ֵķ������ƣ�Ҳ���Բο�namecard1.m�ķ�����
        
    
    

