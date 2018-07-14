function [ table_search, table_value ] = NSeedFill( xgs, Thresh_SamP, table_search, table_value )

Parameter;

delt=[-1,1];
ori_tabel = Get_ID_X(xgs);
nsize = max(size(xgs));
tmp_tabel = ori_tabel;

for i=1:nsize
    
    for j=1:2
        
        % initial a new point; change 1-d
        tmp_tabel(i) = ori_tabel(i)+delt(j); 
        
        
        % check boundary: 0 inside.
        flag_bound = Check_Bound(tmp_tabel);

        
        if flag_bound==0
            
            % check if it has been searched: 0 not search
            flag_search = CheckTable( table_search, tmp_tabel );

            if flag_search==0 

                % update search table
                n_table_s = size(table_search,1) 
                table_search(n_table_s+1,:) = tmp_tabel;

                % get  point in real index
                tmp_x = Get_X(tmp_tabel);
                
                % calculate SamP
                SamP_tmp = Get_SamP(tmp_x);

                % judge the new point          
                if SamP_tmp > Thresh_SamP    
                    % add new point to valuable region
                    n_table_v = size(table_value, 1)
                    
                    table_value(n_table_v+1,:) = tmp_tabel;
                    [table_search, table_value] = NSeedFill( tmp_x, Thresh_SamP, table_search, table_value );                
                else

                end

            end     
            
            
        end
                       
    end
    
    
end






end

