%value_table_process;
%value_region_generate_sampling_library;
%value_region_test;
load('delta0.1_collision_list.mat');
plot(collision_rate_list(1:40000),'LineWidth',2);
hold on;
load('delta0.2_collision_list.mat');
plot(collision_rate_list(1:40000),'LineWidth',2);
hold on;
load('delta0.3_collision_list.mat');
plot(collision_rate_list(1:40000),'LineWidth',2);
hold on;
load('NDD_collision_rate_list.mat');
plot(collision_rate_list(1:40000),'LineWidth',2);
legend('0.1','0.2','0.3','NDD');
xlabel('Test Time','FontSize',15);
ylabel('Collision Rate','FontSize',15);
set(gca,'linewidth',2,'FontName','Times New Roman','FontSize',14);

