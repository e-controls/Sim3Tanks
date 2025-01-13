function [varargout] = getStateVariables(varargin)
% getStateVariables is a Sim3Tanks method. This method does not have an
% input argument and returns a data table with the values of the state
% variables.
%
% Example:
%   tts.getStateVariables();

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
t = objSim3Tanks.getInternalSimulationTime();

if(~isempty(x))
    x = array2timetable(x,'RowTimes',seconds(t),'VariableNames',LIST_OF_STATES);
end

varargout{1} = x;

end