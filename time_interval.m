function f = time_interval( x1,x2,v1,v2)
global omega;
if x1 > x2+1
    f = -(v2-v1)/(x1-x2);
else
    f = -100000;
end
end

