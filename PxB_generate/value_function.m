function [f] = value_function(x)

    global v1;
    global v2;
    global vmax;
    global vmin;
    global dt;
    global omega;
    global x_label;
    global y_label;
    global table;
    range = x(1);
    range_rate = x(2);
    v1 = v2+range_rate;
    global STEP;
    car1 = [range,v1];
    car2 = [0,v2];
    value_list = [];
    for i = 1:STEP
        a1 = 0;
        a2 = pid_follow(car1(1),car2(1),car1(2),car2(2));
        car1 = update_state(car1(1),car1(2),a1,dt,vmin,vmax);
        car2 = update_state(car2(1),car2(2),a2,dt,vmin,vmax);
        value_list = [value_list,time_interval(car1(1),car2(1),car1(2),car2(2))];
    end
    f = min(value_list)+omega*space_punish(x);
    %f = min(value_list);%-1000*get_continious_poss(x_label,y_label,table,x(1),x(2));
end
    



