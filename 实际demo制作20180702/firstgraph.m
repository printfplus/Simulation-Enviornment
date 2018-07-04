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

global M;
M = 3000;

global delta;
delta = 0.1;
global possibility_table;
global x_label;
global y_label;
[x_label,y_label,possi_table] = table_read(csvread('6-11cutin_table.csv'));
mygraph = zeros(size(possi_table));
for i = 1:size(mygraph,1)
    for j = 1:size(mygraph,2)
        collision_time = 0;
        for k = 0:100
            tmp_test = value_function([x_label(i),y_label(j)]);
            if tmp_test == 0
                collision_time = collision_time+1;
            end
        end
        mygraph(i,j) = collision_time/100;
    end
end
imagesc(y_label,x_label,mygraph);
thirdgraph = mygraph.*possi_table;
figure;
imagesc(y_label,x_label,thirdgraph);