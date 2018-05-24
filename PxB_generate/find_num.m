function [num] = find_num(value,label)
num = [];
for i = 1:max(size(label,1),size(label,2))
    if label(i) >= value
        num = i;
        break
    end
end

