%range_label = 0:2:98;
%range_rate_label  = -116:4:80;
global possibility_table;
global x_label;
global y_label;
[x_label,y_label,possibility_table] = table_read(csvread('NDD_P(x).csv'));
global maxp;
maxp = max(max(possibility_table));
PBX_table = zeros(size(x_label,1),size(y_label,1));
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
global table;
global threhold;
threhold = 12;
range_label = reshape(x_label,1,size(x_label,1));
range_rate_label = y_label;

for i = 1:size(range_label,2)
    for j = 1:size(range_rate_label,2)
        PBX_table(i,j) = NDD_value_function([range_label(i),range_rate_label(j)]);
        
        if PBX_table(i,j) >100
            PBX_table(i,j) = 100;
       % else
       %     PBX_table(i,j) = 0;
        end
            
    end
end
imagesc(y_label,x_label,100-PBX_table);
%csvwrite('PBX.csv',PBX_table);
        
