mu = 0.33;
for delta = 0.1
    x = -1:0.01:1;
    y = pdf_function(x,mu,delta);
    plot(x,y);
    hold on;
end