clc; clear; close all

% Adding path to sub folders
addpath('./records');

% 1. 定义文件名
inputFileName = 'H1.mat';  % 输入的 .mat 文件名
outputFileName = './records/H1_double.mat'; % 输出的 .mat 文件名

% 2. 加载 .mat 文件中的所有变量
data = load(inputFileName);

% 检查加载的变量
disp('Loaded variables:');
disp(fieldnames(data));  % 显示加载的变量名

% 假设你的矩阵名为 'FRF'、'frequencyBand' 和 'fs'
matrixName = 'FRF';
frequencyBandName = 'frequencyBand';
fsName = 'fs';

% 提取原始矩阵和 frequencyBand
originalMatrix = data.(matrixName);

% 检查 frequencyBand 是否存在，并提取
if isfield(data, frequencyBandName)
    frequencyBand = data.(frequencyBandName);
else
    error(['未找到变量 ''', frequencyBandName, '''。请检查 .mat 文件中是否存在此变量。']);
end

% 检查 fs 是否存在，并提取
if isfield(data, fsName)
    fs = data.(fsName);
else
    error(['未找到变量 ''', fsName, '''。请检查 .mat 文件中是否存在此变量。']);
end

% 4. 将 32x9 的矩阵扩展为 32x9x2
% 方法：复制原始矩阵并沿第三维度扩展
expandedMatrix = cat(3, originalMatrix, originalMatrix);

% 5. 将新矩阵、frequencyBand 和 fs 保存回 .mat 文件
FRF = expandedMatrix;  % 将 expandedMatrix 赋值给 FRF 变量
save(outputFileName, 'FRF', 'frequencyBand', 'fs');  % 保存 FRF、frequencyBand 和 fs

disp(['文件已保存为: ', outputFileName]);
