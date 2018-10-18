clc; clear all; close all; rng('default');

%% Paths
% Here all functions and sub-functions needed to perform the simulation
% are added to the MATLAB path.

%restoredefaultpath();
addpath(genpath('dynamic_system'));
addpath(genpath('getters'));
addpath(genpath('setters'));
addpath(genpath('plots'));

%% System parameters
% Here the constants and the physical dimensions of the system are defined.

R    = 5;     % Radius of the tanks (cm)
Hmax = 50;    % Height of the tanks (cm)
r    = 0.635; % Radius of the pipes (cm)
h0   = 30;    % Height of the transmission pipes (cm)
mu   = 1;     % Flow correction term (-)
g    = 981;   % Gravity constant (cm/s^2)

% ***DO NOT EDIT [Begin]***
set_parameters(R, Hmax, r, h0, mu, g);
% ***DO NOT EDIT [End]***

%% Simulation time
% Here the simulation time is defined.

tstart = 0;   % Start time
tstop  = 500; % Stop time
Ts     = 0.1; % Sample time

% ***DO NOT EDIT [Begin]***
time = linspace(tstart, tstop, 1+tstop/Ts);
set_time(time);
% ***DO NOT EDIT [End]***

%% Flow rate from the pumps
% Here the flow rate behavior from the pumps P1 and P2 is defined.
%
% • pmaxflow(i) (i=1,2): is the maximum flow rate from the pump Pi.
% • pturnon(i)  (i=1,2): is the time when the pump Pi is switched on.
% • pturnoff(i) (i=1,2): is the time when the pump Pi is switched off.

%--------->[P1       ; P2       ]
pmaxflow = [80       ; 80       ]; % Qp1 and Qp2 in cm^3/s
pturnon  = [time(1)  ; time(1)  ]; % Time in seconds
pturnoff = [time(end); time(end)]; % Time in seconds

% ***DO NOT EDIT [Begin]***
set_pumps(pmaxflow, pturnon, pturnoff);
% ***DO NOT EDIT [End]***

%% Operation mode
% Here the operation mode of the valves (i.e., a case study) is defined.
%
% • If Kx=1 (x=p1,p2,a,b,13,23,1,2,3), then the valve Kx is defined as
% normally open.
% • If Kx=0 (x=p1,p2,a,b,13,23,1,2,3), then the valve Kx is defined as
% normally closed.

%--------------->[Kp1 Kp2 Ka  Kb  K13 K23 K1  K2  K3 ]
operation_mode = [ 1   1   0   0   1   1   0   0   1 ];

% ***DO NOT EDIT [Begin]***
set_operation_mode(operation_mode);
% ***DO NOT EDIT [End]***

%% Fault signals
% Here the fault signals are defined.
%
% • fmag(i)   (i=1,2,...,21): is the fault magnitude and must be betweeen [0,1].
% • ftype(i)  (i=1,2,...,21): is the fault type and must be 0 (stepwise) or 1 (driftwise).
% • fstart(i) (i=1,2,...,21): is the start time of the fault i.
% • fstop(i)  (i=1,2,...,21): is the stop time of the fault i.

%------->[Kp1 Kp2 Ka  Kb  K13 K23 K1  K2  K3  h1  h2  h3  u1  u2  Qa* Qb* Q13 Q23 Q1* Q2* Q3 ]
%------->[F1  F2  F3  F4  F5  F6  F7  F8  F9  F10 F11 F12 F13 F14 F15 F16 F17 F18 F19 F20 F21]
fmag   = [ 0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0 ];
ftype  = [ 0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0 ];
fstart = [150 150 150 150 150 150 150 150 150 150 150 150 150 150 150 150 150 150 150 150 150];
fstop  = [300 300 300 300 300 300 300 300 300 300 300 300 300 300 300 300 300 300 300 300 300];

% ***DO NOT EDIT [Begin]***
set_faults(fmag, ftype, fstart, fstop);
% ***DO NOT EDIT [End]***

%% System simulation
disp('#Running Sim3Tanks...');

% Initial conditions
x0 = [40 25 20]'; % [h1 h2 h3]' (cm)

% White noise
mean0 = 0.0; % Mean of the noises
stdw0 = 0.0; % Standard deviation of the process noise
stdx0 = 0.3; % Standard deviation of the output noise for the level sensors
stdq0 = 1.5; % Standard deviation of the output noise for the flow sensors

% Continuous variables of the three-tank system
N = length(get_time()); % Number of samples
x = zeros(3,N);  % States: x = [h1, h2, h3]'
q = zeros(9,N);  % Outflows: q = [u1, u2, Qa, Qb, Q13, Q23, Q1, Q2, Q3]'
y = zeros(12,N); % Measured outputs: y = [h1, h2, h3, u1, u2, Qa, Qb, Q13, Q23, Q1, Q2, Q3]'

% Discrete variables of the FDI system
% something...

% Discrete variables of the control system
% something...

% ***DO NOT EDIT [Begin]***
u  = [0 0]'; % First control signal (cm^3/s)(don't change)
% ***DO NOT EDIT [End]***

for k = 1 : N
    
    set_k(k); % Updates the sample number k
    
    f = get_faults(k); % Gets the fault signals at sample k
    w = get_process_noise([mean0 stdw0]); % Generates the process noises
    v = get_output_noise([mean0 stdx0], [mean0 stdq0]); % Generates the output noises
    
    Qp = get_pumps(k); % Gets the flow rate from the pumps at sample k
    
    % Three-tank system
    [y(:,k), x(:,k), q(:,k)] = three_tank_system_simulator(x0, u, f, w, v);
    
    % Control signal
    u = Qp;
    
end

%% Plots

disp('#Plotting Graphs...');

% Plot levels
plot_level('h1',x(1,:),y(1,:));
plot_level('h2',x(2,:),y(2,:));
plot_level('h3',x(3,:),y(3,:));

% Plot flows
plot_flow('u1', q(1,:), y(4,:));
plot_flow('u2', q(2,:), y(5,:));
plot_flow('Qa', q(3,:), y(6,:));
plot_flow('Qb', q(4,:), y(7,:));
plot_flow('Q13',q(5,:), y(8,:));
plot_flow('Q23',q(6,:), y(9,:));
plot_flow('Q1', q(7,:), y(10,:));
plot_flow('Q2', q(8,:), y(11,:));
plot_flow('Q3', q(9,:), y(12,:));

% Plot all levels and flows
plot_all_levels(x,y(1:3,:));
plot_all_flows(q,y(4:end,:));

% Plot behavior of the valves and fault signals
plot_valves();
plot_faults();
