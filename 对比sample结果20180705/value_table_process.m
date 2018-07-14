value_table = csvread('value_table_FVDM.csv');
possi = sum(sum(value_table));
delta = 0.3;
value_table = value_table*(1-delta)/possi;
value_region_num = 0;
for i = 1:size(value_table,1)
    for j = 1:size(value_table,2)
        if value_table(i,j) ~= 0
            value_region_num = value_region_num+1;
        end
    end
end
whole_num = size(value_table,1)*size(value_table,2);
left_num = whole_num - value_region_num;
left_possi = delta/left_num;
for i = 1:size(value_table,1)
    for j = 1:size(value_table,2)
        if value_table(i,j) == 0
            value_table(i,j) = left_possi;
        end
    end
end
sum(sum(value_table));
csvwrite('delta0.3_value_table.csv',value_table);