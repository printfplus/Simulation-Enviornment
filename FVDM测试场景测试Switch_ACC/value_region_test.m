clear;
clc;
load('value_region_library.mat');
%possi_table = csvread('6-11cutin_table.csv');
value_table = csvread('delta0.3_value_table.csv');
value_table = value_table/sum(sum(value_table));
%load('NDD_library.mat');
%value_library = csvread('CUT_IN_data.csv');
item_num = size(value_library,1);
test_time = 100000;
collision_time = 0;
collision_rate_list = [];
[x_label,y_label,possi_table] = table_read(csvread('6-11cutin_table.csv'));
possi = 0;
for i = 1:test_time
    i 
    test_item = randi(item_num); 
    test_data = value_library(test_item,:);
    test_range = test_data(1);
    test_range_rate = test_data(2);
    range_num = find_num(test_range,x_label);
    range_rate_num = find_num(test_range_rate,y_label);
    my_possi = possi_table(range_num,range_rate_num);
    test_value = value_function_Switch_ACC([test_range,test_range_rate]);
    if test_value == 0
        tmp_possi = 1;
    else
        tmp_possi = 0;
    end
    possi = (possi*(i-1)+tmp_possi*my_possi/value_table(range_num,range_rate_num))/i;
    collision_rate_list = [collision_rate_list,possi];
end
plot(collision_rate_list);
save('delta0.3_collision_list.mat','collision_rate_list');

     