function possi_gate = get_possi_gate(table,percent)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
newtable = reshape(table,size(table,1)*size(table,2),1);
possi_gate = prctile(newtable,percent);
end

