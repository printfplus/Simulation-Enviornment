function [ p, v ] = BV_Trajectory( x_B0, u_B, t, N, delt_T )

% 搞出来离散化的BV加速度、轨迹。
% 离散化的加速度曲线也在这里定义好了，留出接口可以改。
% t 换道点的时间

% 生成BV的轨迹
p_B = zeros(1,N);
v_B = zeros(1,N);
p_B(1) = x_B0(1);
v_B(1) = x_B0(2);

if N>1
    for i=2:N
        v_B(i) = v_B(i-1) + u_B(i-1)*delt_T;
        p_B(i) = p_B(i-1) + v_B(i-1)*delt_T + 0.5*u_B(i-1)*delt_T^2;
    end
end


% 返回需要的轨迹
for i=1:N
    if delt_T*(i-1) <= t && t <= delt_T*i
        dT = t - delt_T*(i-1);
        p = p_B(i) + v_B(i) * dT + 0.5 * u_B(i) * dT^2;
        v = v_B(i) + u_B(i) * dT;
    end
end


end

