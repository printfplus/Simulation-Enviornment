function [f] = NDD_value_function(x)
    global maxp;
    global possibility_table;
    global x_label;
    global y_label;
    global possi_gate;
    global gate_num;
    range_value = x(1);
    range_rate_value = x(2);
    range_num = find_num(range_value,x_label);
    range_rate_num = find_num(range_rate_value,y_label);
    value = value_function(x);
    if possibility_table(range_num,range_rate_num)>possi_gate
        f = value;
    else
        f = value + 20*(possi_gate-possibility_table(range_num,range_rate_num));
    end
end