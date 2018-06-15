function [p,xnum,ynum] = get_possibility(sample,table)
    x = sample(1);
    y = sample(2);
    global xlabel;
    global ylabel;
    %table = csvread('value_table_new.csv');
    xnum = find_num(x,xlabel);
    ynum = find_num(y,ylabel);
    if xnum <= size(table,1) && ynum <=size(table,2)
        p = table(xnum,ynum);
    else
        p = 0;
    end
end
