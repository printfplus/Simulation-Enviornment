function f = pdf_function(x,mu,delta)
    f = (1/delta).*exp((x-mu)/delta).*exp(-exp((x-mu)/delta));
end