clc; clear; close all;

% Add internal dependency paths
addpath(genpath('..\..\src'));
addpath(genpath('..\..\addons'));

% Set time vector
tstart = 0;   % Start time
tstop  = 120; % Stop time
Ts     = 0.1; % Sample time
time   = tstart : Ts : tstop;

N = numel(time); % Number of samples

% Create a Sim3Tanks object
tts = createSim3Tanks();

%% System parameters
tts.Model.PhysicalParam.TankRadius = 5;
tts.Model.PhysicalParam.TankHeight = 50;
tts.Model.PhysicalParam.PipeRadius = 0.6;
tts.Model.PhysicalParam.TransPipeHeight = 30;
tts.Model.PhysicalParam.CorrectionTerm  = 1;
tts.Model.PhysicalParam.GravityConstant = 981;
tts.Model.PhysicalParam.PumpMinFlow = 0;
tts.Model.PhysicalParam.PumpMaxFlow = 120;

%% Valve settings
tts.Model.ValveSettings.Kp1.OperationMode = 'Open';
tts.Model.ValveSettings.Kp1.EnableControl = false;
tts.Model.ValveSettings.Kp2.OperationMode = 'Open';
tts.Model.ValveSettings.Kp2.EnableControl = false;
tts.Model.ValveSettings.K13.OperationMode = 'Open';
tts.Model.ValveSettings.K13.EnableControl = false;
tts.Model.ValveSettings.K23.OperationMode = 'Open';
tts.Model.ValveSettings.K23.EnableControl = false;
tts.Model.ValveSettings.K3.OperationMode  = 'Open';
tts.Model.ValveSettings.K3.EnableControl  = false;

%% Fault settings
tts.Model.FaultSettings.f1.EnableSignal  = true; % Loss Of Effectiveness in Kp1
tts.Model.FaultSettings.f2.EnableSignal  = true; % Loss Of Effectiveness in Kp1
tts.Model.FaultSettings.f6.EnableSignal  = true; % Clogging Q13
tts.Model.FaultSettings.f9.EnableSignal  = true; % Leakage Q2
tts.Model.FaultSettings.f10.EnableSignal = true; % Clogging Q3
tts.Model.FaultSettings.f11.EnableSignal = true; % Sensor h1
tts.Model.FaultSettings.f12.EnableSignal = true; % Sensor h2
tts.Model.FaultSettings.f19.EnableSignal = true; % Sensor Q13
tts.Model.FaultSettings.f20.EnableSignal = true; % Sensor Q23
tts.Model.FaultSettings.f23.EnableSignal = true; % Sensor Q3

%% Setting simulation scenario

% Setpoint for level h1 and h2 (cm)
sp_h1 = stepSignal([10 14],[0 20],time);
sp_h2 = stepSignal([10 16],[0 60],time);

sp = [sp_h1;sp_h2];

% Fault signals
f1 = zeros(size(time)); % stepSignal(1,50,time);
f2 = zeros(size(time));
f6 = zeros(size(time));
f9 = zeros(size(time));
f10 = zeros(size(time));
f11 = zeros(size(time));
f12 = zeros(size(time));
f19 = zeros(size(time));
f20 = zeros(size(time));
f23 = zeros(size(time));

tts.Model.FaultSettings.f11.Offset = 0;
tts.Model.FaultSettings.f12.Offset = 0;
tts.Model.FaultSettings.f19.Offset = 0;
tts.Model.FaultSettings.f20.Offset = 0;
tts.Model.FaultSettings.f23.Offset = 0;

% Initial condition
tts.Model.InitialCondition = [10 10 8];
uk(:,1) = [0;0]; % First control signal

%% System simulation

fprintf([getMessage('tag'),'Starting simulation...\n']);

for k = 2 : N % k=1 conrresponds to initial condition

    fprintf([getMessage('tag'),'Simulating NONLINEAR plant (%d/%d)\n'],k,N);

    % +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    % #BEGIN: Continuous Nonlinear Plant ++++++++++++++++++++++++++++++++++
    % +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    % D/A converter: uk->u(t)
    u = uk(:,k-1);

    % Control signal for the valves Kp1 and Kp2.
    % tts.Model.ValveSettings.Kp1.OpeningRate = 1;
    % tts.Model.ValveSettings.Kp2.OpeningRate = 1;

    % Taking the fault magnitude over time.
    tts.Model.FaultSettings.f1.Magnitude = f1(k);
    tts.Model.FaultSettings.f2.Magnitude = f2(k);
    tts.Model.FaultSettings.f6.Magnitude = f6(k);
    tts.Model.FaultSettings.f9.Magnitude = f9(k);
    tts.Model.FaultSettings.f10.Magnitude = f10(k);
    tts.Model.FaultSettings.f11.Magnitude = f11(k);
    tts.Model.FaultSettings.f12.Magnitude = f12(k);
    tts.Model.FaultSettings.f19.Magnitude = f19(k);
    tts.Model.FaultSettings.f20.Magnitude = f20(k);
    tts.Model.FaultSettings.f23.Magnitude = f23(k);

    % Process noise.
    tts.Model.ProcessNoise.EnableSignal = false;
    tts.Model.ProcessNoise.Magnitude = random('norm',0,0.1,[1 3]);

    % Measurement noise.
    tts.Model.MeasurementNoise.EnableSignal = false;
    yx = random('norm',0,0.2,[1 03]); % Level Sensors
    yq = random('norm',0,0.6,[1 10]); % Flow Sensors
    tts.Model.MeasurementNoise.Magnitude = [yx,yq];

    % Nonlinear dynamic model.
    [yt,xt,qt] = tts.simulateModel('Qp1',u(1),'Qp2',u(2),'Tspan',Ts);

    % Measured output vector for this case: y = [h1, h2, Q13, Q23, Q3]'
    y = [yt(1),yt(2),yt(9),yt(10),yt(13)]';

    % A/D converter: y(t)->yk
    yk(:,k) = y; %#ok<*SAGROW>

    % ---------------------------------------------------------------------
    % #END: Continuous Nonlinear Plant ------------------------------------
    % ---------------------------------------------------------------------


    % +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    % #BEGIN: Digital PID control for levels h1 and h2 ++++++++++++++++++++
    % +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    if(k>2)
        ek_past = sp(:,k-2:k) - yk(1:2,k-2:k); % [e(k-2) e(k-1) e(k)]
        uk_past = uk(:,k-2:k-1);               % [u(k-2) u(k-1)]
        uk(:,k) = pidLevelControl(ek_past,uk_past,Ts);
    else
        uk(:,k) = zeros(2,1);
    end
    % ---------------------------------------------------------------------
    % #END: Digital PID control for levels h1 and h2 ----------------------
    % ---------------------------------------------------------------------

end

fprintf([getMessage('tag'),'The simulation is done!\n']);

% Preparing variables

X = tts.getStateVariables();
Q = tts.getFlowVariables();
Y = tts.getSensorMeasurements();
K = tts.getValveSignals();
F = tts.getFaultSignals();

time = tts.interpolSimulationTime([tstart tstop]);

%% Plots

fprintf([getMessage('tag'),'Plotting Graphs...\n']);

MarkIdx = 1:round(N/20):N;

% Pump signals (Actuators)
figure();
subplot(2,1,1); hold on; grid on;
plot(time,Q.Q1in,'-*r','MarkerIndices',MarkIdx);
legend('$Q_{1in}$',...
    'Interpreter','latex',...
    'Orientation','horizontal',...
    'Location','best',...
    'FontSize',12);
xlabel('time (s)','Interpreter','latex');
ylabel('inflow ($\mathrm{cm^3/s}$)','Interpreter','latex');

subplot(2,1,2); hold on; grid on;
plot(time,Q.Q2in,'-*r','MarkerIndices',MarkIdx);
legend('$Q_{2in}$',...
    'Interpreter','latex',...
    'Orientation','horizontal',...
    'Location','best',...
    'FontSize',12);
xlabel('time (s)','Interpreter','latex');
ylabel('inflow ($\mathrm{cm^3/s}$)','Interpreter','latex');

% Levels
figure();
subplot(3,1,1); hold on; grid on;
p0 = plot(time,sp(1,:),'--ok','MarkerIndices',MarkIdx);
p1 = plot(time,Y.h1,'.m');
p2 = plot(time,X.h1,'-*r','MarkerIndices',MarkIdx);
legend([p0 p1 p2],'$x_\mathrm{1ref}$','$\tilde{x}_{1}$','$x_{1}$',...
    'Interpreter','latex',...
    'Orientation','horizontal',...
    'Location','best',...
    'FontSize',12)
xlabel('time (s)','Interpreter','latex');
ylabel('level (cm)','Interpreter','latex');

subplot(3,1,2); hold on; grid on;
p0 = plot(time,sp(2,:),'--ok','MarkerIndices',MarkIdx);
p1 = plot(time,Y.h2,'.m');
p2 = plot(time,X.h2,'-*r','MarkerIndices',MarkIdx);
legend([p0 p1 p2],'$x_\mathrm{2ref}$','$\tilde{x}_{2}$','$x_{2}$',...
    'Interpreter','latex',...
    'Orientation','horizontal',...
    'Location','best',...
    'FontSize',12);
xlabel('time (s)','Interpreter','latex');
ylabel('level (cm)','Interpreter','latex');

subplot(3,1,3); hold on; grid on;
p1 = plot(time,X.h3,'-*r','MarkerIndices',MarkIdx);
legend(p1,'$x_{3}$',...
    'Interpreter','latex',...
    'Orientation','horizontal',...
    'Location','best',...
    'FontSize',12)
xlabel('time (s)','Interpreter','latex');
ylabel('level (cm)','Interpreter','latex');

% Flows
figure();
subplot(3,1,1); hold on; grid on;
p1 = plot(time,Y.Q13,'.m');
p2 = plot(time,Q.Q13,'-*r','MarkerIndices',MarkIdx);
legend([p1 p2],'$\tilde{Q}_{13}$','$Q_{13}$',...
    'Interpreter','latex',...
    'Orientation','horizontal',...
    'Location','best',...
    'FontSize',12)
xlabel('time (s)','Interpreter','latex');
ylabel('flow ($\mathrm{cm^3/s}$)','Interpreter','latex');

subplot(3,1,2); hold on; grid on;
p1 = plot(time,Y.Q23,'.m');
p2 = plot(time,Q.Q23,'-*r','MarkerIndices',MarkIdx);
legend([p1 p2],'$\tilde{Q}_{23}$','$Q_{23}$',...
    'Interpreter','latex',...
    'Orientation','horizontal',...
    'Location','best',...
    'FontSize',12)
xlabel('time (s)','Interpreter','latex');
ylabel('flow ($\mathrm{cm^3/s}$)','Interpreter','latex');

subplot(3,1,3); hold on; grid on;
p1 = plot(time,Y.Q3,'.m');
p2 = plot(time,Q.Q3,'-*r','MarkerIndices',MarkIdx);
legend([p1 p2],'$\tilde{Q}_{3}$','$Q_{3}$',...
    'Interpreter','latex',...
    'Orientation','horizontal',...
    'Location','best',...
    'FontSize',12)
xlabel('time (s)','Interpreter','latex');
ylabel('flow ($\mathrm{cm^3/s}$)','Interpreter','latex');
