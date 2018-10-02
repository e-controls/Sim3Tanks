clc; clear all; close all; rng('default');

% ***DO NOT EDIT [Begin]***
try
    run('pre_settings');
catch
    error(['#The ',filename,'.slx file is not open or the ',blockname,' block does not exist in the current Simulink file.']);
end
% ***DO NOT EDIT [End]***

%% System parameters
% In this section are defined the physical dimensions of the three-tank
% system and the constants values.

R    = str2double(get_param(fullname,'editRR'));   % Tanks radius (cm)
Hmax = str2double(get_param(fullname,'editHmax')); % Tanks height (cm)
r    = str2double(get_param(fullname,'editR'));    % Pipes radius (cm)
h0   = str2double(get_param(fullname,'edith0'));   % Transmission pipes height (cm)
mi   = str2double(get_param(fullname,'editmi'));   % Flow correction term (-)
g    = str2double(get_param(fullname,'editg'));    % Gravity constant (cm/s^2)

% ***DO NOT EDIT [Begin]***
set_parameters(R, Hmax, r, h0, mi, g);
clear R Hmax r h0 mi g;
% ***DO NOT EDIT [End]***

%% Simulation time
% In this section the simulation time is set.

tstart = str2double(get_param(filename,'StartTime'));% Gets start time from Simulink
tstop  = str2double(get_param(filename,'StopTime'));% Gets stop time from Simulink
Ts     = str2double(get_param(fullname,'editTs'));% Gets time span of ode45 solver

% ***DO NOT EDIT [Begin]***
time = linspace(tstart, tstop, 1+tstop/Ts);
set_time(time);
clear tstart tstop Ts time;
% ***DO NOT EDIT [End]***

%% Operation mode
% In this section is defined the operation mode of the system valves:
% >> If Kx=1 (x=p1,p2,a,b,13,23,1,2,3), then the valve Kx is defined as normally open.
% >> If Kx=0 (x=p1,p2,a,b,13,23,1,2,3), then the valve Kx is defined as normally closed.

if strcmpi(get_param(fullname,'cboxKp1'),'on')
    Kp1 = 1;
else
    Kp1 = 0;
end

if strcmpi(get_param(fullname,'cboxKp2'),'on')
    Kp2 = 1;
else
    Kp2 = 0;
end

if strcmpi(get_param(fullname,'cboxKa'),'on')
    Ka = 1;
else
    Ka = 0;
end

if strcmpi(get_param(fullname,'cboxKb'),'on')
    Kb = 1;
else
    Kb = 0;
end

if strcmpi(get_param(fullname,'cboxK13'),'on')
    K13 = 1;
else
    K13 = 0;
end

if strcmpi(get_param(fullname,'cboxK23'),'on')
    K23 = 1;
else
    K23 = 0;
end

if strcmpi(get_param(fullname,'cboxK1'),'on')
    K1 = 1;
else
    K1 = 0;
end

if strcmpi(get_param(fullname,'cboxK2'),'on')
    K2 = 1;
else
    K2 = 0;
end

if strcmpi(get_param(fullname,'cboxK3'),'on')
    K3 = 1;
else
    K3 = 0;
end

operation_mode = [Kp1 Kp2 Ka Kb K13 K23 K1 K2 K3];

% ***DO NOT EDIT [Begin]***
set_operation_mode(operation_mode);
clear Kp1 Kp2 Ka Kb K13 K23 K1 K2 K3 operation_mode;
% ***DO NOT EDIT [End]***

%% Fault signals
% In this section the fault signals are set and generated.
% >> fmag(i) (i=1,2,...,21): is the fault magnitue and must be betweeen [0,1].
% >> ftype(i) (i=1,2,...,21): is the fault type and must be 0 (stepwise) or 1 (driftwise).
% >> fstart(i) (i=1,2,...,21): is the start time of the fault i.
% >> fstop(i) (i=1,2,...,21): is the stop time of the fault i.

% [Kp1 Kp2 Ka  Kb  K13 K23 K1  K2  K3  h1  h2  h3  u1  u2  Qa  Qb  Q13 Q23 Q1  Q2  Q3 ]
% [F1  F2  F3  F4  F5  F6  F7  F8  F9  F10 F11 F12 F13 F14 F15 F16 F17 F18 F19 F20 F21]
fmag   = zeros(1,21);
ftype  = zeros(1,21);
fstart = zeros(1,21);
fstop  = zeros(1,21);

% Fault F1 ---------------------------------------------------------------+
fmag(1) = str2double(get_param(fullname,'f1mag'));
if strcmpi(get_param(fullname,'f1type'),'Stepwise')
    ftype(1) = 0;
else
    ftype(1) = 1;
end
fstart(1) = str2double(get_param(fullname,'f1start'));
fstop(1)  = str2double(get_param(fullname,'f1stop'));

% Fault F2 ---------------------------------------------------------------+
fmag(2) = str2double(get_param(fullname,'f2mag'));
if strcmpi(get_param(fullname,'f2type'),'Stepwise')
    ftype(2) = 0;
else
    ftype(2) = 1;
end
fstart(2) = str2double(get_param(fullname,'f2start'));
fstop(2)  = str2double(get_param(fullname,'f2stop'));

% Fault F3 ---------------------------------------------------------------+
fmag(3) = str2double(get_param(fullname,'f3mag'));
if strcmpi(get_param(fullname,'f3type'),'Stepwise')
    ftype(3) = 0;
else
    ftype(3) = 1;
end
fstart(3) = str2double(get_param(fullname,'f3start'));
fstop(3)  = str2double(get_param(fullname,'f3stop'));

% Fault F4 ---------------------------------------------------------------+
fmag(4) = str2double(get_param(fullname,'f4mag'));
if strcmpi(get_param(fullname,'f4type'),'Stepwise')
    ftype(4) = 0;
else
    ftype(4) = 1;
end
fstart(4) = str2double(get_param(fullname,'f4start'));
fstop(4)  = str2double(get_param(fullname,'f4stop'));

% Fault F5 ---------------------------------------------------------------+
fmag(5) = str2double(get_param(fullname,'f5mag'));
if strcmpi(get_param(fullname,'f5type'),'Stepwise')
    ftype(5) = 0;
else
    ftype(5) = 1;
end
fstart(5) = str2double(get_param(fullname,'f5start'));
fstop(5)  = str2double(get_param(fullname,'f5stop'));

% Fault F6 ---------------------------------------------------------------+
fmag(6) = str2double(get_param(fullname,'f6mag'));
if strcmpi(get_param(fullname,'f6type'),'Stepwise')
    ftype(6) = 0;
else
    ftype(6) = 1;
end
fstart(6) = str2double(get_param(fullname,'f6start'));
fstop(6)  = str2double(get_param(fullname,'f6stop'));

% Fault F7 ---------------------------------------------------------------+
fmag(7) = str2double(get_param(fullname,'f7mag'));
if strcmpi(get_param(fullname,'f7type'),'Stepwise')
    ftype(7) = 0;
else
    ftype(7) = 1;
end
fstart(7) = str2double(get_param(fullname,'f7start'));
fstop(7)  = str2double(get_param(fullname,'f7stop'));

% Fault F8 ---------------------------------------------------------------+
fmag(8) = str2double(get_param(fullname,'f8mag'));
if strcmpi(get_param(fullname,'f8type'),'Stepwise')
    ftype(8) = 0;
else
    ftype(8) = 1;
end
fstart(8) = str2double(get_param(fullname,'f8start'));
fstop(8)  = str2double(get_param(fullname,'f8stop'));

% Fault F9 ---------------------------------------------------------------+
fmag(9) = str2double(get_param(fullname,'f9mag'));
if strcmpi(get_param(fullname,'f9type'),'Stepwise')
    ftype(9) = 0;
else
    ftype(9) = 1;
end
fstart(9) = str2double(get_param(fullname,'f9start'));
fstop(9)  = str2double(get_param(fullname,'f9stop'));

% Fault F10 --------------------------------------------------------------+
fmag(10) = str2double(get_param(fullname,'f10mag'));
if strcmpi(get_param(fullname,'f10type'),'Stepwise')
    ftype(10) = 0;
else
    ftype(10) = 1;
end
fstart(10) = str2double(get_param(fullname,'f10start'));
fstop(10)  = str2double(get_param(fullname,'f10stop'));

% Fault F11 --------------------------------------------------------------+
fmag(11) = str2double(get_param(fullname,'f11mag'));
if strcmpi(get_param(fullname,'f11type'),'Stepwise')
    ftype(11) = 0;
else
    ftype(11) = 1;
end
fstart(11) = str2double(get_param(fullname,'f11start'));
fstop(11)  = str2double(get_param(fullname,'f11stop'));

% Fault F12 --------------------------------------------------------------+
fmag(12) = str2double(get_param(fullname,'f12mag'));
if strcmpi(get_param(fullname,'f12type'),'Stepwise')
    ftype(12) = 0;
else
    ftype(12) = 1;
end
fstart(12) = str2double(get_param(fullname,'f12start'));
fstop(12)  = str2double(get_param(fullname,'f12stop'));

% Fault F13 --------------------------------------------------------------+
fmag(13) = str2double(get_param(fullname,'f13mag'));
if strcmpi(get_param(fullname,'f13type'),'Stepwise')
    ftype(13) = 0;
else
    ftype(13) = 1;
end
fstart(13) = str2double(get_param(fullname,'f13start'));
fstop(13)  = str2double(get_param(fullname,'f13stop'));

% Fault F14 --------------------------------------------------------------+
fmag(14) = str2double(get_param(fullname,'f14mag'));
if strcmpi(get_param(fullname,'f14type'),'Stepwise')
    ftype(14) = 0;
else
    ftype(14) = 1;
end
fstart(14) = str2double(get_param(fullname,'f14start'));
fstop(14)  = str2double(get_param(fullname,'f14stop'));

% Fault F15 --------------------------------------------------------------+
fmag(15) = str2double(get_param(fullname,'f15mag'));
if strcmpi(get_param(fullname,'f15type'),'Stepwise')
    ftype(15) = 0;
else
    ftype(15) = 1;
end
fstart(15) = str2double(get_param(fullname,'f15start'));
fstop(15)  = str2double(get_param(fullname,'f15stop'));

% Fault F16 --------------------------------------------------------------+
fmag(16) = str2double(get_param(fullname,'f16mag'));
if strcmpi(get_param(fullname,'f16type'),'Stepwise')
    ftype(16) = 0;
else
    ftype(16) = 1;
end
fstart(16) = str2double(get_param(fullname,'f16start'));
fstop(16)  = str2double(get_param(fullname,'f16stop'));

% Fault F17 --------------------------------------------------------------+
fmag(17) = str2double(get_param(fullname,'f17mag'));
if strcmpi(get_param(fullname,'f17type'),'Stepwise')
    ftype(17) = 0;
else
    ftype(17) = 1;
end
fstart(17) = str2double(get_param(fullname,'f17start'));
fstop(17)  = str2double(get_param(fullname,'f17stop'));

% Fault F18 --------------------------------------------------------------+
fmag(18) = str2double(get_param(fullname,'f18mag'));
if strcmpi(get_param(fullname,'f18type'),'Stepwise')
    ftype(18) = 0;
else
    ftype(18) = 1;
end
fstart(18) = str2double(get_param(fullname,'f18start'));
fstop(18)  = str2double(get_param(fullname,'f18stop'));

% Fault F19 --------------------------------------------------------------+
fmag(19) = str2double(get_param(fullname,'f19mag'));
if strcmpi(get_param(fullname,'f19type'),'Stepwise')
    ftype(19) = 0;
else
    ftype(19) = 1;
end
fstart(19) = str2double(get_param(fullname,'f19start'));
fstop(19)  = str2double(get_param(fullname,'f19stop'));

% Fault F20 --------------------------------------------------------------+
fmag(20) = str2double(get_param(fullname,'f20mag'));
if strcmpi(get_param(fullname,'f20type'),'Stepwise')
    ftype(20) = 0;
else
    ftype(20) = 1;
end
fstart(20) = str2double(get_param(fullname,'f20start'));
fstop(20)  = str2double(get_param(fullname,'f20stop'));

% Fault F21 --------------------------------------------------------------+
fmag(21) = str2double(get_param(fullname,'f21mag'));
if strcmpi(get_param(fullname,'f21type'),'Stepwise')
    ftype(21) = 0;
else
    ftype(21) = 1;
end
fstart(21) = str2double(get_param(fullname,'f21start'));
fstop(21)  = str2double(get_param(fullname,'f21stop'));

% ***DO NOT EDIT [Begin]***
set_faults(fmag, ftype, fstart, fstop);
clear fmag ftype fstart fstop
if strcmpi(get_param(fullname,'cboxFromWS'),'on')
    run('fault_signals');
else
    F = get_faults()';
    t = get_time()';
    F1.signals.values = F(:,1);
    F1.time = t;
    F2.signals.values = F(:,2);
    F2.time = t;
    F3.signals.values = F(:,3);
    F3.time = t;
    F4.signals.values = F(:,4);
    F4.time = t;
    F5.signals.values = F(:,5);
    F5.time = t;
    F6.signals.values = F(:,6);
    F6.time = t;
    F7.signals.values = F(:,7);
    F7.time = t;
    F8.signals.values = F(:,8);
    F8.time = t;
    F9.signals.values = F(:,9);
    F9.time = t;
    F10.signals.values = F(:,10);
    F10.time = t;
    F11.signals.values = F(:,11);
    F11.time = t;
    F12.signals.values = F(:,12);
    F12.time = t;
    F13.signals.values = F(:,13);
    F13.time = t;
    F14.signals.values = F(:,14);
    F14.time = t;
    F15.signals.values = F(:,15);
    F15.time = t;
    F16.signals.values = F(:,16);
    F16.time = t;
    F17.signals.values = F(:,17);
    F17.time = t;
    F18.signals.values = F(:,18);
    F18.time = t;
    F19.signals.values = F(:,19);
    F19.time = t;
    F20.signals.values = F(:,20);
    F20.time = t;
    F21.signals.values = F(:,21);
    F21.time = t;
    clear F t;
end
% ***DO NOT EDIT [End]***

disp('#Data loaded successfully.');
