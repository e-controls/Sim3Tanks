function [varargout] = getValveSignals(varargin)
% getValveSignals is a Sim3Tanks method. This method returns a data table
% with the values of the valve signals.

% Written by Arllem Farias, February/2024.
% Last update June/2024 by Arllem Farias.

%==========================================================================

if(nargin()>1)
    error(errorMessage(02));
else
    objSim3Tanks = varargin{1};
    Model = properties(objSim3Tanks);
end

%==========================================================================

LIST_OF_VALVES = objSim3Tanks.(Model{1}).LIST_OF_VALVES;

v = objSim3Tanks.(Model{1}).getValveSignals();

if(~isempty(v))
    v = array2table(v,'VariableNames',LIST_OF_VALVES);
end

varargout{1} = v;

end