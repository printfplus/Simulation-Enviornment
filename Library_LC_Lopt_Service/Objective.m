function [ obj] = Objective( x, N,max_TTC,u_Max,N_BV, Vmax, Vmin, T, L, delt_T)
%�����Բ��ԣ���ֵ����Ŀ�꺯��
% N_BV ��BV����Ŀ�공��

% information 
x_B0 = zeros(N_BV,2);
u_B = zeros(N_BV,N);
for i=1:N_BV
    x_B0(i,:) = x( (i-1)*(N+2)+1 : (i-1)*(N+2)+2 );
    u_B(i,:) = x((i-1)*(N+2)+3:(i-1)*(N+2)+2+N);
end

% ���������Ѷ�����
diff = Difficulty(x_B0, u_B, Vmax, Vmin, T, L, max_TTC, N_BV, N, delt_T);


% �Լ��ٶȽ���Ƶ�ʹ���
thresh_acce = 1.06348;
thresh_deac = -1.35726;
freIndex_u = 0;
for i=1:N_BV
    for j=1:N
        if u_B(i,j) >= thresh_acce
            freIndex_u = freIndex_u + (u_B(i,j)-thresh_acce)^2;
        else if u_B(i,j) <= thresh_deac
                freIndex_u = freIndex_u + (u_B(i,j)-thresh_deac)^2;
            end
        end
    end
end

% ���ٶȽ���Ƶ�ʹ���
thresh_min_V = 27;
thresh_max_V = 32;
freIndex_V = 0;
for i=1:N_BV
    ini_V = x_B0(i,2);
    if ini_V >thresh_max_V
        freIndex_V = freIndex_V + (ini_V-thresh_max_V)^2;
    end
    if ini_V < thresh_min_V
        freIndex_V = freIndex_V + (ini_V-thresh_min_V)^2;
    end
    
end

% �Գ�ʼrange����Ƶ�ʹ���
thresh_min_R = 20;
thresh_max_R = 30;
freIndex_R = 0;
for i=1:N_BV-1
    Range = x_B0(i+1,1)-x_B0(i,1);
    if Range >thresh_max_R
        freIndex_R = freIndex_R + (Range-thresh_max_R)^2;
    end
    if Range < thresh_min_R
        freIndex_R = freIndex_R + (Range-thresh_min_R)^2;
    end
    
end

% �Գ�ʼ�ٶȲrange rate������Ƶ�ʹ���
thresh_min_RR = -2;
thresh_max_RR = 2;
freIndex_RR = 0;
for i=1:N_BV-1
    Range_Rate = x_B0(i+1,2)-x_B0(i,2);
    if Range_Rate >thresh_max_RR
        freIndex_RR = freIndex_RR + (Range_Rate-thresh_max_RR)^2;
    end
    if Range_Rate < thresh_min_RR
        freIndex_RR = freIndex_RR + (Range_Rate-thresh_min_RR)^2;
    end
    
end


freIndex = sqrt(freIndex_u / ( N * N_BV * (u_Max-1)^2)) + sqrt(freIndex_V / (5^2) ) + sqrt(freIndex_R / (10^2)) + sqrt(freIndex_RR / (thresh_max_RR^2));

% �γ�Ŀ�꺯�� ��ʱ��Ŀ�꺯����ȡֵԽ�󣬲��Եļ�ֵԽ�ߡ�
w = 1/4;

% largr diff, little freIndex, is desirable 
% 
obj = -diff / max_TTC + w * freIndex; 

end

