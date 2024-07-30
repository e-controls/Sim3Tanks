function [varargout] = createSim3Tanks(varargin)
% createSim3Tanks is a Sim3Tanks function. This function does not have an
% input argument and returns a Sim3Tanks object.
%
% tts = createSim3Tanks() returns an object with the following attributes
% and methods:
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
%         interpolateTime: [method]
%
% By default, all numeric fields are empty, the operation mode of all
% valves is set to 'Closed', and control is disabled. In addition, all
% fault signals are disabled, including the process and measurement noises.
% It is up to the user to configure the scenario as desired.
%
% To set the default scenario, call: tts.setDefaultModel();
%
% To see the fields and their respective values, call: tts.displayFields();

% https://github.com/e-controls/Sim3Tanks

%==========================================================================

if(nargin()~=0)
    error(getMessage('ERR002'));
end

%==========================================================================

% Should I create a constructor using KEY-VALUE pairs???
% Ex.: createSim3Tanks('TankRadius',0.5,'Kp1',{open,enabled,openingRate},...)

varargout{1} = Sim3Tanks();

end
