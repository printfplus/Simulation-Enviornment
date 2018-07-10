[x_label,y_label,possi_table] = table_read(csvread('6-11cutin_table.csv'));
possi = 0;
for i = 1:size(possi_table,1)
    for j = 1:size(possi_table,2)
        tmp_value = value_function([x_label(i),y_label(j)]);
        if tmp_value == 0
            possi = possi + possi_table(i,j);
        end
    end
end

        