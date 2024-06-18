function [varargout] = getSensorMeasurements(varargin)
% getSensorMeasurements is a Sim3Tanks method. This method returns a data
% table with the values of the measured variables.

% Written by Arllem Farias, February/2024.
% Last update June/2024 by Arllem Farias.

%==========================================================================

if(nargin()>1)
    error(getMessage('ERR002'));
else
    objSim3Tanks = varargin{1};
end

%==========================================================================

LIST_OF_STATES = Sim3TanksModel.LIST_OF_STATES;
LIST_OF_FLOWS  = Sim3TanksModel.LIST_OF_FLOWS;

y = objSim3Tanks.getInternalSensorMeasurements();

if(~isempty(y))
    y = array2table(y,'VariableNames',[LIST_OF_STATES;LIST_OF_FLOWS]);
end

varargout{1} = y;

end