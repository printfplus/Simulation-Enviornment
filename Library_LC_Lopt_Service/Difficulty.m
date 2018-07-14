function [ diff, y ] = Difficulty(x_B0, u_B, Vmax, Vmin, T, L, max_TTC, N_BV, N, delt_T)
% P_B, v_B: position and velocity of the background vehicle.


% optimization (t, y)

x0 = [T/2; T/2*15];
%x0 = [0; 0];
LB = [0; 0];
UB = [T; L];

A_Diff = [-Vmax, 1; Vmin, -1];
B_Diff = [0; 0];


% search max TTC namely min -TTC
handle = @(x)my_fitness_NBV_2L(x,Vmax, Vmin, max_TTC, N_BV,x_B0,u_B, N, delt_T);
problem = createOptimProblem('fmincon','x0',x0,'objective',handle,...
    'lb',LB,'ub',UB,'Aineq',A_Diff,'bineq', B_Diff, 'Aeq',[], 'beq',[],'options',optimset('Algorithm','SQP','Disp','none'));
% gs = GlobalSearch;
% xgs = run(gs,problem); 
% now_val = my_fitness_NBV_2L(xgs);

ms = MultiStart;
[xgs,now_val] = run(ms,problem,10);


% now_val = min-TTC largest TTC the easiest point
% diff = now_val
% less TTC larger diff
% large -TTC, large diff
diff = now_val;
y = xgs;
end

