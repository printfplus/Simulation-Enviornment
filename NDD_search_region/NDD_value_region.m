clear;
%clc;

nowdata = [];
nowdata = csvread('nowdata.csv');
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

NDD_table = csvread('cutindata_biginterval.csv');
x_label = NDD_table(:,1);
NDD_table(:,1) = [];
x_label(1) = [];
y_label = NDD_table(1,:);
NDD_table(1,:) = [];
range_lb = min(x_label);
range_ub = max(x_label);
range_rate_lb = min(y_label);
range_rate_ub = max(y_label);
range_interval = x_label(2)-x_label(1);
range_rate_interval = y_label(2)-y_label(1);


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
gs = GlobalSearch('FunctionTolerance',10);


value_table = zeros(size(NDD_table));

for i = 1:5
    i
    [xgs,fval] = run(gs,problem);
    nowdata = [nowdata;[xgs,fval]];
    %nowdata = round(nowdata,1);
end
csvwrite('nowdata.csv',nowdata)

[x,y] = meshgrid(x_label,y_label);
num_value = 0;

for i = 1:size(nowdata,1)
    range_tmp = nowdata(i,1);
    range_rate_tmp = nowdata(i,2);
    range_num = floor((range_tmp-range_lb)/range_interval)+1;
    range_rate_num = floor((range_rate_tmp-range_rate_lb)/range_rate_interval)+1;
    NDD_table(range_num,range_rate_num)
    value_table(range_num,range_rate_num) = 1;%NDD_table(range_num,range_rate_num);
    %num_value = num_value+value_table(range_num,range_rate_num);
end
value_table = matrix_process(value_table);
%surf(x,y,value_table);
imagesc(x_label,y_label,value_table);
csvwrite('value_table_ndd.csv',value_table);
colorbar;
f = value_function(xgs);

