function [varargout] = getValveSignals(varargin)
% getValveSignals is a Sim3Tanks method. This method does not have an input
% argument and returns a data table with the values of the valve signals.
%
% Example:
%   tts.getValveSignals();

% https://github.com/e-controls/Sim3Tanks

%==========================================================================

if(nargin()>1)
    error(getMessage('ERR002'));
else
    objSim3Tanks = varargin{1};
end

%==========================================================================

LIST_OF_VALVES = Sim3Tanks.LIST_OF_VALVES;

v = objSim3Tanks.getInternalValveSignals();
t = objSim3Tanks.getInternalSimulationTime();

if(~isempty(v))
    v = array2timetable(v,'RowTimes',seconds(t),'VariableNames',LIST_OF_VALVES);
end

varargout{1} = v;

end