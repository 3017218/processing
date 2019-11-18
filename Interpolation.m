function [outputImg] = bilinearInterpolation(inputImg,zmf)
if zmf >2
    error('���ű�����ֵӦ��С��2');
end
if zmf <= 0
    error('���ű�����ֵӦ�ô���0');
end

[height,width,channel] = size(inputImg);
new_height = round(height*zmf); % �������ź��ͼ��߶ȣ�ȡ��
new_width = round(width*zmf); % �������ź��ͼ���ȣ�ȡ��
new_img = zeros(new_height,new_width,channel); % ������ͼ��

%��չԭʼ����I��Ե
img_scale = zeros(height+2,width+2,channel); % Ϊ�˱߽�㿼�ǵ�
img_scale(2:height+1,2:width+1,:) = inputImg;
%Ϊ4�ܸ���ӵ�һ�л�����ֵ�ĳ�ʼ��
%Ϊ��չ�����ĸ��߸�ֵ
img_scale(1,2:width+1,:) = inputImg(1,:,:);
img_scale(height+2,2:width+1,:) = inputImg(height,:,:);
img_scale(2:height+1,1,:) = inputImg(:,1,:);
img_scale(2:height+1,width+2,:) = inputImg(:,width,:);
% ��ԭͼ��4������Ϊ��չ������4�����㸳ֵ
img_scale(1,1,:) = inputImg(1,1,:);
img_scale(1,width+2,:) = inputImg(1,width,:);
img_scale(height+2,1,:) = inputImg(height,1,:);
img_scale(height+2,width+2,:) = inputImg(height,width,:);

%����ͼ���ĳ�����أ�zi��zj��ӳ�䵽ԭʼͼ��(ii��jj)���� ����ԭʼ
%ͼ���(ii,jj)λ����������Χ4�����ص���в�ֵ�õ�(ii,jj)��������ֵ
for zj = 1:new_width         % ��ͼ����а�����Ԫ��ɨ��
    for zi = 1:new_height
        % (zi,zj)��ʾ����ͼ�е����꣬(ii,jj)��ʾ��ԭͼ�е�����
        ii = (zi-1)/zmf; jj = (zj-1)/zmf;
        i = floor(ii); j = floor(jj); % ����ȡ���õ���ԭͼ���������������
        u = ii - i; v = jj - j;       % �õ���ԭͼ�������С������
        i = i + 1; j = j + 1;
        new_img(zi,zj,:) = (1-u)*(1-v)*img_scale(i,j,:) + u*(1-v)*img_scale(i,j+1,:)...
                    + (1-u)*v*img_scale(i+1,j,:) + u*v*img_scale(i+1,j+1,:);
    end
end

outputImg = uint8(new_img);
end