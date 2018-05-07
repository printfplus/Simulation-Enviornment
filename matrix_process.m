function [f] = matrix_process(matrix)
    value = sum(sum(matrix));
    f = 0.9*matrix/value;
    [row,col] = find(f == 0);
    num = size(row,1);
    for i = 1:num
        f(row(i),col(i)) = 1/num;
    end
end