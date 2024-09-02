clear; clc; close all;

%% read FFT file
% Adding path to sub folders
addpath('./records');

% 1. 定义文件名
filename1 = 'H(E_R)1_+Z,9_+Z(f).uff';  % 文件名
filename2 = 'H(E_R)1_+Z,10_+Z(f).uff';  % 文件名
outputFileName = './records/H1.mat'; % 输出的 .mat 文件名

% 调用读取和处理函数，将数据读取为列向量
[data1, df1] = read_and_process_large_file(filename1);
[data2, df2] = read_and_process_large_file(filename2);

% 获取数据点的数量
n1 = length(data1);
n2 = length(data2);

% 生成频率轴
f1 = (0:n1-1) * df1;  % 频率轴
f2 = (0:n2-1) * df2;  % 频率轴

%% merge into one
FRF = cat(2, data1, data2);
frequencyBand = f1';

% Save FRF and frequencyBand to a .mat file
save(outputFileName, 'FRF', 'frequencyBand');
