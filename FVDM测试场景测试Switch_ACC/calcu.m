clear;
clc;
possi = 0;
[x_label,y_label,possi_table] = table_read(csvread('6-11cutin_table.csv'));
mytable = zeros(size(possi_table));
for i = 1:size(possi_table,1)
    for j = 1:size(possi_table,2)
        if i == 26 && j == 33
        end
        if value_function_Switch_ACC([x_label(i),y_label(j)]) == 0
            mytable(i,j) = 1;
            possi = possi+possi_table(i,j);
        end
    end
end
imagesc(y_label,x_label,mytable);

        
