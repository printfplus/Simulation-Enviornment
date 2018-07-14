function [ BV ] = Get_BV( x_B0, u_B )
% get the trajectoris of BV

Parameter;

BV = cell(1,N_BV);
for i=1:N_BV
    BV{i}(:,1) = x_B0(i,:)';
    j=1;
    for t=delt_T:delt_T:T
        j = j + 1;
        BV{i}(2,j) = BV{i}(2,j-1) + u_B(i,j-1) * delt_T;
        BV{i}(1,j) = BV{i}(1,j-1) + BV{i}(2,j-1) * delt_T + 0.5 * u_B(i,j-1) * delt_T^2;
    end

end


end

