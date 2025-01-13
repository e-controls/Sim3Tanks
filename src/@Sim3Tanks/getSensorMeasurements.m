function [varargout] = getSensorMeasurements(varargin)
% getSensorMeasurements is a Sim3Tanks method. This method does not have an
% input argument and returns a data table with the values of the measured
% variables.
%
% Example:
%   tts.getSensorMeasurements();

% https://github.com/e-controls/Sim3Tanks

%==========================================================================

if(nargin()>1)
    error(getMessage('ERR002'));
else
    objSim3Tanks = varargin{1};
end

%==========================================================================

LIST_OF_STATES = Sim3Tanks.LIST_OF_STATES;
LIST_OF_FLOWS  = Sim3Tanks.LIST_OF_FLOWS;

y = objSim3Tanks.getInternalSensorMeasurements();
t = objSim3Tanks.getInternalSimulationTime();

if(~isempty(y))
    y = array2timetable(y,'RowTimes',seconds(t),'VariableNames',[LIST_OF_STATES;LIST_OF_FLOWS]);
end

varargout{1} = y;

end