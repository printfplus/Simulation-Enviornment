function [flag_bound] = Check_Bound(tmp_tabel)
% check bound of tem_table
% 0: inside the bound

Parameter;
nsize = max(size(tmp_tabel));
flag_bound = 0;
index_x = N+3;
index_v = N+4;
for i=1:nsize

    switch i
        case 1
            if tmp_tabel(i) > max(size(X)) ||  tmp_tabel(i) < 1
                flag_bound = 1;
            end
        case index_x
            if tmp_tabel(i) > max(size(X)) ||  tmp_tabel(i) < 1
                flag_bound = 1;
            end
        case 2
            if tmp_tabel(i) > max(size(V)) ||  tmp_tabel(i) < 1
                flag_bound = 1;
            end
        case index_v
            if tmp_tabel(i) > max(size(V)) ||  tmp_tabel(i) < 1
                flag_bound = 1;
            end
        otherwise
            if tmp_tabel(i) > max(size(U)) || tmp_tabel(i) < 1
                flag_bound = 1;
            end
    end

end


end

