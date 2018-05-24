function [val] = temp_value_function(range_value,range_rate_value)
global v1;
global v2;
global omega;
omega = 0.2;
v2 = 20;
global dt;
dt = 1;
global STEP;
STEP = 10;
global vmax;
global vmin;
vmax = 40;
vmin = 0;
global C;
global Pb;
Pb = 0.03;
possibility_table = csvread('cutindata_biginterval.csv');
y_label = possibility_table(1,:);
y_label(1) = [];
possibility_table(1,:) = [];
x_label = possibility_table(:,1);
possibility_table(:,1) = [];
range_num = 0;
range_rate_num = 0;
for i = 1:size(x_label,1)
    if range_value < x_label(i)
        range_num = i;
        break;
    end
end

for i = 1:size(y_label,2)
    if range_rate_value < y_label(i)
        range_rate_num = i;
        break;
    end
end

val = possibility_table(range_num,range_rate_num)*value_function([range_value,range_rate_value]);