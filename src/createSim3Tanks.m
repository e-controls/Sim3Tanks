function [varargout] = createSim3Tanks(varargin)
% createSim3Tanks is a Sim3Tanks function. This function does not have an
% input argument and returns a Sim3Tanks object.
%
% tts = createSim3Tanks() returns an object with the following attributes
% and methods:
%                   Model: [attribute]
%           simulateModel: [method]
%            displayModel: [method]
%              clearModel: [method]
%          clearVariables: [method]
%         setDefaultModel: [method]
%   getDefaultLinearModel: [method]
%       getStateVariables: [method]
%        getFlowVariables: [method]
%   getSensorMeasurements: [method]
%         getValveSignals: [method]
%      getFaultMagnitudes: [method]
%         getFaultOffsets: [method]
%              plotLevels: [method]
%               plotFlows: [method]
%              plotValves: [method]
%     plotFaultMagnitudes: [method]
%        plotFaultOffsets: [method]
%
% By default, all numeric fields are empty, the operation mode of all
% valves is set to 'Closed', and control is disabled. In addition, all
% fault signals are disabled, including the process and measurement noises.
% It is up to the user to configure the scenario as desired.
%
% To set the default scenario, call: tts.setDefaultModel();
%
% To see the Model attribute and their values, call: tts.displayModel();

% https://github.com/e-controls/Sim3Tanks

%==========================================================================

if(nargin()~=0)
    error(getMessage('ERR002'));
end

%==========================================================================

% Should we create a constructor using KEY-VALUE pairs???
% Ex.: createSim3Tanks('TankRadius',0.5,'Kp1',{open,enabled,openingRate},...)

persistent globalCounter;

if(isempty(globalCounter))
    globalCounter = 1;
else
    globalCounter = globalCounter + 1;
end

tts = Sim3Tanks(); % Calling constructor method

tts.About.Name = 'Sim3Tanks';
tts.About.Version = '2.0.2';
tts.About.Description = 'A Benchmark Model Simulator for Process Control and Monitoring';
tts.About.License = 'MIT';
tts.About.Link = ['<a href="https://github.com/e-controls/Sim3Tanks" target="_blank">' ...
    'https://github.com/e-controls/Sim3Tanks</a>'];
tts.About.CurrentPath = pwd();
tts.About.MatlabVer = version();
tts.About.SystemArch = computer();
tts.About.ObjectID = globalCounter;

varargout{1} = tts;

end
