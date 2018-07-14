
[x_label,y_label,table] = table_read(csvread('6-11cutin_table.csv'));
table = csvread('delta0.3_value_table.csv');
table = table/sum(sum(table));
imagesc(table);
figure;
newtable = zeros(size(table));
range = 60;
range_rate = 10;
range_num = find_num(range,x_label);
range_rate_num = find_num(range_rate,y_label);
sampling_length = 1000000;
value_library = zeros(sampling_length,2);
num_library = zeros(sampling_length,2);
for i = 1:sampling_length
    for axis = 1:2
        if axis == 1
            col = table(:,range_rate_num);
            colpossi = sum(col);
            mypossi = colpossi*rand();
            sumpossi = 0;
            for j = 1:max(size(col))
                sumpossi = sumpossi+col(j);
                if sumpossi >= mypossi
                    range_num = j;
                    break;
                end
            end
        else
            row = table(range_num,:);
            rowpossi = sum(row);
            mypossi = rowpossi*rand();
            sumpossi = 0;
            for j = 1:max(size(row))
                sumpossi = sumpossi + row(j);
                if sumpossi >= mypossi
                    range_rate_num = j;
                    break;
                end
            end
        end
        
    end
    num_library(i,1) = range_num;
    num_library(i,2) = range_rate_num;
    value_library(i,1) = x_label(range_num);
    value_library(i,2) = y_label(range_rate_num);
end

for i = 1:size(num_library,1)
    newtable(num_library(i,1),num_library(i,2)) = newtable(num_library(i,1),num_library(i,2))+1;
end
newtable = newtable/sum(sum(newtable));
imagesc(newtable);
figure;
wtable = newtable-table;
imagesc(newtable-table);
save('value_region_library','value_library');



