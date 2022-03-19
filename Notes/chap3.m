% ========================================================================
% 李维波教授《MATLAB在电气工程中的应用学习笔记
% 第三章 MATLAB软件的程序设计方法 
% by Vico Zhang, 2022/3/19
% ------------------------------------------------------------------------
% version-1.0-2022/3/19 : 第一部分程序录入，并对错误程序进行了修改
% ------------------------------------------------------------------------
% 运行时需要以节为单位运行
% ========================================================================

%% 3.5.3 计算传感器的温漂 fprintf使用
clc,clear;
t = input('环境温度值:\n');
if t <10
    u=t*t+5;
elseif t>10 && t<20
    u=t*t-50;
else
    u=t^2-2*t+50;
end
fprintf('电压传感器温漂/uV:%g\n',u);

%% 磁路的电感曲线
clc;clear;close
Ac=9;
Ag=9;
lc=30;
N=500;
mu0=4*pi*1e-7;
mur=7e4;
Rc=lc/(mur*mu0*Ac);

for n = 1:100
    g(n) = n/100;
    Rg(n) = g(n)/(mu0*Ag);
    Rtpt = Rc+Rg(n);
    L(n) = N^2/Rtpt;
end

plot(g, L, 'r', LineWidth=2);
ylabel('磁路电感L/H');
xlabel('空气隙长度g/cm');
title('磁路的电感随着空气隙长度的变化')
grid on;

%% 电动机机械转矩与转速函数曲线
clc;clear;close;
V1 = 230/sqrt(3);
nph = 3;
poles = 4;
fe = 50;
R1 = 0.095; X1 = 0.680; X2 = 0.672; Xm = 18.7;
omegas = 4*pi*fe/poles;
ns = 120*fe/poles;
Zleq = 1i*Xm*(R1+1j*X1)/(R1+1i*(X1+Xm));
Rleq = real(Zleq);
Xleq = imag(Zleq);
Vleq = abs(V1*1j*Xm/(R1+1j*(X1+Xm)));
for m =1:6
    if m==1
        R2 = 0.1;
    elseif m==2
        R2 = 0.2;
    elseif m==3
        R2 = 0.5;
    elseif m==4
        R2 = 1.0;
    elseif m ==5
        R2 = 1.5;
    elseif m ==6
        R2 = 2;
    end
    for n = 1:200
        s(n) = n/200;
        rpm(n) = ns*(1-s(n));
        I2 = abs(Vleq/(Zleq+1j*X2+R2/s(n)));
        Tmech(n) = nph*I2^2*R2/(s(n)*omegas);
    end
    plot(rpm, Tmech, 'k', 'linewidth',2);
    if m == 1
        hold
    end
end
grid on
xlabel('转速r/rpm')
ylabel('机械转矩Tmech/N')
title('电动机的机械转矩Tmech作以r/min为单位时转子转速的变化曲线')

%% 偶极子的电势和电场强度分析
clc;clear;close
q = 2e-6; k =9e9; a =1.5; b =-1.5;
x = -6:0.6:6; y=x;
[X,Y] = meshgrid(x,y);
rp = sqrt((X-a).^2+(Y-b).^2);
rm = sqrt((X+a).^2+(Y+b).^2);
V = q*k*(1./rp-1./rm);
[Ex,Ey] = gradient(-V);
AE = sqrt(Ex.^2+Ey.^2);
Ex = Ex./AE;
Ey = Ey./AE;
minv = min(min(V)); maxv = max(max(V));
cv = linspace(minv, maxv,49);
contourf(X,Y,V,cv,'k-');
axis('square');
title('偶极子的电场示意图');
hold on
quiver(X,Y,Ex,Ey,0.7);
plot(a,b,'ro', a,b,'r+',LineWidth=3);
plot(-a,-b,'yo',-a,-b,'y-','LineWidth',3)
xlabel('x')
ylabel('y')
hold off
