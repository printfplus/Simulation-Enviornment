function newa = sample_and_get_A(a)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
global delta;
mu = a;
delta = 0.1;
rand_num = unifrnd(0,1);
newa = mu + delta*log(-log(1-rand_num));
end

