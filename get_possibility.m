function p = get_possibility(sample,table)
while(1)
    x = sample(1);
    y = sample(2);
    %table = csvread('value_table_new.csv');
    xnum = min(round(x/2)+1,size(table,1));
    ynum = min(abs(round(y/0.4))+1,size(table,2));
    if xnum <= size(table,1) && ynum <=size(table,2)
        p = table(xnum,ynum);
        break;
    end
end

