NDD_table = csvread('CUT_IN_data.csv');
item_num = size(NDD_table,1);
test_time = 10000;
collision_time = 0;
collision_rate_list = [];
[x_label,y_label,possi_table] = table_read(csvread('6-11cutin_table.csv'));
possi = 0;
for i = 1:test_time
    i
    test_item = randi(item_num);
    [test_range,test_range_rate] = sampling_using_NDD_value_region();
    %test_data = NDD_table(test_item,:);
    %test_range = test_data(1);
    %test_range_rate = test_data(2);
    range_num = find_num(test_range,x_label);
    range_rate_num = find_num(test_range_rate,y_label);
    my_possi = possi_table(range_num,range_rate_num);
    test_value = value_function([test_range,test_range_rate]);
    if test_value == 0
        tmp_possi = 1;
    else
        tmp_possi = 0;
    end
    possi = (possi*(i-1)+tmp_possi*8.53e-04)/i;
    %possi = (possi*(i-1)+tmp_possi)/i;
    collision_rate_list = [collision_rate_list,possi];
end
plot(collision_rate_list);
ylim([0 0.001]);

    