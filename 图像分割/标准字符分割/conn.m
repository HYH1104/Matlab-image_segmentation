clear;
clc;
f = imread('1.jpg');
f = imadjust(f,[0 1],[1 0]);

SE = strel('square',3);
A2 = imdilate(f,SE);
SE = strel('disk',1);
f = imerode(A2,SE);
SE = strel('square',1);
f = imdilate(f,SE);

gray_level = graythresh(f);

f = im2bw(f,gray_level);

[l,n] = bwlabel(f,8);
imshow(f);
hold on
for k = 1:n
    [r,c] = find(l==k);
    rbar = mean(r);
    cbar = mean(c);


plot(cbar,rbar,'Marker','o','MarkerEdgeColor','g','MarkerFaceColor','y','MarkerSize',10);
row = max(r) - min(r);
col = max(c) - min(c);
for i = 1:row
    for j = 1:col
        seg(i,j) = 1;
    end
end
con = [r-min(r)+1,c-min(c)+1];
[a,b] = size(con);
for i = 1:a
    seg(con(i,1),con(i,2)) = 0;
end
imwrite(seg,strcat('seg',int2str(k),'.bmp'));
clear seg;
end

fpath = 'C:\Users\DING\Desktop\WSR\result';  %这里是文件夹的名字
flist = dir(sprintf('%s/*.bmp', fpath));

images = [];
figure
hold on
for imidx = 1:min(length(flist), 200)
    fprintf('[%d]', imidx); %显示进程
    fname = sprintf('%s/%s', fpath, flist(imidx).name);
    im = imread(fname);
    subplot(4,8,imidx);
    imshow(im);
    images{length(images)+1} = im;
end
fprintf('\n');