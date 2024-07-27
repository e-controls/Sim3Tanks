function [y] = sensorMeasurements(varargin)
% sensorMeasurements is a Sim3Tanks function. This function describes the
% measurements of the output equations of the three-tank system.

% https://github.com/e-controls/Sim3Tanks

%==========================================================================

LIST_OF_VALVES = Sim3TanksModel.LIST_OF_VALVES;
LIST_OF_FAULTS = Sim3TanksModel.LIST_OF_FAULTS;
LIST_OF_STATES = Sim3TanksModel.LIST_OF_STATES;
LIST_OF_FLOWS  = Sim3TanksModel.LIST_OF_FLOWS;

%==========================================================================

if(nargin()<5)
    error(getMessage('ERR001'));
elseif(nargin()>5)
    error(getMessage('ERR002'));
else
    levels = varargin{1};
    flows = varargin{2};
    faultMag = varargin{3};
    offset = varargin{4};
    mNoise = varargin{5};
end

if~(isnumeric(levels)&&isnumeric(flows)&&isnumeric(faultMag)&&isnumeric(offset)&&isnumeric(mNoise))
    error(getMessage('ERR003'));
elseif(~isrow(levels)||~isrow(flows))
    error(getMessage('ERR005'));
elseif (numel(levels) ~= numel(LIST_OF_STATES) ...
        || numel(flows) ~= numel(LIST_OF_FLOWS) ...
        || numel(faultMag) ~= numel(LIST_OF_FAULTS) ...
        || numel(mNoise) ~= numel([LIST_OF_STATES;LIST_OF_FLOWS]))
    error(getMessage('ERR006'));
end

N = numel(LIST_OF_VALVES);
y = [levels , flows]; % [h1,h2,h3,Q1in,Q2in,Q3in,Qa,Qb,Q13,Q23,Q1,Q2,Q3]

for i = 1 : numel(y)
    j = N + i;
    if(faultMag(j) ~= 1)
        y(i) = (1-faultMag(j))*y(i) + offset(j) + mNoise(i);
    else
        y(i) = 0; % Could it be a NaN?
    end
end