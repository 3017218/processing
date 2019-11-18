function [img] = generateFigure(imgW,img)
% 产生一幅彩色图像，图像中用绿色显示【0，2*pi】的正弦波
% 用红色显示【0，2*pi】的余弦波
% 用黄色显示【0，2*pi】的y=x……2图像
x = linspace(0,2*pi);
y = cos(x);
z = sin(x);
h = power(x,2);
plot(x,y,'red',x,z,'green',x,h,'yellow');
end