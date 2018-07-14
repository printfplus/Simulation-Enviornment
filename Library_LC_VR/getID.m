function [ ID ] = getID( value, vector )
% get the ID of the value in the vector

flag = 0;
n = max(size(vector));
for i=1:n-1
    if vector(i)<=value && value<vector(i+1)
        ID = i;
        flag = 1; % find the ID
        break;
    end
end
if flag==0 % not find ID
    if vector(n)==value
        ID = n;
    else
        % cannot find the ID
        % fail
        ID = -1;
    end
end

end

