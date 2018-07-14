clear;
clc;
global crash_possi;
crash_possi = 2.430000000000000e-06;
global gate_num;
gate_num = 0;
global possi_gate;
possi_gate = 1e-6;
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

global possibility_table;
global x_label;
global y_label;
[x_label,y_label,possibility_table] = table_read(csvread('6-11cutin_table.csv'));
%possi_gate = get_possi_gate(possibility_table,20);


imagesc(y_label,x_label,possibility_table);

global maxp;
maxp = max(max(possibility_table));
num = 10;

range = 60;
range_rate = -10;
range_lb = x_label(1);
range_ub = x_label(end);
range_rate_lb = y_label(1);
range_rate_ub = y_label(end);

x0 = [range,range_rate];

LB = [range_lb,range_rate_lb];
UB = [range_ub,range_rate_ub];


handle = @NDD_value_function;
problem = createOptimProblem('fmincon','x0',x0,'objective',handle,...
    'lb',LB,'ub',UB,'Aineq',[],'bineq',[], 'Aeq',[], 'beq',[],'options',optimset('Algorithm','SQP','Disp','none'));
gs = GlobalSearch('FunctionTolerance',10);
[xgs_best,fval_best] = run(gs,problem);


value_table = possibility_table;
value_table(:,:) = 0;
minimium_list = [];
for i = 1:50
    i;
    %[xgs,fval] = run(gs,problem);
    randrange = range_lb+(range_ub-range_lb)*rand(1,1);
    rangerangerate = range_rate_lb+(range_rate_ub-range_rate_lb)*rand(1,1);
    x0 = [randrange,rangerangerate];
    [xgs,fval] = fmincon(handle,x0,[],[],[],[],LB,UB);
    xgs = [find_num(xgs(1),x_label),find_num(xgs(2),y_label)];
    minimium_list = [minimium_list;[xgs,fval]];
    value_table = manshui_NDD(xgs(1),xgs(2),value_table);
end
%csvwrite('region_data.csv',nowdata)
[x,y] = meshgrid(x_label,y_label);


%value_table = final_process(value_table,possibility_table);
for i = 1:size(value_table,1)
    for j = 1:size(value_table,2)
        if value_table(i,j) == 1
            value_table(i,j) = possibility_table(i,j);
        end
    end
end
imagesc(y_label,x_label,value_table);
colorbar;
f = NDD_value_function(xgs);
csvwrite('value_table_new2.csv',value_table);
