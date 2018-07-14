function [ Neg_TTC ] = my_fitness_NBV_2L( x,Vmax, Vmin, max_TTC, N_BV,x_B0,u_B, N, delt_T )
%  BV轨迹已定，对于lane change point x,返回TTC

%计算TTC。变量连续。
%编程难点在于：决策变量离散，系统连续。


t = x(1);
y = x(2);


% 有若干个zone，若干个BV的轨迹

% BV
p_B = zeros(1,N_BV+1);
v_B = zeros(1,N_BV+1);
for i=1:N_BV
    [p_B(i), v_B(i)] = BV_Trajectory(x_B0(i,:), u_B(i,:), t, N, delt_T);
end

% delete the influence of exit.
p_B(N_BV+1) = 1e5;
v_B(N_BV+1) = 1e2;

% TTC
TTC = zeros(1,N_BV+1);
for i=1:N_BV+1
    if ( abs(v_B(i)-Vmax)<0.01 && p_B(i)>y) || ( abs(v_B(i)-Vmin)<0.01 && p_B(i)<y)
        TTC(i) = max_TTC;
    else if p_B(i)>y
        TTC(i) = (p_B(i)-y) / (Vmax - v_B(i));
        else
        TTC(i) = (y-p_B(i)) / (v_B(i) - Vmin);
        end
    end
end
TTC = TTC(TTC>=0);
% the most dangerous TTC
TTC_Consider = min( [TTC, max_TTC]);

% negtive: to find the easiest point(t,y)

Neg_TTC = -TTC_Consider;

end

