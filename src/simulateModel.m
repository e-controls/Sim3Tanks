function [y,x,q] = simulateModel(objSim3Tanks,Qp1,Qp2,Qp3,Tspan)
% simulateModel is a Sim3Tanks function. This function simulates the
% dynamic behavior of the three-tank system.

% Written by Arllem Farias, January/2024.
% Last update February/2024 by Arllem Farias.

%==========================================================================

if(~isa(objSim3Tanks,'Sim3TanksClass'))
    error(errorMessage(07));
end

%==========================================================================

param = checkPhysicalParam(objSim3Tanks);

Rtank = param(1);
Hmax  = param(2);
Rpipe = param(3);
h0    = param(4);
mu    = param(5);
g     = param(6);
Qmin  = param(7);
Qmax  = param(8);

A = pi()*(Rtank^2); % Cross-sectional area of the tanks (cm^2)
S = pi()*(Rpipe^2); % Cross-sectional area of the pipes (cm^2)
Beta = mu*S*sqrt(2*g); % Constant value

%==========================================================================

[fmag,fid] = checkEnabledFaults(objSim3Tanks);
[vstate,vid] = checkEnabledValves(objSim3Tanks);
opMode = checkOperationMode(objSim3Tanks)';
Kf = zeros(size(opMode)); % Kf = [Kp1,Kp2,Kp3,Ka,Kb,K13,K23,K1,K2,K3];
Kv = zeros(size(opMode)); % Kv = [Kp1,Kp2,Kp3,Ka,Kb,K13,K23,K1,K2,K3];
f  = fmag';
v  = vstate';

for i = 1 : numel(opMode) % Q = Kv*Kf*Beta*...
    Kv(i) = vstate(i);
    if(~isempty(fid{i})) % If <EnableSignal> is enabled
        if(logical(opMode(i)))
            Kf(i) = 1-fmag(i);
        else
            Kf(i) = fmag(i);
            if(isempty(vid{i})) % If <EnableControl> is NOT enabled
                Kv(i) = 1;
            end
        end
    else
        Kf(i) = 1;
    end
end

%==========================================================================

[pNoise,mNoise] = checkEnabledNoises(objSim3Tanks);

%==========================================================================

global SIM3TANKS_LISTS; %#ok<*GVMIS>

x = objSim3Tanks.getStateVariables();

if(isempty(x))
    if(isempty(SIM3TANKS_LISTS))
        error(errorMessage(04));
    else
        Nx = numel(SIM3TANKS_LISTS.LIST_OF_STATES);
        Nq = numel(SIM3TANKS_LISTS.LIST_OF_FLOWS);
        x  = objSim3Tanks.InitialCondition;
    end
    objSim3Tanks.setStateVariables(x);
    objSim3Tanks.setFlowVariables(zeros(1,Nq));
    objSim3Tanks.setSensorMeasurements(zeros(1,Nx+Nq));
    objSim3Tanks.setValveSignals(opMode);
    objSim3Tanks.setFaultSignals(f);
else
    x = x(end,:);
end

%==========================================================================

h1 = x(1);
h2 = x(2);
h3 = x(3);

if(h1<=h0 && h2<=h0 && h3<=h0)
    %fprintf('CASE 1 : h1<=h0, h2<=h0, h3<=h0\n');
    Qa = Kv(4)*Kf(4)*0;
    Qb = Kv(5)*Kf(5)*0;
    
elseif(h1<=h0 && h2<=h0 && h3>h0)
    %fprintf('CASE 2 : h1<=h0, h2<=h0, h3>h0\n');
    Qa = Kv(4)*Kf(4)*Beta*sign(h0-h3)*sqrt(abs(h0-h3));
    Qb = Kv(5)*Kf(5)*Beta*sign(h0-h3)*sqrt(abs(h0-h3));
    
elseif(h1<=h0 && h2>h0 && h3<=h0)
    %fprintf('CASE 3 : h1<=h0, h2>h0, h3<=h0\n');
    Qa = Kv(4)*Kf(4)*0;
    Qb = Kv(5)*Kf(5)*Beta*sign(h2-h3)*sqrt(abs(h2-h3));
    
elseif(h1<=h0 && h2>h0 && h3>h0)
    %fprintf('CASE 4 : h1<=h0, h2>h0, h3>h0\n');
    Qa = Kv(4)*Kf(4)*Beta*sign(h0-h3)*sqrt(abs(h0-h3));
    Qb = Kv(5)*Kf(5)*Beta*sign(h2-h3)*sqrt(abs(h2-h3));
    
elseif(h1>h0 && h2<=h0 && h3<=h0)
    %fprintf('CASE 5 : h1>h0, h2<=h0, h3<=h0\n');
    Qa = Kv(4)*Kf(4)*Beta*sign(h1-h0)*sqrt(abs(h1-h0));
    Qb = Kv(5)*Kf(5)*0;
    
elseif(h1>h0 && h2<=h0 && h3>h0)
    %fprintf('CASE 6 : h1>h0, h2<=h0, h3>h0\n');
    Qa = Kv(4)*Kf(4)*Beta*sign(h1-h3)*sqrt(abs(h1-h3));
    Qb = Kv(5)*Kf(5)*Beta*sign(h0-h3)*sqrt(abs(h0-h3));
    
elseif(h1>h0 && h2>h0 && h3<=h0)
    %fprintf('CASE 7 : h1>h0, h2>h0, h3<=h0\n');
    Qa = Kv(4)*Kf(4)*Beta*sign(h1-h0)*sqrt(abs(h1-h0));
    Qb = Kv(5)*Kf(5)*Beta*sign(h2-h0)*sqrt(abs(h2-h0));
    
elseif(h1>h0 && h2>h0 && h3>h0)
    %fprintf('CASE 8 : h1>h0, h2>h0, h3>h0\n');
    Qa = Kv(4)*Kf(4)*Beta*sign(h1-h3)*sqrt(abs(h1-h3));
    Qb = Kv(5)*Kf(5)*Beta*sign(h2-h3)*sqrt(abs(h2-h3));
    
else
    error(errorMessage(00));
end

Q1in = Kv(1)*Kf(1)*satSignal(Qp1,[Qmin Qmax]);
Q2in = Kv(2)*Kf(2)*satSignal(Qp2,[Qmin Qmax]);
Q3in = Kv(3)*Kf(3)*satSignal(Qp3,[Qmin Qmax]);
Q13  = Kv(6)*Kf(6)*Beta*sign(h1-h3)*sqrt(abs(h1-h3));
Q23  = Kv(7)*Kf(7)*Beta*sign(h2-h3)*sqrt(abs(h2-h3));
Q1   = Kv(8)*Kf(8)*Beta*sqrt(abs(h1));
Q2   = Kv(9)*Kf(9)*Beta*sqrt(abs(h2));
Q3   = Kv(10)*Kf(10)*Beta*sqrt(abs(h3));

% Flows ---> q = [Qp1,Qp2,Qp3,Qa,Qb,Q13,Q23,Q1,Q2,Q3]
q = [Q1in,Q2in,Q3in,Qa,Qb,Q13,Q23,Q1,Q2,Q3];

% Levels ---> h = [h1,h2,h3]
options = odeset('MaxStep',Tspan,'RelTol',1e-6);

[~,x] = ode45(@(t,x)dxdtModel(A,q,pNoise),[0 Tspan],[h1,h2,h3],options);

if(isfinite(x))
    x = satSignal(x(end,:),[0 Hmax]);
else
    error(errorMessage(05));
end

% Measurements ---> y = [h1,h2,h3,Q1in,Q2in,Q3in,Qa,Qb,Q13,Q23,Q1,Q2,Q3]
y = sensorMeasurements(x,q,f,mNoise);

objSim3Tanks.pushStateVariables(x);
objSim3Tanks.pushFlowVariables(q);
objSim3Tanks.pushSensorMeasurements(y);
objSim3Tanks.pushValveSignals(v);
objSim3Tanks.pushFaultSignals(f);

end