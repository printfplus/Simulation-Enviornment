function [f] = space_punish(x)
    range = x(1);
    range_rate = x(2);
    range_point = 60;
    range_rate_point = -10;
    now_length = sqrt((range-range_point)^2+(range_rate-range_rate_point)^2);
    if now_length < 20
        f = 0;
    else
        f = now_length-20;
    end
end
