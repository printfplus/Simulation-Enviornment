%% Case study of highway exit

clear;clc;
clear global;

tic

%% parameters

% constant
Parameter;

% the number of initial points
n_x0 = 1000;
% the number of core
parpool('local', 20); 

%% boundary constrains
LB0 = [L_x, Vmin, -u_Max*ones(1,N)];
UB0 = [L, Vmax, u_Max*ones(1,N)];
LB = repmat(LB0,1,N_BV);
UB = repmat(UB0,1,N_BV);

nsize = max(size(LB));

%% inequality constrains
Ap(1,:) = [1,0,zeros(1,N),-1,0,zeros(1,N)]; %pi,0<pi+1,0
for i=1:N      
    % calculate k
    tmp_Ap = [1,i*delt_T];
    for k=1:i
        tmp_Ap = [tmp_Ap, (i-k+0.5)*delt_T^2];
    end 
    Ap(i+1,:) = [tmp_Ap,zeros(1,N-i), -tmp_Ap, zeros(1,N-i)];
end
for i=1:N
    Av_Max(i,:) = [0,1,ones(1,i)*delt_T,zeros(1,N-i)];
end
for i=1:N
   Av_Min(i,:) = [0,-1,-ones(1,i)*delt_T,zeros(1,N-i)];
end

A0 = [Ap;Av_Max,zeros(size(Av_Max,1),2+N);Av_Min,zeros(size(Av_Min,1),2+N)];

for i=1:N_BV-1
    A_x = (i-1)*size(A0,1)+1:i*size(A0,1);
    A_y = (i-1)*(N+2)+1:(i-1)*(N+2)+size(A0,2);
    A(A_x, A_y) = A0;
end
i=N_BV;
Av = [Av_Max;Av_Min];
A_x = (i-1)*size(A0,1)+1:(i-1)*size(A0,1)+size(Av,1);
A_y = (i-1)*(N+2)+1:(i-1)*(N+2)+size(Av,2);
A(A_x, A_y) = Av;

b = [-safe_D*ones(size(Ap,1),1); Vmax*ones(size(Av_Max,1),1); -Vmin*ones(size(Av_Min,1),1)];
b = repmat(b,N_BV-1,1);
b = [b;Vmax*ones(size(Av_Max,1),1); -Vmin*ones(size(Av_Min,1),1)];

%% valuable region searching

data_xgs = {};
data_fval = {};

parfor i=1:n_x0
    
    i
    % random initial
    x0 = zeros(1,nsize);
    while 1
        for j=1:nsize
            x0(j) = unifrnd(LB(j),UB(j),1,1);
        end
        if A*x0'< b
            break;
        end
    end

    % local optimum
    handle = @(x)Objective(x,N,max_TTC,u_Max,N_BV, Vmax, Vmin, T, L,delt_T);
    [xgs,fval] = fmincon(handle,x0,A,b,[],[],LB,UB,[]);
    
    data_xgs{i}=xgs;
    data_fval{i} = fval;
end
toc
save Opt_0712.mat;
save Lopt.mat data_xgs data_fval















