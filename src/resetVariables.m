function [varargout] = resetVariables(varargin)
% resetVariables is a Sim3Tanks function. This function resets all state
% variables, valve, fault and flow signals, and the measurement data of
% the sensors of a Sim3TanksClass object.

% Written by Arllem Farias, January/2024.
% Last update February/2024 by Arllem Farias.

%==========================================================================

N = nargin();
if(N<1)
    error(errorMessage(01));
elseif(N>2)
    error(errorMessage(02));
end

if(isa(varargin{1},'Sim3TanksClass'))
    objSim3Tanks = varargin{1};
else
    error(errorMessage(07));
end

%==========================================================================

if(N==1)
    objSim3Tanks.setStateVariables([]);
    objSim3Tanks.setFlowVariables([]);
    objSim3Tanks.setSensorMeasurements([]);
    objSim3Tanks.setValveSignals([]);
    objSim3Tanks.setFaultSignals([]);
else
    switch lower(varargin{2})
        case 'states'
            objSim3Tanks.setStateVariables([]);
        case 'flows'
            objSim3Tanks.setFlowVariables([]);
        case 'sensors'
            objSim3Tanks.setSensorMeasurements([]);
        case 'valves'
            objSim3Tanks.setValveSignals([]);
        case 'faults'
            objSim3Tanks.setFaultSignals([]);
        otherwise
            error(errorMessage(03));
    end
end

varargout{1} = objSim3Tanks;

end