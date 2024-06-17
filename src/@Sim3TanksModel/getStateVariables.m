function [varargout] = getStateVariables(varargin)
% getStateVariables is a Sim3Tanks method. This method returns a data table
% with the values of the state variables.

% Written by Arllem Farias, February/2024.
% Last update June/2024 by Arllem Farias.

%==========================================================================

if(nargin()>1)
    error(errorMessage(02));
else
    objSim3Tanks = varargin{1};
end

%==========================================================================

LIST_OF_STATES = Sim3TanksModel.LIST_OF_STATES;

x = objSim3Tanks.getInternalStateVariables();

if(~isempty(x))
    x = array2table(x,'VariableNames',LIST_OF_STATES);
end

varargout{1} = x;

end