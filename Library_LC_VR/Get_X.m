function x = Get_X(tmp_tabel)
% get real value of scenario x from tabel

Parameter;
nsize = max(size(tmp_tabel));
x = zeros(1,nsize);
index_x = N+3;
index_v = N+4;
for i=1:nsize

    switch i
        case 1
            x(i) = X(tmp_tabel(i));
        case index_x
            x(i) = X(tmp_tabel(i));
        case 2 
            x(i) = V(tmp_tabel(i));
        case index_v
            x(i) = V(tmp_tabel(i));      
        otherwise
            x(i) = U(tmp_tabel(i));
    end

end

end

