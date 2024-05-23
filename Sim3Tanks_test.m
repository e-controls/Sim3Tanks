clc; clear; close all;


addpath(genpath('src'));

% Configuring time vector.
tstart = 0;   % Start time
tstop  = 500; % Stop time
Ts     = 0.1; % Sample time
time = tstart : Ts : tstop;

N = numel(time); % Number of samples

% Creating a Sim3Tanks object and setting it to the default model.
objSim3Tanks = createSim3Tanks();
objSim3Tanks.setDefaultModel();

% objSim3Tanks.Model.PhysicalParam.TankRadius=5;
% objSim3Tanks.Model.PhysicalParam.TankHeight=50;
% objSim3Tanks.Model.PhysicalParam.PipeRadius=0.6;
% objSim3Tanks.Model.PhysicalParam.TransPipeHeight=30;
% objSim3Tanks.Model.PhysicalParam.CorrectionTerm=1;
% objSim3Tanks.Model.PhysicalParam.GravityConstant=981;
% objSim3Tanks.Model.PhysicalParam.PumpMinFlow=0;
% objSim3Tanks.Model.PhysicalParam.PumpMaxFlow=120;

% To enable control of the valves Kp1 and Kp2 set this flags to true.
objSim3Tanks.Model.ValveSettings.Kp1.EnableControl = false;
objSim3Tanks.Model.ValveSettings.Kp2.EnableControl = false;

% A disturbance in tank 3, but in the default model the OperationMode field
% is 'Closed' and the EnableControl field is false, therefore the state of
% the valve Kp3 is maintained closed and, consequently, the value of the
% flow Qp3 has not effect on the system. To change this the EnableControl
% field must be set to true.
objSim3Tanks.Model.ValveSettings.Kp3.OperationMode = 'Closed';
objSim3Tanks.Model.ValveSettings.Kp3.EnableControl = false;
w = random('norm',0,0.1,[1 1000]);
d = [zeros(1,2000),(0.5*ones(1,1000)+w),zeros(1,2001)];
%d = 0.5*ones(size(time));

% Generating the pump flow
Qp1 = 80*ones(size(time));
Qp2 = 80*ones(size(time));
Qp3 = 80*ones(size(time));

% Fault signal generation. Here only fault f1 is enabled, the other faults
% have their EnabledSignal field set to false, therefore they do not affect
% the system.
objSim3Tanks.Model.FaultSettings.f1.EnableSignal = true;
f1 = 1./(1+exp(-(1/200)*(-2500:2500))); % sigmoid

objSim3Tanks.Model.FaultSettings.f2.EnableSignal = false;
f2 = 1./(1+exp(-(1/50)*(-500:4500))); % sigmoid

for k = 2 : N % k=1 conrresponds to initial condition

    fprintf('#Sim3Tanks. Running simulation (%d/%d)\n',k,N);

    % Simulating a control signal for the valves Kp1 and Kp2.
    u = rand(2,1);

    % There is no effect because the EnableControl field is false, to
    % change this it must be set to true outside of this loop.
    objSim3Tanks.Model.ValveSettings.Kp1.OpeningRate = u(1);
    objSim3Tanks.Model.ValveSettings.Kp2.OpeningRate = u(2);

    % A disturbance in tank 3 over time.
    objSim3Tanks.Model.ValveSettings.Kp3.OpeningRate = d(k);

    % Taking the fault magnitude over time.
    objSim3Tanks.Model.FaultSettings.f1.Magnitude = f1(k);

    % There is no effect because the EnableSignal field is false, to
    % change this it must be set to true outside of this loop.
    objSim3Tanks.Model.FaultSettings.f2.Magnitude = f2(k);

    % Process noise.
    objSim3Tanks.Model.ProcessNoise.EnableSignal = false;
    objSim3Tanks.Model.ProcessNoise.Magnitude = random('norm',0,0.1,[1 3]);

    % Measurement noise.
    objSim3Tanks.Model.MeasurementNoise.EnableSignal = true;
    yx = random('norm',0,0.2,[1 03]); % Level sensors
    yq = random('norm',0,0.6,[1 10]); % Flow sensors
    objSim3Tanks.Model.MeasurementNoise.Magnitude = [yx,yq];

    % Simulating the system.
    [y,x,q] = objSim3Tanks.simulateModel('Qp1',Qp1(k),'Qp2',Qp2(k),'Qp3',Qp3(k),'Tspan',Ts);

end
fprintf('#Sim3Tanks. The simulation is done!\n');

%% Plots

figure; hold on; grid on;
title('States');
X = objSim3Tanks.getStates();
plot(time,X.Variables);

figure; hold on; grid on;
title('Flows');
Q = objSim3Tanks.getFlows();
plot(time,Q.Variables);

figure; hold on; grid on;
title('Measurements');
Y = objSim3Tanks.getMeasurements();
plot(time,Y.Variables);

figure; hold on; grid on;
title('Valves');
K = objSim3Tanks.getValves();
plot(time,K.Variables);

figure; hold on; grid on;
title('Faults');
F = objSim3Tanks.getFaults();
plot(time,F.Variables);
