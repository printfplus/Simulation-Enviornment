clear;
%clc;

nowdata = [];
%nowdata = csvread('region_data.csv');
global v1;
global v2;
global omega;
omega = 0.2;
v2 = 20;
global dt;
dt = 1;
global STEP;
STEP = 10;
global vmax;
global vmin;
vmax = 40;
vmin = 0;
global C;
global Pb;
Pb = 0.03;
global x_label;
global y_label;
global table;

table = csvread('possibility_table.csv');


[x_label,y_label,table] = table_read(table);



range = 60;
range_rate = -10;
range_lb = 3;
range_ub = 96;
range_rate_lb = -19.8;
range_rate_ub = -4;

x0 = [range,range_rate];

LB = [range_lb,range_rate_lb];
UB = [range_ub,range_rate_ub];


handle = @value_function;
problem = createOptimProblem('fmincon','x0',x0,'objective',handle,...
    'lb',LB,'ub',UB,'Aineq',[],'bineq',[], 'Aeq',[], 'beq',[],'options',optimset('Algorithm','SQP','Disp','none'));
gs = GlobalSearch('FunctionTolerance',10);
[xgs_best,fval_best] = run(gs,problem);


value_table = table;
value_table(:,:) = 0;

for i = 1:50
    %[xgs,fval] = run(gs,problem);
    randrange = randi([range_lb,range_ub],1,1);
    rangerangerate = -randi([abs(round((range_rate_ub))),abs(round(range_rate_lb))],1,1);
    x0 = [randrange,rangerangerate];
    [xgs,fval] = fmincon(handle,x0,[],[],[],[],LB,UB);
    xgs = [find_num(xgs(1),x_label),find_num(xgs(2),y_label)];
    value_table = manshui(xgs(1),xgs(2),value_table);
end
%csvwrite('region_data.csv',nowdata)
[x,y] = meshgrid(x_label,y_label);
imagesc(y_label,x_label,value_table);
csvwrite('value_table_new2.csv',value_table);
colorbar;
f = value_function(xgs);

