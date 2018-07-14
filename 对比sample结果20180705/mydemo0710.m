clear;
clc;
load('NDD_collision_rate_list');
NDD_list = collision_rate_list;
load('value_region_collision_rate_list.mat');
plot(NDD_list,'LineWidth',2);
hold on;
plot(collision_rate_list,'LineWidth',2);
legend('NDD','Value Region');

