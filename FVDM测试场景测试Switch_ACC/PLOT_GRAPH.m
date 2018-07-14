load('NDD_Switch_ACC_list.mat');
NDD_list = collision_rate_list;
load('value_region_Switch_ACC_list.mat');
value_list = collision_rate_list(1:1000);
NDD_x = 1:200000;
value_x = 1:1000;
x1 = NDD_x;
y1 = NDD_list;
x2 = value_x;
y2 = value_list;
hl1 = line(x1,y1,'Color','r','LineWidth',2);
xlabel('Test Time','FontSize',15);
ylabel('Collision Rate','FontSize',15);
set(gca,'linewidth',2,'FontName','Times New Roman','FontSize',14);
ax1 = gca;
set(ax1,'Xlim',[0,200000],'Ylim',[0,0.005])
ax2 = axes('Position',get(ax1,'Position'),...
           'XAxisLocation','top',...
           'YAxisLocation','right',...
           'Color','none');
hl2 = line(x2,y2,'Parent',ax2,'LineWidth',2);
set(ax2,'Xlim',[0,1000],'Ylim',[0,0.005])
legend([hl1,hl2],'NDD','Value Region');
set(gca,'linewidth',2,'FontName','Times New Roman','FontSize',14);
set(ax2,'ytick',[]);
