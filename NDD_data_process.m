table = csvread('NDD_new.csv');
figure;
x_label = table(1,:);
x_label(1)=[];
table(1,:) = [];
y_label = table(:,1);
table(:,1) = [];
imagesc(x_label,y_label,table);
colorbar;
possibility_table = csvread('cutindata_biginterval.csv');
figure;
possibility_table(1,:)=[];
possibility_table(:,1)=[];
imagesc(x_label,y_label,possibility_table);
colorbar;
range_num = size(possibility_table,1);
range_rate_num = size(possibility_table,2);
Pb_table = zeros(range_num,range_rate_num);

for i = 1:range_num
    for j = 1:range_rate_num
        Pb_table(i,j) = table(i,j)*possibility_table(i,j);
    end
end
Pb = sum(sum(Pb_table));
Pxib_table = Pb_table/Pb;
figure;
imagesc(x_label,y_label,Pxib_table);
colorbar;
newp = sum(sum(Pxib_table));
csvwrite('Pxib_table.csv',Pxib_table)



