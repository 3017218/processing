function [img] = generateFigure(imgW,img)
% ����һ����ɫͼ��ͼ��������ɫ��ʾ��0��2*pi�������Ҳ�
% �ú�ɫ��ʾ��0��2*pi�������Ҳ�
% �û�ɫ��ʾ��0��2*pi����y=x����2ͼ��
x = linspace(0,2*pi);
y = cos(x);
z = sin(x);
h = power(x,2);
plot(x,y,'red',x,z,'green',x,h,'yellow');
end