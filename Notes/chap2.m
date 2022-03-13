% ========================================================================
% 李维波教授《MATLAB在电气工程中的应用学习笔记
% 第二章 MATLAB的数值计算方法 
% by Vico Zhang, 2022/3/13
% ------------------------------------------------------------------------
% version-1.0-2022/3/13 : 第一部分程序录入，并对程序进行了简化
% ------------------------------------------------------------------------
% 运行时需要以节为单位运行
% ========================================================================

%% 2.2 变量运算

%% 绘制削顶的整流正弦半波
clc;clear;close;
t = linspace(0, 3*pi, 600);
y = 100 * sin(t);
z1 = (t<pi|t>2*pi).*y;
w = (t>pi/3&t<2*pi/3)+(t>7*pi/3&t<8*pi/3);
w_n = ~w;
z2 = w*100*sin(pi/3)+w_n.*z1;
subplot(1,3,1)
plot(t, y, 'r:', LineWidth=3)
title('正弦曲线')
ylabel('y')
subplot(1,3,2)
plot(t, z1, 'b:', LineWidth=3)
xlabel('t')
axis([0 10 -100 100])
title('整流半波波形')
subplot(1,3,3)
plot(t, z2, 'g-', LineWidth=3)
axis([0 10 -100 100])
title('削顶整流半波')

%% 因式分解
clc;clear;close
num = conv([1 0 2], conv([1 4],[1 1]));
den = [1 0 1 1];
[r, p, k] = residue(num, den);

%% 一维多项式插值
clc;clear
ys = [0 0.8 .7 .9 .6 1 0 .1 -.3 -.7 -.9 -.2 -.1 0 -.4 -.7 0 1];
xs = 0:length(ys)-1;
x = 0:0.1:length(ys)-1;
y1 = interp1(xs, ys, x, 'nearest');
y2 = interp1(xs, ys, x, 'linear');
y3 = interp1(xs, ys, x, 'spline');
y4 = interp1(xs, ys, x, 'cubic');
plot(xs,ys,'+k',x,y1,':r',x,y2,'-m',x,y3,'--b',x,y4,'--c');
legend('sampled point','nearest','linear','spline','cubic');
title('多项式插值')
grid on

%% 快速傅里叶变换
clc;clear;
t = 0:0.001:0.6;
x = 2*sin(2*pi*50*t)+1*sin(2*pi*120*t)+1.5*sin(2*pi*200*t);
y = x+0.5*randn(size(x));
subplot(2,1,1)
plot(y(1:50),'r',LineWidth=3)
title('传感器叠加又随机噪声信号的输出信号')
Y = fft(y,512);
f = 1000*(0:256)/512;
subplot(2,1,2)
plot(f,Y(1:257),LineWidth=3)
title('传感器叠加又随机噪声信号的输出信号的频域特性')
grid on 

