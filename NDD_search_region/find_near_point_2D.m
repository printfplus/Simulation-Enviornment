function  point_list = find_near_pint_2D(input,table)

    row = size(table,1);
    col = size(table,2);
    point_list = [];
    x = input(1);
    y = input(2);
    for i = -1:1
        for j = -1:1
            nowx = x+i;
            nowy = y+j;
            if nowx > 0 && nowx <= row && nowy > 0 && nowy <= col
                if table(nowx,nowy) == 0
                    point_list = [point_list;[nowx,nowy,value_function([nowx,nowy])]];
                end
            end
        end
    end

end