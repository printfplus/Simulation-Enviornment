function possi_gate = get_possi_gate(table,percent)
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
newtable = reshape(table,size(table,1)*size(table,2),1);
possi_gate = prctile(newtable,percent);
end

