function [varargout] = get_default_param(field)

% Call Function: [param,hi,pump1,pump2,noise,tsim,controlsys,fdisys,fault,dK,plots] = get_default_param();

start_time  = 0;
stop_time   = 400;
sample_time = 0.1;

%% Parameters (field1)
R    = 5;
Hmax = 50;
r    = 0.635;
h0   = 30;
mi   = 1;
g    = 981;

param = [R, Hmax, r, h0, mi, g];

%% Initial condition (field2)
h1_0 = 40;
h2_0 = 25;
h3_0 = 20;

hi = [h1_0 h2_0 h3_0];

%% Pump 1 (field3)
Qp1closedloop = 80;
Qp1openloop   = 80;
Qp1start      = start_time;
Qp1stop       = stop_time;

pump1 = [Qp1closedloop Qp1openloop Qp1start Qp1stop];

%% Pump 2 (field4)
Qp2closedloop = 80;
Qp2openloop   = 80;
Qp2start      = start_time;
Qp2stop       = stop_time;

pump2 = [Qp2closedloop Qp2openloop Qp2start Qp2stop];

%% White noise (field5)
wmean  = 0;
wstd   = 0;
vhmean = 0;
vhstd  = 0.3;
vqmean = 0;
vqstd  = 1.5;

noise = [wmean wstd vhmean vhstd vqmean vqstd];

%% Time simulation (field6)
tsim = [start_time stop_time sample_time];

%% Control system (field7)
controlyes = 0;
setpoint = 0;

controlsys = [controlyes setpoint];

%% FDI system (field8)
fdiyes = 0;
Ts = sample_time;

fdisys = [fdiyes Ts];

%% Fault signals (field9)
fmag   = 0;
ftype  = 0;
fstart = 150;
fstop  = 300;

fault = [fmag ftype fstart fstop];

%% Default behavior (field10)
Kp1 = 1;
Kp2 = 1;
Ka  = 0;
Kb  = 0;
K13 = 1;
K23 = 1;
K1  = 0;
K2  = 0;
K3  = 1;

dK = [Kp1,Kp2,Ka,Kb,K13,K23,K1,K2,K3];

%% Plots (field11)

plevel = 1;
pflow  = 1;
pvalve = 1;
pfault = 1;

slevel = 1;
sflow  = 1;
svalve = 1;
sfault = 1;

plots = [plevel pflow pvalve pfault slevel sflow svalve sfault];

if(nargin()==0)
    varargout{1}  = param;
    varargout{2}  = hi;
    varargout{3}  = pump1;
    varargout{4}  = pump2;
    varargout{5}  = noise;
    varargout{6}  = tsim;
    varargout{7}  = controlsys;
    varargout{8}  = fdisys;
    varargout{9}  = fault;
    varargout{10} = dK;
    varargout{11} = plots;
else
    switch lower(field)
        case 'field1'
            varargout{1} = param;
        case 'field2'
            varargout{1} = hi;
        case 'field3'
            varargout{1} = pump1;
        case 'field4'
            varargout{1} = pump2;
        case 'field5'
            varargout{1} = noise;
        case 'field6'
            varargout{1} = tsim;
        case 'field7'
            varargout{1} = controlsys;
        case 'field8'
            varargout{1} = fdisys;
        case 'field9'
            varargout{1} = fault;
        case 'field10'
            varargout{1} = dK;
        case 'field11'
            varargout{1} = plots;
    end
    
end
