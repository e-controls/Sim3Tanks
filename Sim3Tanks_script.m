clc; clear all; close all; rng('default');

%% Paths
% In this section all paths and subpaths needed to run the simulation are loaded.

%restoredefaultpath();
addpath(genpath('three_tank_system'));
addpath(genpath('control_system'));
addpath(genpath('fdi_system'));

%% Simulation time
% In this section the simulation time is set.

tstart = 0;   % Start time
tstop  = 500; % Stop time
Ts     = 0.1; % Sample time

% ***DO NOT EDIT [Begin]***
t = linspace(tstart, tstop, 1+tstop/Ts);
set_time(t);
% ***DO NOT EDIT [End]***

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

%% Operation mode
% In this section is defined the operation mode of the system valves:
% >> If Kx=1 (x=p1,p2,a,b,13,23,1,2,3), then the valve Kx is defined as normally open.
% >> If Kx=0 (x=p1,p2,a,b,13,23,1,2,3), then the valve Kx is defined as normally closed.

%--------------->[Kp1 Kp2 Ka  Kb  K13 K23 K1  K2  K3 ]
operation_mode = [ 1   1   0   0   1   1   0   0   1 ];

% ***DO NOT EDIT [Begin]***
set_operation_mode(operation_mode);
% ***DO NOT EDIT [End]***

%% Flow from pumps P1 and P2
%In this section are defined the flow from pumps P1 and P2.
% >> pmaxflow(i) (i=1,2): is the maximum flow from pump Pi.
% >> pturnon(i) (i=1,2): is the time when the pump Pi is switched on.
% >> pturnoff(i) (i=1,2): is the time when the pump Pi is switched off.

%--------->[P1     P2    ]
pmaxflow = [80     80    ]; % Qp1 and Qp2 in cm^3/s
pturnon  = [t(1)   t(1)  ]; % time in seconds
pturnoff = [t(end) t(end)]; % time in seconds

% ***DO NOT EDIT [Begin]***
set_pumps(pmaxflow, pturnon, pturnoff);
% ***DO NOT EDIT [End]***

%% Fault signals
% In this section the fault signals are set and generated.
% >> fmag(i) (i=1,2,...,21): is the fault magnitue and must be betweeen [0,1].
% >> ftype(i) (i=1,2,...,21): is the fault type and must be 0 (stepwise) or 1 (driftwise).
% >> fstart(i) (i=1,2,...,21): is the start time of the fault i.
% >> fstop(i) (i=1,2,...,21): is the stop time of the fault i.

%------->[Kp1 Kp2 Ka* Kb* K13 K23 K1  K2  K3  h1  h2  h3  u1  u2  Qa*  Qb*  Q13  Q23 Q1*  Q2*  Q3 ]
%------->[F1  F2  F3* F4* F5  F6  F7  F8  F9  F10 F11 F12 F13 F14 F15* F16* F17  F18 F19* F20* F21]
fmag   = [ 1   0   0   0   0   0   0   0   0   0   0   0   0   0   0    0    0    0   0    0    0 ];
ftype  = [ 1   0   0   0   0   0   0   0   0   0   0   0   0   0   0    0    0    0   0    0    0 ];
fstart = [150 150 150 150 150 150 150 150 150 150 150 150 150 150 150  150  150  150 150  150  150];
fstop  = [300 300 300 300 300 300 300 300 300 300 300 300 300 300 300  300  300  300 300  300  300];

% ***DO NOT EDIT [Begin]***
set_faults(fmag, ftype, fstart, fstop);
% ***DO NOT EDIT [End]***

%% System simulation
disp('#Running Sim3Tanks...');

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
fout1 = zeros(15,N); % Faults probability: p(j) = [p(Fi|Z1,Z2,...,Z8)]' (j=1,2,...15)(i=1,2,5,6,...,14,17,18,21)
fout2 = zeros(08,N); % GLR decision functions: g = [g1, g2, g3, g4, g5, g6, g7, g8]'
fout3 = zeros(08,N); % Residual signals computed by UKF: y-yhat = [r1, r2, r3, r4, r5, r6, r7, r8]'
fout4 = zeros(08,N); % Estimated outputs by UKF: yhat = [h1, h2, h3, u1, u2, Q13, Q23, Q3]'
fout5 = zeros(08,N); % Threshold crossing vector: z = [z1, z2, z3, z4, z5, z6, z7, z8]'

% Discrete control system variables
cout1 = zeros(2,N); % Control signal: uk = [u1, u2]'
cout2 = zeros(1,N); % Not used in this case
cout3 = zeros(1,N); % Not used in this case

% Desired setpoint for level h1 and h2
setpoint_h1 = get_setpoint([4 2],[0 200]); % h1 (cm)
setpoint_h2 = get_setpoint([3 1],[0 300]); % h2 (cm)

level_setpoint = [setpoint_h1 ; setpoint_h2];

% Desired setpoint for flow Q3
flow_setpoint = get_setpoint([80 120 40],[0 150 300]); % Flow Q3 (cm^3/s)

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
    %[cout1(:,k),cout2(:,k),cout3(:,k)] = level_controller(level_setpoint(:,k), Qp, yk);
    [cout1(:,k),cout2(:,k),cout3(:,k)] = flow_controller(flow_setpoint(:,k), Qp, yk);
    
    uk = cout1(:,k);
    
    % FDI system
    [fout1(:,k),fout2(:,k),fout3(:,k),fout4(:,k),fout5(:,k)] = fdi_system(uk, yk);
    
    % D/A converter
    u = uk;
    
end

%% Plots
p = fout1;       % Vector of fault Probabilities (15x1)
g = fout2;       % GLR decision functions (8x1)
residue = fout3; % Residual signals (8x1)
yhat = fout4;    % Estimated outputs by UKF (8x1)
z = fout5;       % Threshold crossing vector (8x1)

disp('#Plotting Graphs...');

plot_residues(y,yhat,residue);
plot_decision_funcs(g);
plot_probabilities(p);

plot_level('h1',x(1,:),y(1,:));
plot_level('h2',x(2,:),y(2,:));
plot_level('h3',x(3,:),y(3,:));

plot_flow('u1', q(1,:), y(4,:));
plot_flow('u2', q(2,:), y(5,:));
plot_flow('Qa', q(3,:), y(6,:));
plot_flow('Qb', q(4,:), y(7,:));
plot_flow('Q13',q(5,:), y(8,:));
plot_flow('Q23',q(6,:), y(9,:));
plot_flow('Q1', q(7,:), y(10,:));
plot_flow('Q2', q(8,:), y(11,:));
plot_flow('Q3', q(9,:), y(12,:));

plot_all_levels(x,y(1:3,:));
plot_all_flows(q,y(4:end,:));

plot_valves();
plot_faults();

