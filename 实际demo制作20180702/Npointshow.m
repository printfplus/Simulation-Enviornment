value_table = csvread('value_table_new2.csv');
crash_possi = sum(sum(value_table));
value_table = value_table/sum(sum(value_table));
possi_list = [];
for i = 1:size(value_table,1)
    for j = 1:size(value_table,2)
        if value_table(i,j) ~= 0
            possi_list = [possi_list,value_table(i,j)];
        end
    end
end
possi_list = sort(possi_list,'descend');
plot(possi_list);
possi_gate = 1/(size(value_table,1)*size(value_table,2));
hold on;
line([possi_gate,0],[possi_gate,size(possi_list,2)]);
