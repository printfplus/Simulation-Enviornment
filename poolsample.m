%% ����Metropolis-Hastings �㷨��������
% ����������ֲ�Ϊ��p(x) = C* x.^(-n/2)*exp(-a/(2x));
% ���ڲ���n=5������a=4.
xlen = 200000;
global xlabel;
global ylabel;
[xlabel,ylabel,mytable] = table_read(csvread('6-11cutin_table.csv'));
x = zeros(2,xlen);
x0 = [60,-10] ;
len = length(x);
k = 1 ;
table = csvread('value_table_new2.csv');
new_table = zeros(size(table));
km = [];
while k <= len
    nextx = [xlabel(1)+(xlabel(end)-xlabel(1))*rand(),ylabel(1)+(ylabel(end)-ylabel(1))*rand()];
    %compute the p from x0
    [pn,nxnum,nynum] = get_possibility(nextx,table);
    %km = [km,pn];
    [p0,zxnum,zynum] = get_possibility(x0,table);
    p = min(pn/p0,1);
    if p >= 1
        x(1,k) = nextx(1);
        x(2,k) = nextx(2);
        x0 = nextx ;
        k = k + 1 ; 
        new_table(zxnum,zynum) = new_table(zxnum,zynum)+1;
    else
        pp = rand();
        if pp < p
            x(1,k) = nextx(1);
            x(2,k) = nextx(2);
            x0 = nextx   ;
            k = k + 1 ; 
            new_table(zxnum,zynum) = new_table(zxnum,zynum)+1;
        end
        
    end
    
end
%hist = histc(abs(x(1,1:k-1)),0:0.4:100);
%plot(hist);   
figure;
imagesc(new_table);
colorbar;
