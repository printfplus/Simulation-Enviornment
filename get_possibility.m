function [p,xnum,ynum] = get_possibility(sample,table)
    x = sample(1);
    y = sample(2);
    %table = csvread('value_table_new.csv');
    xnum = round(x/2)+1;
    ynum = abs(round(y/0.4))+1;
    if xnum <= size(table,1) && ynum <=size(table,2)
        p = table(xnum,ynum);
    else
        p = 0;
    end
end
