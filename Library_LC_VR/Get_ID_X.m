function [ x_ID ] = Get_ID_X( x )
%get ID of x
Parameter;
n = max(size(x));
x_ID = zeros(1,n);
index_x = N+3;
index_v = N+4;
for i=1:n
    switch i
        case 1 
            x_ID(i) = getID(x(i),X);
        case 2 
            x_ID(i) = getID(x(i),V);
        case index_x
            x_ID(i) = getID(x(i),X);
        case index_v
            x_ID(i) = getID(x(i),V);
        otherwise
            x_ID(i) = getID(x(i),U);
    end
    
end


end

