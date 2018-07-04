clear;
clc;
[range_label,range_rate_label,mytable] = table_read(csvread('6-11cutin_table.csv'));
newtable = reshape(mytable,1,3420);
newtable = sort(newtable,'DESCEND');
imagesc(mytable);
for i = 1:3420
    if newtable(i) < 1/(3420-i)
        mypossi = newtable(i);
        break;
    end
end
for i = 1:size(mytable,1)
    for j = 1:size(mytable,2)
        if mytable(i,j) > mypossi
            mytable(i,j) = 1;
        end
    end
end
figure;
imagesc(mytable);