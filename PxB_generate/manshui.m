function [table] = manshui(x,y,table)
    global x_label;
    global y_label;
    xsize = max(size(x_label));
    ysize = max(size(y_label));
    for i = -1:1
        for j = -1:1
            tmpx = x+i;
            tmpy = y+j;
            if tmpx > 0 && tmpx <= xsize && tmpy > 0 && tmpy<ysize
                if value_function([x_label(tmpx),y_label(tmpy)]) == 0 && table(tmpx,tmpy) == 0
                    table(tmpx,tmpy) = 1;
                    table = manshui(tmpx,tmpy,table);
                end
            end
        end
    end
end
