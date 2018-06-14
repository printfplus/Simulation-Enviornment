cut_in_data = csvread('CUT_IN_data.csv');
cut_in_data(1,:) = [];
range_lb = min(cut_in_data(:,1));
range_ub = max(cut_in_data(:,1));
%range_rate_lb = min(cut_in_data(:,2));
%range_rate_ub = max(cut_in_data(:,2));
range_rate_lb = -20;
range_rate_ub = 10;
range_interval = 2;
range_rate_interval = 0.4;%
%range_list = [];
%range_rate_list = [];
range_lb_int = floor(range_lb);
range_ub_int = ceil(range_ub);
range_rate_lb_int = floor(range_rate_lb);
range_rate_ub_int = ceil(range_rate_ub);
range_tmp = range_lb_int;

range_list = range_lb:range_interval:range_ub;
range_rate_list = range_rate_lb_int:range_rate_interval:range_rate_ub;


CUT_in_table = zeros(size(range_list,2),size(range_rate_list,2));

for i = 1:size(cut_in_data,1)
    range_tmp = cut_in_data(i,1);
    range_rate_tmp = cut_in_data(i,2);
    if range_tmp <= range_lb || range_tmp >= range_ub || range_rate_tmp <= range_rate_lb || range_rate_tmp >= range_rate_ub
        continue;
    end
    range_num = floor((range_tmp-range_lb_int)/range_interval)+1;
    range_rate_num = floor((range_rate_tmp-range_rate_lb_int)/range_rate_interval)+1;
    CUT_in_table(range_num,range_rate_num) = CUT_in_table(range_num,range_rate_num)+1;
end
CUT_in_table = CUT_in_table/sum(sum(CUT_in_table));
figure;
imagesc(range_rate_list,range_list,CUT_in_table);
xlabel('range rate','FontSize',15);
ylabel('range','FontSize',15);
set(gca,'FontName','Times New Roman','FontSize',14);
colorbar;
