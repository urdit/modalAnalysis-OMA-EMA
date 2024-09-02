function saveFRFtoMat(filename1, filename2, outputFileName)
    % saveFRFtoMat 读取两个UFF文件，将其数据合并并保存为一个.mat文件
    %
    % 输入参数:
    %   filename1 - 第一个UFF文件的路径
    %   filename2 - 第二个UFF文件的路径
    %   outputFileName - 输出的.mat文件的路径
    %
    % 示例用法:
    %   saveFRFtoMat('file1.uff', 'file2.uff', 'output.mat');

    % 添加路径
    addpath('./records');

    % 调用读取和处理函数，将数据读取为列向量
    [data1, dt1] = read_and_process_large_file(filename1);
    [data2, dt2] = read_and_process_large_file(filename2);

    % 获取数据点的数量
    n1 = length(data1);
    n2 = length(data2);

    % 生成频率轴
    f1 = (0:n1-1) * dt1;  % 频率轴
    f2 = (0:n2-1) * dt2;  % 频率轴

    % 计算采样率
    fs = 1/dt1;

    % 合并数据
    FRF = cat(2, data1, data2);
    frequencyBand = f1';

    % 保存FRF和frequencyBand到.mat文件
    save(outputFileName, 'FRF', 'frequencyBand', 'fs');

    % 输出提示信息
    fprintf('Data saved successfully to %s\n', outputFileName);
end
