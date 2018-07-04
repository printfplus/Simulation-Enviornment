clear;
clc;
[range_label,range_rate_label,mytable] = table_read(csvread('6-11cutin_table.csv'));
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

for i = 1:size(range_label,1)
    for j = 1:size(range_rate_label,2)
        PBX_table(i,j) = value_function([range_label(i),range_rate_label(j)]);
        %if PBX_table(i,j) >100
        %    PBX_table(i,j) = 1;
        %end
        if PBX_table(i,j) > 0
            PBX_table(i,j) = 0;
        elseif PBX_table(i,j) == 0
            PBX_table(i,j) = 1;
        end
    
            
    end
end
%PBX_table = max(max(PBX_table))-PBX_table;
imagesc(PBX_table);
colorbar;
PBX_table = PBX_table.*mytable;
%PBX_table = PBX_table/sum(sum(PBX_table));
%imagesc(y_label,x_label,PBX_table);
%csvwrite('PBX.csv',PBX_table);
my_table = reshape(PBX_table,1,3420);
my_table = sort(my_table,'DESCEND');
figure;
imagesc(PBX_table);
for i = 1:3420
    if my_table(i) < 10/3420
        mypossi = my_table(i);
        break;
    end
end
for i = 1:size(PBX_table,1)
    for j = 1:size(PBX_table,2)
        if PBX_table(i,j) > mypossi
            PBX_table(i,j) = 100;
        end
    end
end
figure;
imagesc(PBX_table);
        
