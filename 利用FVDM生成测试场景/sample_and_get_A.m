function newa = sample_and_get_A(a)
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
global delta;
mu = a;
delta = 0.1;
rand_num = unifrnd(0,1);
newa = mu + delta*log(-log(1-rand_num));
end

