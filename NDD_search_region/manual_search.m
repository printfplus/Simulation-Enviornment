function [nowval,nowx] = manual_search(x,table,x_label,y_label)

range_num = x(1);
range_rate_num = x(2);
row = size(table,1);
col = size(table,2);
nowval = table(range_num,range_rate_num)*value_function([x_label(range_num),y_label(range_rate_num)]);
nowx = [range_num,range_rate_num];
for i = -1:1
    for j = -1:1
        if range_num+i>0 && range_num+i<=row && range_rate_num+j >0 && range_rate_num+j<=col
            newval = table(range_num+i,range_rate_num+j)*value_function([x_label(range_num+i),y_label(range_rate_num+j)]);
            if newval > nowval
                nowval = newval;
                nowx = [range_num+i,range_rate_num+j];
            end
        end
    end
end
end

