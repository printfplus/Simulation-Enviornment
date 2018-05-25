function [f] = matrix_process(matrix)
    global C;
    global Pb;
    value = sum(sum(matrix));
    %C = value/Pb;
    C = 0.9;
    f = matrix*C/value;
    [row,col] = find(f == 0);
    num = size(row,1);
    value = sum(sum(f));
    for i = 1:num
        f(row(i),col(i)) = (1-C)/num;
    end
    %value = sum(sum(f))
end