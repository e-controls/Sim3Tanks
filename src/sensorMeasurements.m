function [y] = sensorMeasurements(h, q, f, v)
% sensorMeasurements is a Sim3Tanks function. This function describes the
% measurements of the output equations of the three-tank system.

% Written by Arllem Farias, January/2024.
% Last update January/2024 by Arllem Farias.

%==========================================================================
global SIM3TANKS_LISTS; %#ok<*GVMIS>

if(isempty(SIM3TANKS_LISTS))
    error(errorMessage(04));
else
    LIST_OF_VALVES = SIM3TANKS_LISTS.LIST_OF_VALVES;
end
%==========================================================================

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