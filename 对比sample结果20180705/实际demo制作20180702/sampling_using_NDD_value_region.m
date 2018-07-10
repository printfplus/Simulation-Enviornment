function [range,range_rate] = sampling_using_NDD_value_region()

range = 0;
range_rate = 0;
xlen = 200000;
global xlabel;
global ylabel;
[xlabel,ylabel,~] = table_read(csvread('6-11cutin_table.csv'));
global sampling_x0;

sampling_x0 = csvread('x0.csv');
table = load('value_table.mat');

while (1)
    nextx = [xlabel(1)+(xlabel(end)-xlabel(1))*rand(),ylabel(1)+(ylabel(end)-ylabel(1))*rand()];
    %compute the p from x0
    [pn,~,~] = get_possibility(nextx,table);
    %km = [km,pn];
    [p0,~,~] = get_possibility(sampling_x0,table);
    p = min(pn/p0,1);
    if p >= 1
        sampling_x0 = nextx ;
        csvwrite('x0.csv',sampling_x0);
        range = nextx(1);
        range_rate = nextx(2);
        return;
    else
        pp = rand();
        if pp < p
            sampling_x0 = nextx   ;
            csvwrite('x0.csv',sampling_x0);
            range = nextx(1);
            range_rate = nextx(2);
            return;
        end
        
    end
    
end
end

