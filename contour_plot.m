f = @(x,y) value_function([x,y]);
%f = @(x,y) x+y;
fcontour(f,[0 100 -20 0]);