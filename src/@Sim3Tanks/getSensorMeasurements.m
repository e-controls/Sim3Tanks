function [varargout] = getSensorMeasurements(varargin)
% getSensorMeasurements is a Sim3Tanks method. This method returns a data
% table with the values of the measured variables.

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

LIST_OF_STATES = objSim3Tanks.(Model{1}).LIST_OF_STATES;
LIST_OF_FLOWS  = objSim3Tanks.(Model{1}).LIST_OF_FLOWS;

y = objSim3Tanks.(Model{1}).getSensorMeasurements();

if(~isempty(y))
    y = array2table(y,'VariableNames',[LIST_OF_STATES;LIST_OF_FLOWS]);
end

varargout{1} = y;

end