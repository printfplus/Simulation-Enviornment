function [f] = space_punish(x)
    global threhold;
    %threhold = 20;
    range = x(1);
    range_rate = x(2);
    range_point = 60;
    range_rate_point = -10;
    now_length = sqrt((range-range_point)^2/16+(range_rate-range_rate_point)^2);
    if now_length < threhold
        f = 0;
    else
        f = now_length-threhold;
    end
end
