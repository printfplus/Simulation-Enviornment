function val = get_continious_poss(x_label,y_label,possi_table,range_value,range_rate_value)
    tmp_area = (x_label(2)-x_label(1))*(y_label(2)-y_label(1));
    range_num = find_num(range_value,x_label);
    range_rate_num = find_num(range_rate_value,y_label);
    val =  possi_table(range_num,range_rate_num)/tmp_area;

end