function [y,x,q] = simulateModel(varargin)
% simulateModel is a Sim3Tanks function. This function simulates the
% dynamic behavior of the three-tank system.
%
% The input parameter must follow the pair ('NAME',VALUE), where NAME must
% be Qp1, Qp2, Qp3, or Tspan, and VALUE must be numeric type.
%
% If the pair ('Qp1',VALUE1) is omitted, then the declared value in the
% field objSim3Tanks.Model.PhysicalParam.PumpMaxFlow is used as default.
% The same is valid for the pairs ('Qp2',VALUE2) and ('Qp3',VALUE3). For
% the pair ('Tspan',VALUE), the default value is 0.1.
%
% NOTE: It is highly recommended to use simulation time increment as Tspan.
%
% Examples of how to call the function:
% 1) simulateModel() : default values are used.
% 2) simulateModel('Qp1',100) : only the value of Qp1 is updated to 100.
% 3) simulateModel('Qp2',110,'Tspan',0.2) : only the values of Qp2 and
% Tspan are updated to 110 and 0.2, respectively.
% 4) simulateModel('Qp1',100,'Qp2',110,'Qp3',120,'Tspan',0.1) : all
% possible values are updated.

% Written by Arllem Farias, January/2024.
% Last update May/2024 by Arllem Farias.

%==========================================================================

if(mod(nargin(),2) == 0)
    error(getMessage('ERR020'));
else
    objSim3Tanks = varargin{1};
end

%==========================================================================

[Param,ID] = checkPhysicalParam(objSim3Tanks);

Rtank = Param.(ID{1});
Hmax  = Param.(ID{2});
Rpipe = Param.(ID{3});
h0    = Param.(ID{4});
mu    = Param.(ID{5});
g     = Param.(ID{6});
Qmin  = Param.(ID{7});
Qmax  = Param.(ID{8});

Sc = pi()*(Rtank^2); % Cross-sectional area of the tanks (cm^2)
S  = pi()*(Rpipe^2); % Cross-sectional area of the pipes (cm^2)
Beta = mu*S*sqrt(2*g); % Constant value

%==========================================================================

% Default options
options.QP1 = Qmax;
options.QP2 = Qmax;
options.QP3 = Qmax;
options.TSPAN = 0.1;

% Check input options
for i = 2 : 2 : nargin()
    name = upper(varargin{i});
    if(isfield(options,name))
        options.(name) = varargin{i+1};
    else
        error(getMessage('ERR003'));
    end
end

% New options
Qp1 = options.QP1;
Qp2 = options.QP2;
Qp3 = options.QP3;
Tspan = options.TSPAN;

%==========================================================================

opMode  = checkOperationMode(objSim3Tanks);
[v,vID] = checkEnabledValves(objSim3Tanks);
[f,fID] = checkEnabledFaults(objSim3Tanks);

K = zeros(size(opMode));

% ID = {'Kp1';'Kp2';'Kp3';'Ka';'Kb';'K13';'K23';'K1';'K2';'K3'};
for i = 1 : numel(opMode)
    OP = opMode(i);
    EC = isempty(vID{i});
    EF = isempty(fID{i});

    % State machine to select the valve behavior
    if(~OP && EC && EF || OP && EC && EF)
        % fprintf('STATE 1 : %s = OP\n',ID{i});
        K(i) = opMode(i);

    elseif(~OP && EC && ~EF)
        % fprintf('STATE 2 : %s = f\n',ID{i});
        K(i) = f(i);

    elseif(~OP && ~EC && EF || OP && ~EC && EF)
        % fprintf('STATE 3 : %s = K\n',ID{i});
        K(i) = v(i);

    elseif(~OP && ~EC && ~EF || OP && ~EC && ~EF)
        % fprintf('STATE 4 : %s = K*(1-f)\n',ID{i});
        K(i) = v(i)*(1-f(i));

    elseif(OP && EC && ~EF)
        % fprintf('STATE 5 : %s = 1-f\n',ID{i});
        K(i) = 1-f(i);

    else % Invalid state
        error(getMessage('ERR000'));
    end
end

%==========================================================================

[pNoise,mNoise] = checkEnabledNoises(objSim3Tanks);

%==========================================================================

x = objSim3Tanks.getInternalStateVariables();

if(isempty(x))

    Nx = numel(Sim3TanksModel.LIST_OF_STATES);
    Nq = numel(Sim3TanksModel.LIST_OF_FLOWS);
    x  = objSim3Tanks.Model.InitialCondition;

    objSim3Tanks.setInternalStateVariables(x);
    objSim3Tanks.setInternalFlowVariables(zeros(1,Nq));
    objSim3Tanks.setInternalSensorMeasurements(zeros(1,Nx+Nq));
    objSim3Tanks.setInternalValveSignals(opMode');
    objSim3Tanks.setInternalFaultSignals(f');

else
    x = x(end,:);
end

%==========================================================================

h1 = x(1);
h2 = x(2);
h3 = x(3);

if(h1<=h0 && h2<=h0 && h3<=h0)
    % fprintf('CASE 1 : h1<=h0, h2<=h0, h3<=h0\n');
    Qa = K(4)*0;
    Qb = K(5)*0;

elseif(h1<=h0 && h2<=h0 && h3>h0)
    % fprintf('CASE 2 : h1<=h0, h2<=h0, h3>h0\n');
    Qa = K(4)*Beta*sign(h0-h3)*sqrt(abs(h0-h3));
    Qb = K(5)*Beta*sign(h0-h3)*sqrt(abs(h0-h3));

elseif(h1<=h0 && h2>h0 && h3<=h0)
    % fprintf('CASE 3 : h1<=h0, h2>h0, h3<=h0\n');
    Qa = K(4)*0;
    Qb = K(5)*Beta*sign(h2-h3)*sqrt(abs(h2-h3));

elseif(h1<=h0 && h2>h0 && h3>h0)
    % fprintf('CASE 4 : h1<=h0, h2>h0, h3>h0\n');
    Qa = K(4)*Beta*sign(h0-h3)*sqrt(abs(h0-h3));
    Qb = K(5)*Beta*sign(h2-h3)*sqrt(abs(h2-h3));

elseif(h1>h0 && h2<=h0 && h3<=h0)
    % fprintf('CASE 5 : h1>h0, h2<=h0, h3<=h0\n');
    Qa = K(4)*Beta*sign(h1-h0)*sqrt(abs(h1-h0));
    Qb = K(5)*0;

elseif(h1>h0 && h2<=h0 && h3>h0)
    % fprintf('CASE 6 : h1>h0, h2<=h0, h3>h0\n');
    Qa = K(4)*Beta*sign(h1-h3)*sqrt(abs(h1-h3));
    Qb = K(5)*Beta*sign(h0-h3)*sqrt(abs(h0-h3));

elseif(h1>h0 && h2>h0 && h3<=h0)
    % fprintf('CASE 7 : h1>h0, h2>h0, h3<=h0\n');
    Qa = K(4)*Beta*sign(h1-h0)*sqrt(abs(h1-h0));
    Qb = K(5)*Beta*sign(h2-h0)*sqrt(abs(h2-h0));

elseif(h1>h0 && h2>h0 && h3>h0)
    % fprintf('CASE 8 : h1>h0, h2>h0, h3>h0\n');
    Qa = K(4)*Beta*sign(h1-h3)*sqrt(abs(h1-h3));
    Qb = K(5)*Beta*sign(h2-h3)*sqrt(abs(h2-h3));

else
    error(getMessage('ERR000'));
end

Q1in = K(1)*satSignal(Qp1,[Qmin Qmax]);
Q2in = K(2)*satSignal(Qp2,[Qmin Qmax]);
Q3in = K(3)*satSignal(Qp3,[Qmin Qmax]);
Q13  = K(6)*Beta*sign(h1-h3)*sqrt(abs(h1-h3));
Q23  = K(7)*Beta*sign(h2-h3)*sqrt(abs(h2-h3));
Q1   = K(8)*Beta*sqrt(abs(h1));
Q2   = K(9)*Beta*sqrt(abs(h2));
Q3   = K(10)*Beta*sqrt(abs(h3));

% Flows ---> q = [Qp1,Qp2,Qp3,Qa,Qb,Q13,Q23,Q1,Q2,Q3]
q = [Q1in,Q2in,Q3in,Qa,Qb,Q13,Q23,Q1,Q2,Q3];

% Levels ---> h = [h1,h2,h3]
options = odeset('MaxStep',Tspan,'RelTol',1e-6);

[~,x] = ode45(@(t,x)dxdtModel(Sc,q,pNoise),[0 Tspan],x,options);

if(isfinite(x))
    x = satSignal(x(end,:),[0 Hmax]);
else
    error(getMessage('ERR007'));
end

% Measurements ---> y = [h1,h2,h3,Q1in,Q2in,Q3in,Qa,Qb,Q13,Q23,Q1,Q2,Q3]
y = sensorMeasurements(x,q,f,mNoise);

objSim3Tanks.pushInternalStateVariables(x);
objSim3Tanks.pushInternalFlowVariables(q);
objSim3Tanks.pushInternalSensorMeasurements(y);
objSim3Tanks.pushInternalValveSignals(K');
objSim3Tanks.pushInternalFaultSignals(f');

end