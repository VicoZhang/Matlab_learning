% ========================================================================
% 李维波教授《MATLAB在电气工程中的应用学习笔记
% 第一章 MATLAB软件的快速入门 1.11 典型应用实例分析
% by Zeyu Zhang, 2022/2/27
% ------------------------------------------------------------------------
% version-1.0-2022/2/27 : 第一部分程序录入，并修改了一部分书上不合理的部分
% version-2.0-2022/3/5 : 第二部分程序录入，并解决了一部分警告的问题
% ------------------------------------------------------------------------
% 运行时需要以节为单位运行
% ========================================================================

%% 1.11.1整流波形描述方法举例

%% 逐段解析函数的计算和表达
clc;clear;close;
t = linspace(0, 3*pi, 500);
y = 10 * sin(t);
z = (y >= 0) .* y; % 正弦整流半波
a = 10 * sin(pi/3);
z = (y >= a).*a + (y < a).*z; % 削顶的正弦整流半波
plot(t, y,':r', 'LineWidth', 3);
hold on;
plot(t, z, '-b', 'LineWidth', 3);
xlabel('t');
ylabel('z=f(t)');
title('逐段解析函数的表达和计算');
legend('y=sin(t)', 'z=f(t)');

%% 11.1.2 曲线簇描述方法举例

%% 余弦函数曲线
clc;clear;close;
t = (0:pi/50:2*pi)'; % 注意转置，匹配维度
k = 1:0.5:3;
Y = cos(t) * k;
plot(t, Y, 'LineWidth', 3);
legend('k =1.0', 'k=1.5', 'k=2.0', 'k=2.5', 'k=3');
title('余弦函数曲线');
grid on

%% 连续调制波形y=sin(t)sin(20t)+2 ---subplot的运用
clc;clear;close
t1 = (0:30) / 30 * 2 * pi;
y1 = sin(t1) .* sin(20*t1);
t2 = (0:100) / 100 * 2 * pi;
y2 = sin(t2) .* sin(20*t2);

subplot(2, 2, 1)
plot(t1, y1, 'r.', LineWidth=3);
axis([0 2*pi -1 1]);
title('曲线1');

subplot(2, 2, 2)
plot(t2, y2, 'r.', 'LineWidth', 3);
axis([0 2*pi -1 1]);
title('曲线2');

subplot(2, 2, 3)
plot(t1, y1, LineWidth=3);
axis([0 2*pi -1 1]);
title('曲线3');

subplot(2, 2, 4)
plot(t2, y2, LineWidth=3);
axis([0 2*pi -1 1]);
title('曲线4');

%% 彩带绘图绘制规划二阶系统的阶跃响应 ---ribbon的运用
clear;clc;close;
zeta2 = [0.1 0.2 0.3 0.4 0.5 0.6 0.8 1.0];
n =length(zeta2);
for k=1:n
    Num{k,1} = 1;
    Den{k,1} = [1 2*zeta2(k) 1];
end
S = tf(Num, Den);
t = (0:0.1:30)';
[Y, x] = step(S, t);
tt = t * ones(size(zeta2)); % 专门用来画图，不与时间t混淆
ribbon(tt, Y, 0.4)
% 以下为装饰图像
view([115, 30])
shading interp
colormap("jet")
light, lighting phong, box on
for k = 1:n
    str_lgd{k, 1} = num2str(zeta2(k));
end
legend(str_lgd)
str1 = 'G=(s^{2} + 2\zeta +1)^{-1}';
str2 = ',取不同';
str3 = '{\fontsize{16}\zeta}';
str4 = '{时的阶跃响应}';
title([str1 str2 str3 str4])
zlabel('y(\zeta,t)\rightarrow')

%% 1.11.3 调制波形描述方法举例

%% 绘制波形y=sin(t)sin(20t)的包络线

t1 = (0:pi/100:2*pi)';
y1 = sin(t1)*[-1 1] + 2;
t2 = t1;
y2 = sin(t2).*sin(20*t2)+2;
t3 = 2*pi*(0:9)/9;
y3 = sin(t3).*sin(20*t3)+2;

subplot(2, 2, 1)
plot(t1, y1, 'r.', 'linewidth', 3);
title('曲线1');

subplot(2, 2, 2)
plot(t2, y2, 'r.', 'linewidth', 3);
title('曲线2');

subplot(2, 2, 3)
plot(t1, y1, t2, y2, 'r:', 'linewidth', 3);
title('曲线3');

subplot(2, 2, 4)
plot(t1, y1, 'r.', t2, y2, 'b', t3, y3, 'bo', 'linewidth', 3);
title('曲线4');

%% 绘制衰减函数y = k*exp(-a*t).*sin(w*t);
clc;clear;close
a = 10;
w = 100;
t = (0:0.01:1)';
k =1000;
y1 = k*exp(-a*t)*[-1 1];
y = k*exp(-a*t).*sin(w*t);
[y_max, i_max] = max(y);
t_text = ['t=', num2str(t(i_max))];
y_text = ['y=', num2str(y_max)];
max_text = char('maximum', t_text, y_text);
tit = ['y=1000*exp(-', num2str(a), 't)*sin(', num2str(w),'t)'];
plot(t, zeros(size(t)), 'k', LineWidth=3)
hold on
plot(t, y, 'b', t, y1, 'r:', LineWidth=3)
plot(t(i_max), y_max, 'r.', 'MarkerSize', 20, LineWidth=3)
text(t(i_max)+0.3, y_max-100, max_text)
title(tit)
xlabel('t')
ylabel('y')

%% 用不同标度在同一坐标中绘制两种衰减电流波形(plotyy的使用)
clc;clear;close;
t1 = 0:pi/400:3*pi;
t2 = 0:pi/300:4*pi;
I1 = 7*exp(-2.5*t1).*sin(10*pi*t1);
I2 = 15*exp(-0.5*t2).*sin(5*pi*t2+pi/3);
plotyy(t1, I1, t2,I2);
grid on
title('不同标度在同一坐标中绘制曲线');
xlabel('时间t/s');
ylabel('电流I1/A和I2/A');

%% 添加标注性文字(text的使用)
clc;clear;close;
x = (0:pi/100:1.5*pi)';
y1 = 2*exp(-1.5*x)*[-1 1];
x1 = (0:12)/2;
y2 = 2*exp(-1.5*x).*sin(5*pi*x);
y3 = 2*exp(-2.5*x1).*sin(10*pi*x1);
plot(x, y1, 'g:', LineWidth=3);
hold on 
plot(x, y2, 'b--', LineWidth=3);
plot(x1, y3, 'rp', LineWidth=3);
title('曲线及其包络线');
xlabel('数据X');
ylabel('数据Y');
text(0.6, 1, '包络线');
text(0.3, 0.5, '曲线y');
text(4, 0.2, '离散数据点');
legend('包络线', '曲线y', '数据离散点');
grid on 

%% 1.11.5 统计图形绘制方法举例 用条形图、阶梯图、杆图和填充图绘制函数
clc;clear;close;
x = 0:pi/20:2*pi;
y = 15*exp(-3.5*x);

subplot(2, 2, 1)
bar(x, y, 'g', 'LineWidth', 3);
title('bar(x,y,''g'')');
axis([0 2*pi 0 15]);

subplot(2, 2, 2)
stairs(x, y, 'b', 'LineWidth', 3);
title('stairs(x, y, ''b'')');
axis([0 2*pi 0 15]);

subplot(2, 2, 3)
stem(x, y, 'k', 'LineWidth', 3);
title('stem(x, y, ''k'')');
axis([0 2*pi 0 15]);

subplot(2, 2, 4)
fill(x, y, 'r', 'LineWidth', 3);
title('fill(x,y,''r'')');
axis([0 2*pi 0 15]);

%% 1.11.6 极、对数坐标图形绘制举例 绘制极坐标及对数坐标
clc;clear;close
theta = 0:0.01:10;
x = theta;
ro = sin(2*theta).*cos(2*theta);
figure(1)
polarplot(theta, ro, 'k', LineWidth=3);
y = 10*x.*x;
figure(2)
subplot(2, 2, 1)
plot(x, y, LineWidth=3);
title('plot(x,y)');
grid on
subplot(2, 2, 2)
semilogx(x, y, LineWidth=3);
title('semilogx(x,y)');
grid on
subplot(2, 2, 3)
semilogy(x, y, LineWidth=3);
title('semilogy(x,y)');
grid on
subplot(2,2,4)
loglog(x, y, LineWidth=3);
title('loglog(x,y)');
grid on

%% 从不同视点绘制多峰函数曲面(peaks)
clc;clear;close
subplot(2, 2, 1)
mesh(peaks)
view(-37.5, 30);
title('azimuth=-37.5,elevation=30')
subplot(2, 2, 2)
mesh(peaks)
view(0, 45);
title('azimuth=0,elevation=90')
subplot(2, 2, 3)
mesh(peaks)
view(45, 0);
title('azimuth=90,elevation=0')
subplot(2, 2, 4)
mesh(peaks)
view(-8, -15);
title('azimuth=-7,elevation=-10')

%% 1.11.7 图形着色方法举例

%% 三种图形着色方案
clc;clear;close
z = peaks(20);
colormap("jet");
subplot(1, 3, 1)
surf(z);
view([-46, 24]);
subplot(1, 3, 2)
surf(z);
view([-46, 24]);
shading flat;
subplot(1, 3, 3)
surf(z);
view([-46, 24]);
shading interp;
title('3种图形着色方法的效果展示')

%% 光照处理后的多峰函数曲面
z = peaks(30);
subplot(1, 2, 1)
surf(z)
light('Posi', [0 30 10]);
shading interp
hold on
plot3(0 ,30,10,'p');
view([-43, 24]);
text(0, 30, 10, 'light');
subplot(1, 2, 2)
surf(z)
light('Posi', [30, 0, 10]);
shading interp
hold on 
plot3(30, 0, 10 ,'p')
view([-46, 24]);
text(30, 0 ,10, 'light');
title('光照处理后的多峰函数曲面')