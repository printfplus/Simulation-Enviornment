function [range,range_rate] = sampling_using_NDD()

global x_label;
global y_label;
[x_label,y_label,table] = table_read(csvread('6-11cutin_table.csv'));
global sampling_x0;

load('NDD_sample_para.mat');
now_range = sampling_x0(1);
now_range_rate = sampling_x0(2);
range_num = find_num(now_range,x_label);
range_rate_num = find_num(now_range_rate,y_label);
for axis = 1:2
    if axis == 1
        col = table(:,range_rate_num);
        colpossi = sum(col);
        mypossi = colpossi*rand();
        sumpossi = 0;
        for i = 1:max(size(col))
            sumpossi = sumpossi+col(i);
            if sumpossi >= mypossi
                next_range_num = i;
                break;
            end
        end
    else
        row = table(next_range_num,:);
        rowpossi = sum(row);
        mypossi = rowpossi*rand();
        sumpossi = 0;
        for i = 1:max(size(row))
            sumpossi = sumpossi + row(i);
            if sumpossi >= mypossi
                next_range_rate_num = i;
                break;
            end
        end
    end
    
end
range = x_label(next_range_num);
range_rate = y_label(next_range_rate_num);
sampling_x0 = [range,range_rate];
save('NDD_sample_para.mat','sampling_x0');                      
end

