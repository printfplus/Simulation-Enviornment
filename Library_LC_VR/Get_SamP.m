function [ SamP, Diff, P_NDD ] = Get_SamP( x )
% get the sampleing probability of the scenario x

Parameter;

% information 
x_B0 = zeros(N_BV,2);
u_B = zeros(N_BV,N);
for i=1:N_BV
    x_B0(i,:) = x( (i-1)*(N+2)+1 : (i-1)*(N+2)+2 );
    u_B(i,:) = x((i-1)*(N+2)+3:(i-1)*(N+2)+2+N);
end

Diff = Difficulty(x_B0, u_B, Vmax, Vmin, T, L, max_TTC, N_BV, N, delt_T);

mTTC = -Diff;
P_F_HV = 0;

% fail
if mTTC < Thresh_TTC
    P_F_HV = 1;
end

% get probability from NDD
P_NDD  = Get_P_NDD( x_B0, u_B );

SamP = P_NDD * P_F_HV / C_HV_F_Rate;

end

