function [ P_NDD ] = Get_P_NDD( x_B0, u_B )
% get probability of scenario x from NDD

Parameter;
load('Dis_CF.mat');
load('Dis_FF.mat');

BV = Get_BV(x_B0, u_B);

P_NDD = 1;

% initial location of the last vehicle
P_NDD = P_NDD * 1 / (2*L/dis_R);

% initial Velocity, Range, Range Rate, Acceleration
sum_Ini = sum(Ini_CF_M(:));

for i=1:N_BV-1
    
    ini_R = x_B0(i+1,1)-x_B0(i,1);
    id_R = getID( ini_R, R );
    
    id_V = getID( x_B0(i,2), V );
    
    ini_RR = x_B0(i+1,2)-x_B0(i,2);
    id_RR = getID( ini_RR, RR );
    
    if id_R < 0 || id_V <0 || id_RR<0
        P_NDD = P_NDD * 0;
        break;
    else
        P_NDD = P_NDD * Ini_CF_M(id_V, id_R, id_RR) / sum_Ini;
    end
    

    for j=1:N
        
        % acceleration of CF
        id_U = getID( u_B(i,j),U );
        if id_U <0 || id_R < 0 || id_V <0 || id_RR<0
            P_NDD = P_NDD * 0;
            break;
        else
            sum_U = sum( Dis_CF_M(id_V, id_R, id_RR, :) );
            if sum_U ~= 0
                P_NDD = P_NDD * Dis_CF_M(id_V, id_R, id_RR, id_U) / sum_U;
            else
                % no data
                P_NDD = P_NDD * 0;
            end
            
        end
        
        % update BV
        R_new = BV{i+1}(1,j+1) - BV{i}(1,j+1);
        id_R = getID( R_new, R );
        
        id_V = getID( BV{i}(2,j+1), V );
        
        RR_new = BV{i+1}(2,j+1) - BV{i+1}(2,j+1);
        id_RR = getID( RR_new, RR );
        
    end

end

% acceleration of FF
i = N_BV;
for j=1:N
    id_V = getID(BV{i}(2,j),V);
    id_U = getID(u_B(i,j), U);
    if id_U <0 || id_V<0
        P_NDD = P_NDD * 0;
        break;
    else
        sum_U = sum( Dis_FF(id_V, :) );
        P_NDD = P_NDD * Dis_FF(id_V, id_U) / sum_U;
    end

end


end

