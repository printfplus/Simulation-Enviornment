[x_label,y_label,~] = table_read(csvread('6-11cutin_table.csv'));
value_table = csvread('value_table.csv');
sum(sum(value_table))
possi_list = [];
for i = 1:size(value_table,1)
    for j = 1:size(value_table,2)
        if value_table(i,j) ~= 0
            possi_list = [possi_list,value_table(i,j)];
        end
    end
end
possi_list = sort(possi_list,'descend');
possi_gate = 1/(size(value_table,1)*size(value_table,2));
plot(possi_list);
possi_gate_list = possi_gate*ones(size(possi_list));
hold on;
plot(possi_gate_list);



            

