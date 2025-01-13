function clearVariables(varargin)
% clearVariables is a Sim3Tanks method. This method clears all state and
% flow variables, valve and fault signals, and the data measured by the
% sensors of a Sim3Tanks object.
%
% Example:
%   tts.clearVariables(option);
%
% To clear a specific variable, enter one of the following options as an
% input argument:
%   'states'  : to clear only the estate variables.
%   'flows'   : to clear only the flow variables.
%   'sensors' : to clear only the measurement data.
%   'valves'  : to clear only the valve signals.
%   'faults'  : to clear only the fault singals
%
% If there is no input argument, all these variables will be cleared.

% https://github.com/e-controls/Sim3Tanks

%==========================================================================

if(nargin()>2)
    error(getMessage('ERR002'));
else
    objSim3Tanks = varargin{1};
end

%==========================================================================

if(nargin()==1)
    objSim3Tanks.setInternalStateVariables([]);
    objSim3Tanks.setInternalFlowVariables([]);
    objSim3Tanks.setInternalSensorMeasurements([]);
    objSim3Tanks.setInternalValveSignals([]);
    objSim3Tanks.setInternalFaultSignals([]);
    objSim3Tanks.resetInternalSimulationTime();
else
    switch lower(varargin{2})
        case 'states'
            objSim3Tanks.setInternalStateVariables([]);
        case 'flows'
            objSim3Tanks.setInternalFlowVariables([]);
        case 'sensors'
            objSim3Tanks.setInternalSensorMeasurements([]);
        case 'valves'
            objSim3Tanks.setInternalValveSignals([]);
        case 'faults'
            objSim3Tanks.setInternalFaultSignals([]);
        otherwise
            error(getMessage('ERR003'));
    end
end
