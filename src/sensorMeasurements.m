function [y] = sensorMeasurements(varargin)
% sensorMeasurements is a Sim3Tanks function. This function describes the
% measurements of the output equations of the three-tank system.

% https://github.com/e-controls/Sim3Tanks

%==========================================================================

LIST_OF_VALVES = Sim3Tanks.LIST_OF_VALVES;

%==========================================================================

if(nargin()<5)
    error(getMessage('ERR001'));
elseif(nargin()>5)
    error(getMessage('ERR002'));
else
    levels   = varargin{1};
    flows    = varargin{2};
    faultMag = varargin{3};
    offset   = varargin{4};
    mNoise   = varargin{5};
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