clear;
%clc;

global v1;
global v2;
global omega;
omega = 10;
v2 = 20;
global dt;
dt = 1;
global STEP;
STEP = 10;
global vmax;
global vmin;
vmax = 40;
vmin = 0;

range = 100;
range_rate = 0;
range_lb = 0;
range_ub = 100;
range_rate_lb = -20;
range_rate_ub = 20;

x0 = [range,range_rate];

LB = [range_lb,range_rate_lb];
UB = [range_ub,range_rate_ub];


handle = @value_function;
problem = createOptimProblem('fmincon','x0',x0,'objective',handle,...
    'lb',LB,'ub',UB,'Aineq',[],'bineq',[], 'Aeq',[], 'beq',[],'options',optimset('Algorithm','SQP','Disp','none'));
gs = GlobalSearch;
xgs = run(gs,problem);
f = value_function(xgs)

