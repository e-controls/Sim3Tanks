clc; clear all; close all; rng('default');

%% Paths
% In this section all paths and subpaths needed to run the simulation are loaded.

%restoredefaultpath();
addpath(genpath('../../three_tank_system'));
addpath(genpath('../../control_system'));
addpath(genpath('../../fdi_system'));

%% System parameters
% In this section are defined the physical dimensions of the three-tank
% system and the constants values.

R    = 5;     % Tanks radius (cm)
Hmax = 50;    % Tanks height (cm)
r    = 0.635; % Pipes radius (cm)
h0   = 30;    % Transmission pipes height (cm)
mi   = 1;     % Flow correction term (-)
g    = 981;   % Gravity constant (cm/s^2)

% ***DO NOT EDIT [Begin]***
set_parameters(R, Hmax, r, h0, mi, g);
% ***DO NOT EDIT [End]***

%% Simulation time
% In this section the simulation time is set.

tstart = 0;     % Start time
tstop  = 10000; % Stop time
Ts     = 0.1;   % Sample time

% ***DO NOT EDIT [Begin]***
time = linspace(tstart, tstop, 1+tstop/Ts);
set_time(time);
% ***DO NOT EDIT [End]***

%% Flow from pumps P1 and P2
%In this section are defined the flow from pumps P1 and P2.
% >> pmaxflow(i) (i=1,2): is the maximum flow from pump Pi.
% >> pturnon(i) (i=1,2): is the time when the pump Pi is switched on.
% >> pturnoff(i) (i=1,2): is the time when the pump Pi is switched off.

%--------->[P1     P2    ]
pmaxflow = [80     80    ]; % Qp1 and Qp2 in cm^3/s
pturnon  = [time(1)   time(1)  ]; % time in seconds
pturnoff = [time(end) time(end)]; % time in seconds

% ***DO NOT EDIT [Begin]***
set_pumps(pmaxflow, pturnon, pturnoff);
% ***DO NOT EDIT [End]***

%% Operation mode
% In this section is defined the operation mode of the system valves:
% >> If Kx=1 (x=p1,p2,a,b,13,23,1,2,3), then the valve Kx is defined as normally open.
% >> If Kx=0 (x=p1,p2,a,b,13,23,1,2,3), then the valve Kx is defined as normally closed.

%--------------->[Kp1 Kp2 Ka  Kb  K13 K23 K1  K2  K3 ]
operation_mode = [ 1   1   0   0   1   1   0   0   1 ];

% ***DO NOT EDIT [Begin]***
set_operation_mode(operation_mode);
% ***DO NOT EDIT [End]***

%% Fault signals
% In this section the fault signals are set and generated.
% >> fmag(i) (i=1,2,...,21): is the fault magnitue and must be betweeen [0,1].
% >> ftype(i) (i=1,2,...,21): is the fault type and must be 0 (stepwise) or 1 (driftwise).
% >> fstart(i) (i=1,2,...,21): is the start time of the fault i.
% >> fstop(i) (i=1,2,...,21): is the stop time of the fault i.

%------->[Kp1 Kp2 Ka* Kb* K13 K23  K1   K2   K3   h1   h2   h3   u1   u2  Qa*  Qb*  Q13  Q23 Q1*  Q2*  Q3 ]
%------->[F1  F2  F3* F4* F5  F6   F7   F8   F9   F10  F11  F12  F13  F14 F15* F16* F17  F18 F19* F20* F21]
fmag   = [ 1   1   0   0   1   1    1    1    1    1    1    1    1    1   0    0    1    1   0    0    1 ];
ftype  = [ 0   0   0   0   0   0    0    0    0    0    0    0    0    0   0    0    0    0   0    0    0 ];
fstart = [150 450  0   0  750 1050 1350 1650 1950 2250 2550 2850 3150 3450 0    0   3750 4050 0    0  4350];
fstop  = [300 600  0   0  900 1200 1500 1800 2100 2400 2700 3000 3300 3600 0    0   3900 4200 0    0  4500];

% ***DO NOT EDIT [Begin]***
set_faults(fmag, ftype, fstart, fstop);
% ***DO NOT EDIT [End]***

%% System simulation
disp('#Running Sim3Tanks to generate training data...');

% Initial tank levels (cm)
x0 = [0 0 0]'; % [h1 h2 h3]'

% White noise
mean0 = 0.0; % Mean of the noises
stdw0 = 0.0; % Process noise
stdx0 = 0.3; % Output noise for level sensors
stdq0 = 1.5; % Output noise for flow sensors

% Continuous three-tank system variables
N = length(get_time()); % Number of samples
x = zeros(3,N);  % States: x = [h1, h2, h3]'
q = zeros(9,N);  % Outflows: q = [u1, u2, Qa, Qb, Q13, Q23, Q1, Q2, Q3]'
y = zeros(12,N); % Measured outputs: y = [h1, h2, h3, u1, u2, Qa, Qb, Q13, Q23, Q1, Q2, Q3]'

% Discrete FDI system variables
fout1 = zeros(8,N); % Threshold crossing vector z = [z1, z2, z3, z4, z5, z6, z7, z8]'
fout2 = zeros(1,N); % Not used in this case
fout3 = zeros(1,N); % Not used in this case
fout4 = zeros(1,N); % Not used in this case
fout5 = zeros(1,N); % Not used in this case

% Discrete control system variables
cout1 = zeros(2,N); % Control signal:  uk = [u1, u2]'
cout2 = zeros(1,N); % Not used in this case
cout3 = zeros(1,N); % Not used in this case

% Setpoint desired
%level_setpoint = [3 4]'; % Level [h1 h2]' (cm)
W = [zeros(1,10000), 0.3*ones(1,10000), 0.5*ones(1,10000)];
flow_setpoint = 120;%*(ones(1,N)-[W, zeros(1,20000), W, zeros(1,20001)]); % Flow Q3 (cm^3/s)

% ***DO NOT EDIT [Begin]***
u  = [0 0]'; % First control signal (cm^3/s)(don't change)
% ***DO NOT EDIT [End]***

for k = 1 : N
    
    set_k(k); % Update current k
    
    f = get_faults(k); % Fault signals
    w = get_process_noise([mean0 stdw0]); % Process noises
    v = get_output_noise([mean0 stdx0], [mean0 stdq0]); % Output noises
    
    Qp = get_pumps(k); % Flow from pumps
    
    % Three-tank system
    [y(:,k), x(:,k), q(:,k)] = three_tank_system_simulator(x0, u, f, w, v);
    
    % A/D converter
    yk = y(:,k);
    
    % Digital control system
    %[cout1(:,k),cout2(:,k),cout3(:,k)] = feval(@level_controller, level_setpoint, Qp, yk);
    [cout1(:,k),cout2(:,k),cout3(:,k)] = feval(@flow_controller, flow_setpoint, Qp, yk);
    
    uk = cout1(:,k);
    
    % FDI system
    [fout1(:,k),fout2(:,k),fout3(:,k),fout4(:,k),fout5(:,k)] = feval(@fdi_system_training, uk, yk);
    
    % D/A converter
    u = uk;
    
end

%% Creating Bayesian Network
evidence_nodes_labels = {' z1 ',' z2 ',' z3 ',' z4 ',' z5 ',' z6 ',' z7 ',' z8 '};
fault_nodes_labels = {' f1 ',' f2 ',' f5 ',' f6 ',' f7 ',' f8 ',' f9 ','f10','f11','f12','f13','f14','f17','f18','f21'};
all_nodes_labels   = [evidence_nodes_labels, fault_nodes_labels];
Ne = length(evidence_nodes_labels);
Nf = length(fault_nodes_labels);
Na = length(all_nodes_labels);

node_sizes = 2*ones(1,Na); % Binary nodes
dag = [zeros(Ne),ones(Ne,Nf);zeros(Nf,Na)]; % Directed Acyclic Graph (DAG)

% Shows DAG structure
draw_graph(dag,all_nodes_labels);

% Making Bayesian networks
bnet = mk_bnet(dag,node_sizes);

% Distribution definition
for i = 1 : Na
    bnet.CPD{i} = tabular_CPD(bnet,i); % Creates a random CPD with the size equal to node_sizes of the node i
end

% Creation of training matrix
disp('#Preparing training data...');

z = fout1; % Fault detection matrix
f = get_faults(); % Fault matrix

M = [z;f(1:2,:);f(5:14,:);f(17:18,:);f(21,:)]+1; % Training matrix
M = unique(M','stable','rows')'; % Removes repeated columns of M
M = [M,zeros(23,10)];

% Bayesian network training
disp('#Training Bayesian network...');

bnet = learn_params(bnet,M);

save('trained_bnet','M','bnet');

clear R Hmax r h0 mi g;
clear tstart tstop Ts time;
clear pmaxflow pturnon pturnoff;
clear operation_mode;
clear fmag ftype fstart fstop;
clear x0 mean0 stdw0 stdx0 stdq0;
clear N x q y;
clear fout1 fout2 fout3 fout4 fout5;
clear cout1 cout2 cout3;
clear flow_setpoint f w v Qp u k uk yk;
clear evidence_nodes_labels fault_nodes_labels all_nodes_labels;
clear Ne Nf Na node_sizes dag bnet i z f M ans W;

disp('#Training done!');
