function [ flag ] = CheckTable( table_search, tmp )
% return: 1 if the tmp has been checked; 0 if the tmp has not been checked
% yet

[m,n] = size(table_search);

flag = 0;
for i=1:m
    
    for j=1:n
        if table_search(i,j) ~= tmp(j)
            break;
        end
        if j==n
            flag = 1;
        end
    end
    
    if flag == 1
        break;
    end
    
end


end

