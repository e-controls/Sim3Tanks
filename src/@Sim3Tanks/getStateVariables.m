function [varargout] = getStateVariables(varargin)
% getStateVariables is a Sim3Tanks method. This method returns a data table
% with the values of the state variables.

% https://github.com/e-controls/Sim3Tanks

%==========================================================================

if(nargin()>1)
    error(getMessage('ERR002'));
else
    objSim3Tanks = varargin{1};
end

%==========================================================================

LIST_OF_STATES = Sim3Tanks.LIST_OF_STATES;

x = objSim3Tanks.getInternalStateVariables();

if(~isempty(x))
    x = array2table(x,'VariableNames',LIST_OF_STATES);
end

varargout{1} = x;

end