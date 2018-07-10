function [crash_flag,value] = mytest(data_source,algorithm)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
x = [];
if data_source == 'NDD'
    [a,b] = sampling_using_NDD_value_region();
    x = [a,b];
    value = value_function_d(x,algorithm);
    if value == 0
        crash_flag = 1;
    else
        crash_flag = 0;
    end
end

