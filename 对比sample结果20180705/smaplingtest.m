[xlabel,ylabel,mytable] = table_read(csvread('6-11cutin_table.csv'));
mytable(:,:) = 0;
for i = 1:10000
    i
    [tmp_range,tmp_range_rate] = sampling_using_NDD();
    tmp_range_num = find_num(tmp_range,xlabel);
    tmp_range_rate_num = find_num(tmp_range_rate,ylabel);
    mytable(tmp_range_num,tmp_range_rate_num) = mytable(tmp_range_num,tmp_range_rate_num)+1;
end
mytable = mytable/sum(sum(mytable));
imagesc(mytable);
[xlabel,ylabel,newtable] = table_read(csvread('6-11cutin_table.csv'));
wtable = newtable-mytable;

    