function [y] = sensorMeasurements(varargin)
% sensorMeasurements is a Sim3Tanks function. This function describes the
% measurements of the output equations of the three-tank system.

% https://github.com/e-controls/Sim3Tanks

%==========================================================================

LIST_OF_VALVES = Sim3TanksModel.LIST_OF_VALVES;
LIST_OF_FAULTS = Sim3TanksModel.LIST_OF_FAULTS;
LIST_OF_STATES = Sim3TanksModel.LIST_OF_STATES;
LIST_OF_FLOWS = Sim3TanksModel.LIST_OF_FLOWS;

%==========================================================================

if(nargin()<4)
    error(getMessage('ERR001'));
elseif(nargin()>4)
    error(getMessage('ERR002'));
else
    h = varargin{1};
    q = varargin{2};
    f = varargin{3};
    v = varargin{4};
end

if~(isnumeric(h)&&isnumeric(q)&&isnumeric(f)&&isnumeric(v))
    error(getMessage('ERR003'));
elseif(~isrow(h)||~isrow(q))
    error(getMessage('ERR005'));
elseif (numel(h) ~= numel(LIST_OF_STATES) ...
        || numel(q) ~= numel(LIST_OF_FLOWS) ...
        || numel(f) ~= numel(LIST_OF_FAULTS) ...
        || numel(v) ~= numel([LIST_OF_STATES;LIST_OF_FLOWS]))
    error(getMessage('ERR006'));
end

N = numel(LIST_OF_VALVES);
y = [h , q]; % [h1,h2,h3,Q1in,Q2in,Q3in,Qa,Qb,Q13,Q23,Q1,Q2,Q3]

for i = 1 : numel(y)
    j = N + i;
    if(f(j) ~= 1)
        y(i) = (1-f(j))*y(i) + v(i); % Multiplicative fault
    else
        y(i) = 0; % Could it be a NaN?
    end
end