function [complexVector, dt] = read_and_process_large_file(filename)
    % 打开文件
    fid = fopen(filename, 'r');
    if fid == -1
        error('无法打开文件: %s', filename);
    end
    
    % 初始化变量
    data = [];  % 用于存储最终的数据
    expectedNumCols = 6;  % 期望的列数为6
    dt = [];  % 初始化时间间隔
    maxCols = expectedNumCols;  % 用于跟踪最大列数
    
    % 逐行读取文件内容
    lineNum = 0;  % 用于跟踪行号
    while ~feof(fid)
        line = fgetl(fid);
        lineNum = lineNum + 1;
        
        % 在第9行提取时间间隔信息并跳过数据存储
        if lineNum == 9
            parsedValues = sscanf(line, '%f');
            if numel(parsedValues) >= 5
                dt = parsedValues(5);  % 第7行的第四个值为时间间隔
                % disp(['提取的时间间隔 dt: ', num2str(dt)]);
            else
                warning('未能在第9行提取到足够的数值，预期至少5个');
            end
            continue;  % 跳过这行数据的存储操作，继续处理下一行
        end
        
        % 跳过文件头和元数据部分
        if lineNum <= 9 || contains(line, 'NONE') || isempty(line) || line(1) == '-' || contains(line, 'Time') || contains(line, 'Input')
            continue;  % 跳过这些行，继续读取下一行
        end
        
        % 解析数值数据
        values = sscanf(line, '%f');
        
        % 检查是否需要更新最大列数
        if ~isempty(values) && numel(values) > maxCols
            maxCols = numel(values);
        end
        
        % 将每一行的数据存储到矩阵中，填充 NaN
        if ~isempty(values)
            if numel(values) < maxCols
                values = [values; NaN(maxCols - numel(values), 1)];  % 填充NaN
            end
            data = [data; values'];  % 存储数据行
        end
    end

    % 去除 data 矩阵末尾的 NaN 行
    if ~isempty(data)
        % 找到最后一个不包含 NaN 的行
        lastValidIndex = find(~any(isnan(data), 2), 1, 'last');
        
        % 删除包含 NaN 的尾部行
        if ~isempty(lastValidIndex)
            data = data(1:lastValidIndex, :);
        end
    end
    
    % 如果没有找到时间间隔，发出警告
    if isempty(dt)
        warning('未在文件中找到时间间隔信息，使用默认值');
        dt = 4.88281e-05;  % 默认时间间隔
    end
    
    if ~isempty(data)
        % 将 data 转换为列向量
        data = data(:);
    end
    
    % data 是交叉存储实部和虚部的向量
    % 提取实部 (奇数位置元素)
    realPart = data(1:2:end);

    % 提取虚部 (偶数位置元素)
    imagPart = data(2:2:end);

    % 将实部和虚部组合成复数向量
    complexVector = complex(realPart, imagPart);

    % 关闭文件
    fclose(fid);
end

