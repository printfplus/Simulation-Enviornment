load('x0_NDD.mat');
range_tmp = x0(1);
range_rate_tmp = x0(2);
range_tmp_num = find_num(range_tmp,x_label);
range_rate_tmp_num = find_num(range_rate_tmp,y_label);
tmp_possi = possi_table(range_tmp_num,range_rate_tmp_num);
