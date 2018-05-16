%% 利用Metropolis-Hastings 算法产生样本
% 这里的样本分布为：p(x) = C* x.^(-n/2)*exp(-a/(2x));
% 对于参数n=5，参数a=4.
xlen = 200000;
x = zeros(2,xlen);
x0 = [60,-10] ;
len = length(x);
k = 1 ;
table = csvread('value_table_new.csv');
km = [];
while k <= len
    k
    nextx = [100*rand(),-20*rand()];
    %compute the p from x0
    pn = get_possibility(nextx,table);
    km = [km,pn];
    p0 = get_possibility(x0,table);
    p = min(pn/p0,1);
    if p >= 1
        x(1,k) = nextx(1);
        x(2,k) = nextx(2);
        x0 = nextx ;
        k = k + 1 ;     
    else
        pp = rand();
        if pp < p
            x(1,k) = nextx(1);
            x(2,k) = nextx(2);
            x0 = nextx   ;
            k = k + 1 ;       
        end
        
    end
    
end
hist = histc(abs(x(2,1:k-1)),0:0.4:100);
plot(hist);   
figure;
imagesc(table);

%figure;
%plot(y);