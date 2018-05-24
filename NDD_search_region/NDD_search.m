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

possibility_table = csvread('cutindata_biginterval.csv');
newtable = zeros(size(possibility_table));
y_label = possibility_table(1,:);
y_label(1) = [];
possibility_table(1,:) = [];
x_label = possibility_table(:,1);
possibility_table(:,1) = [];
num = 10;
for i = 1:10
    range_num = randi([1,size(x_label,1)],1,1);
    range_rate_num = randi([1,size(y_label,2)],1,1);
    x = [range_num,range_rate_num];
    flag = 1;
    while(flag)
        [f,nowx] = manual_search(x,possibility_table,x_label,y_label);
        if x == nowx 
            flag = 0;
            newtable(x(1),x(2)) = 1;
        end
        x = nowx;
    end
end
imagesc(x_label,y_label,newtable);