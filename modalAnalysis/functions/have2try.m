clear; clc; close all;

%% read FFT file
filename1 = 'H(E_R)1_+Z,9_+Z(f).uff';  % 文件名
filename2 = 'H(E_R)1_+Z,10_+Z(f).uff';  % 文件名

% 调用读取和处理函数，将数据读取为列向量
[data1, df1] = read_and_process_large_file(filename1);
[data2, df2] = read_and_process_large_file(filename2);

% 获取数据点的数量
n1 = length(data1);
n2 = length(data2);

% 生成频率轴
f1 = (0:n1-1) * df1;  % 频率轴
f2 = (0:n2-1) * df2;  % 频率轴

% merge into one
FRF = cat(2, data1, data2);
frequencyBand = f1';

% % 截取4000Hz以下的频率成分
% idx = f <= 4000;  % 找到频率小于等于4000 Hz的索引
% f = f(idx);  % 只保留4000 Hz以下的频率
% magnitude = abs(data(idx));  % 只保留4000 Hz以下的幅值
% phase = angle(data(idx));  % 只保留4000 Hz以下的相位

% %% plot FFT: amplitude & phase
% % 创建一个图形窗口，包含两个子图
% figure;
% 
% % 绘制幅值（对数尺度）
% subplot(2, 1, 1);  % 创建第一个子图
% semilogx(f, 20*log10(magnitude));  % 幅值转为dB
% xlabel('Frequency (Hz)');
% ylabel('Magnitude (dB)');
% title('FRF Magnitude Spectrum (0-4000 Hz, Log Scale)');
% grid on;
% 
% % 绘制相位
% subplot(2, 1, 2);  % 创建第二个子图
% semilogx(f, phase * (180/pi));  % 相位转为度 (degrees)
% xlabel('Frequency (Hz)');
% ylabel('Phase (degrees)');
% title('FRF Phase Spectrum (0-4000 Hz, Log Scale)');
% grid on;
% 


