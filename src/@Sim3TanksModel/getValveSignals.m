function [varargout] = getValveSignals(varargin)
% getValveSignals is a Sim3Tanks method. This method returns a data table
% with the values of the valve signals.

% https://github.com/e-controls/Sim3Tanks

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