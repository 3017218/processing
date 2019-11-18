function [outputImg] = bilinearInterpolation(inputImg,zmf)
if zmf >2
    error('缩放倍数的值应该小于2');
end
if zmf <= 0
    error('缩放倍数的值应该大于0');
end

[height,width,channel] = size(inputImg);
new_height = round(height*zmf); % 计算缩放后的图像高度，取整
new_width = round(width*zmf); % 计算缩放后的图像宽度，取整
new_img = zeros(new_height,new_width,channel); % 创建新图像

%扩展原始矩阵I边缘
img_scale = zeros(height+2,width+2,channel); % 为了边界点考虑的
img_scale(2:height+1,2:width+1,:) = inputImg;
%为4周各添加的一行或列做值的初始化
%为扩展而来的各边赋值
img_scale(1,2:width+1,:) = inputImg(1,:,:);
img_scale(height+2,2:width+1,:) = inputImg(height,:,:);
img_scale(2:height+1,1,:) = inputImg(:,1,:);
img_scale(2:height+1,width+2,:) = inputImg(:,width,:);
% 用原图的4个顶点为扩展而来的4个顶点赋值
img_scale(1,1,:) = inputImg(1,1,:);
img_scale(1,width+2,:) = inputImg(1,width,:);
img_scale(height+2,1,:) = inputImg(height,1,:);
img_scale(height+2,width+2,:) = inputImg(height,width,:);

%由新图像的某个像素（zi，zj）映射到原始图像(ii，jj)处， 并在原始
%图像的(ii,jj)位置利用其周围4个像素点进行插值得到(ii,jj)处的像素值
for zj = 1:new_width         % 对图像进行按列逐元素扫描
    for zi = 1:new_height
        % (zi,zj)表示在新图中的坐标，(ii,jj)表示在原图中的坐标
        ii = (zi-1)/zmf; jj = (zj-1)/zmf;
        i = floor(ii); j = floor(jj); % 向下取整得到在原图中坐标的整数部分
        u = ii - i; v = jj - j;       % 得到在原图中坐标的小数部分
        i = i + 1; j = j + 1;
        new_img(zi,zj,:) = (1-u)*(1-v)*img_scale(i,j,:) + u*(1-v)*img_scale(i,j+1,:)...
                    + (1-u)*v*img_scale(i+1,j,:) + u*v*img_scale(i+1,j+1,:);
    end
end

outputImg = uint8(new_img);
end