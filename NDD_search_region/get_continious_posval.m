function f = get_continious_posval(x)
    range = x(1);
    range_rate = x(2);
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

    possibility_table = csvread('cut_in_distribution.csv');
    y_label = possibility_table(1,:);
    y_label(1) = [];
    possibility_table(1,:) = [];
    x_label = possibility_table(:,1);
    possibility_table(:,1) = [];
    tmp_area = (x_label(2)-x_label(1))*(y_lable(2)-y_label(1));
    max_area = max(max(possibility_table))/tmp_area

    range_num = 0;
    range_rate_num = 0;
    for i = 1:size(x_label,1)
        if range_value < x_label(i)
            range_num = i;
            break;
        end
    end

    for i = 1:size(y_label,2)
        if range_rate_value < y_label(i)
            range_rate_num = i;
            break;
        end
    end

    possi = possibility_table(range_num,range_rate_num);
    possi_density = possi/tmp_area;
    f = possi_density;

end