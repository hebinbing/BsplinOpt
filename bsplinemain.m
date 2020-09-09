%b����ʵ��
clc;clear;close all;
path = ginput() * 100.0;
% ʵ��һ
% path =[8 5;7 15;2 10;11 10;11 14;45 30;45 12;25 45;12 45; 25 25];

% ʵ���
% path =[0 50;100 0;250 140;400 0;475 75];

controlPointX = path(:,1)';
controlPointY = path(:,2)';
subplot(2,2,1);
plot(controlPointX, controlPointY , 'Color', [1.0 0 0], 'LineWidth', 1);
hold on
plot(controlPointX, controlPointY , 'k.','MarkerSize', 20);
title('ԭʼ·����');

% [Lmin, ~] = getLAngel(path);
%˼����Դ��Continuous Path Smoothing for Car-Like Robots Using B-Spline Curves
%B����ƽ��������ԭʼ·����������ʡ����ߵ���С�нǣ����ƽ��B�����Ŀ��Ƶ�
%�������
kMax =0.6;
%��С�н�
alphaMin = deg2rad(55); %���ȱ�ʾ
% alphaMin = getMinAngel(kMax, Lmin);
%���
Lmin =1/(6*kMax)*sin(alphaMin)*((1-cos(alphaMin))/8)^(-1.5);
%��ȡƽ����Ŀ��Ƶ�
boundPath = getSmoothPath(path, kMax,alphaMin);
subplot(2,2,2);
plot(boundPath(:,1), boundPath(:,2) , 'Color', [0 0 1.0], 'LineWidth', 2);
hold on
plot(boundPath(:,1), boundPath(:,2), 'ko','MarkerSize', 5);
title('ƽ����·����');

m = length(boundPath) + 3 + 1;
kv = linspace(0,1,m-6);
kv =[0 0 0 kv 1 1 1];
%deboor
[X,Y] = BSpline(3,boundPath, kv);
subplot(2,2,3);
plot(X', Y' , 'Color', [1 0 0], 'LineWidth', 2);
hold on
plot(boundPath(1:end,1), boundPath(1:end,2) , 'Color', [0 0 1], 'LineWidth', 1);
plot(boundPath(1:end,1), boundPath(1:end,2) , 'ko','MarkerSize', 5);
title('��������Լ��');

subplot(2,2,4);
[s, cur] = getBsplineCur(3,boundPath,kv);
plot(s, cur, 'Color',[255 128 0]/255, 'LineWidth', 1);
title('����');

