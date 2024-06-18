function [varargout] = getValveSignals(varargin)
% getValveSignals is a Sim3Tanks method. This method returns a data table
% with the values of the valve signals.

% Written by Arllem Farias, February/2024.
% Last update June/2024 by Arllem Farias.

%==========================================================================

if(nargin()>1)
    error(getMessage('ERR002'));
else
    objSim3Tanks = varargin{1};
end

%==========================================================================

LIST_OF_VALVES = Sim3TanksModel.LIST_OF_VALVES;

v = objSim3Tanks.getInternalValveSignals();

if(~isempty(v))
    v = array2table(v,'VariableNames',LIST_OF_VALVES);
end

varargout{1} = v;

end