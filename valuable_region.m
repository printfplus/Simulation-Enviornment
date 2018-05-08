clear;
%clc;

nowdata = [];
nowdata = csvread('region_data.csv');
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
Pb = 0.1;

table = csvread('possibility_table.csv');

safe_table = csvread('new.csv');
safe_table(1,:) = [];
safe_table(:,1) = [];



x_label = table(1,:);
x_label(1)=[];
x_label(size(x_label,2))=[];
y_label = table(:,1);
y_label(1)=[];
y_label(size(y_label,1))=[];
%x_label(size(x_label,2)) = [];
%y_label(size(y_label,1)) = [];

table(1,:) = [];
table(:,1) = [];



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


value_table = csvread('Pxib_table.csv');
value_table(:,:) = 0;

for i = 1:5
    [xgs,fval] = run(gs,problem);
    nowdata = [nowdata;[xgs,fval]];
    nowdata = round(nowdata,1);
end
csvwrite('region_data.csv',nowdata)
[x,y] = meshgrid(x_label,y_label);
for i = 1:size(nowdata,1)
    range_tmp = nowdata(i,1);
    range_rate_tmp = nowdata(i,2);
    range_num = find_num(range_tmp,y_label);
    range_rate_num = find_num(range_rate_tmp,x_label);
    value_table(range_num,range_rate_num) = table(range_num,range_rate_num)*safe_table(range_num,range_rate_num);
end
value_table = matrix_process(value_table);
surf(x,y,value_table);
f = value_function(xgs);

