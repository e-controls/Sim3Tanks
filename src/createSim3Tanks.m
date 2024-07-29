function [varargout] = createSim3Tanks(varargin)
% createSim3Tanks is a Sim3Tanks function. This function does not have an
% input argument and returns a Sim3Tanks object.
%
% objSim3Tanks = createSim3Tanks() returns an object with the following
% attributes and methods:
%                   Model: [attribute]
%           simulateModel: [method]
%           displayFields: [method]
%              clearModel: [method]
%          clearVariables: [method]
%         setDefaultModel: [method]
%   getDefaultLinearModel: [method]
%       getStateVariables: [method]
%        getFlowVariables: [method]
%   getSensorMeasurements: [method]
%         getValveSignals: [method]
%         getFaultSignals: [method]
%  interpolSimulationTime: [method]

% https://github.com/e-controls/Sim3Tanks

%==========================================================================

if(nargin()~=0)
    error(getMessage('ERR002'));
end

%==========================================================================

% Should I create a constructor using KEY-VALUE pairs???
% Ex.: createSim3Tanks('TankRadius',0.5,'Kp1',{open,enabled,openingRate},...)

varargout{1} = Sim3TanksModel();

end
