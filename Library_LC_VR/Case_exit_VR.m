%% find valuable region

clear;clc;

load('Opt_0711.mat');

% % discrete lable
% xgs_Label = zeros(1,par_nsize);
% for j=1:par_nsize
%     xgs_Label(j) = find_num(xgs(j),par_Discrete{j});
% end      
% 
% % save
% x_l_opt{1,i} = xgs;
% x_l_opt{2,i} = xgs_Label;
% f_l_opt(i) = fval;

% calculate probability
SamP = zeros(1,n_x0);
Diff = zeros(1,n_x0);
P_NDD = zeros(1,n_x0);
for i=1:n_x0
    [SamP(i), Diff(i), P_NDD(i)] = Get_SamP(data_xgs{i});    
end
mTTC = -Diff;

% obtain SamP>0 scenarios
Seeds = data_xgs(SamP>0);
n_Seeds = max(size(Seeds));

% region searching
Thresh_SamP = 0;
parpool('local', 2); 
total_table_search = {};
total_table_value = {};
parfor i=1:n_Seeds
    
    table_search = [];
    table_value = [];
    
    n_table_s = size(table_search,1);
    table_search(n_table_s+1,:) = Get_ID_X(Seeds{i});
    
    n_table_v = size(table_value, 1);
    table_value(n_table_v+1,:) = Get_ID_X(Seeds{i});
    
    [table_search, table_value] = NSeedFill(Seeds{i}, Thresh_SamP, table_search, table_value);
    
    total_table_search{i} = table_search;
    total_table_value{i} = table_value;
   
end
