%% parameter

% discrete label
dis_V = 1;
dis_R = 5;
dis_RR = 1;
dis_U = 0.2;
delt_t_true = 0.1;


% bound
Vmax = 40;
Vmin = 20;
u_Max = 2;
u_Min = -4;
L = 100;
T = L/Vmin;
safe_D = 10;
L_x = -L;
max_TTC = (L-L_x) / (Vmin);


% decision space
delt_T = 0.1;
N = ceil(T / delt_T);
N_BV = 2;

%% NDD
V = 20:dis_V:40;
n_dis_V = size(V,2);

R = 0:dis_R:115;
n_dis_R = size(R,2);

RR = -10:dis_RR:8;
n_dis_RR = size(RR,2);

U = -4:dis_U:2;
n_dis_U = size(U,2);


X = -L:dis_R:L;

%% HV
Thresh_TTC = 5;
C_HV_F_Rate = 0.2;
