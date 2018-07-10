function table = final_process(table,possi_table)
for i = 1:size(table,1)
    for j = 1:size(table,2)
        if table(i,j) == 1
            table(i,j) = possi_table(i,j);
        end
    end
end
wholesum = sum(sum(table));
table = 0.9*table/wholesum;
num = sum(sum(table == 0));
for i = 1:size(table,1)
    for j = 1:size(table,2)
        if table(i,j) == 0
            table(i,j) = 0.1/num;
        end
    end
end
