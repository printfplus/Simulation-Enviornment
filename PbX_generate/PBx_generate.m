range_label = 0:2:98;
range_rate_label  = -20:0.4:-4.4;
PBX_table = zeros(size(range_label,2),size(range_rate_label,2));
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
x_label = range_label;
y_label = range_rate_label;
global table;
global threhold;
threhold = 12;

for i = 1:size(range_label,2)
    for j = 1:size(range_rate_label,2)
        PBX_table(i,j) = value_function([range_label(i),range_rate_label(j)]);
        if PBX_table(i,j) == 0
            PBX_table(i,j) = 1;
        else
            PBX_table(i,j) = 0;
        end
            
    end
end
imagesc(y_label,x_label,PBX_table);
%csvwrite('PBX.csv',PBX_table);
        
