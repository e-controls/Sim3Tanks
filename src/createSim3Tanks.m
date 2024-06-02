function [varargout] = createSim3Tanks(varargin)
% createSim3Tanks is a Sim3Tanks function. This function does not have an
% input argument and returns a Sim3Tanks object.
%
% objSim3Tanks = createSim3Tanks() returns an object with the following
% fields:
%              Model: [1×1 Sim3TanksClass]
%      simulateModel: [function_handle]
%         resetModel: [function_handle]
%     resetVariables: [function_handle]
%    setDefaultModel: [function_handle]
%          getStates: [function_handle]
%           getFlows: [function_handle]
%    getMeasurements: [function_handle]
%          getValves: [function_handle]
%          getFaults: [function_handle]

% Written by Arllem Farias, December/2023.
% Last update May/2024 by Arllem Farias.

%==========================================================================

if(nargin()~=0)
    error(errorMessage(02));
end

%==========================================================================

objSim3Tanks.Model = Sim3TanksClass();
objSim3Tanks.Model.prepareModel();

%#ok<*FVAL>
objSim3Tanks.simulateModel = ...
    @(varargin)feval(@(obj,varargin)...
    simulateModel...
    (obj,varargin{:}),objSim3Tanks.Model,varargin{:});

objSim3Tanks.displayFields = ...
    @(varargin)feval(@(obj,varargin)...
    displayFields...
    (obj,varargin{:}),objSim3Tanks.Model,varargin{:});

objSim3Tanks.resetModel = ...
    @(varargin)feval(@(obj,varargin)...
    resetModel...
    (obj,varargin{:}),objSim3Tanks.Model,varargin{:});

objSim3Tanks.resetVariables = ...
    @(varargin)feval(@(obj,varargin)...
    resetVariables...
    (obj,varargin{:}),objSim3Tanks.Model,varargin{:});

objSim3Tanks.setDefaultModel = ...
    @(varargin)feval(@(obj,varargin)...
    setDefaultModel...
    (obj,varargin{:}),objSim3Tanks.Model,varargin{:});

objSim3Tanks.getStates = ...
    @(varargin)feval(@(obj,varargin)...
    getStates...
    (obj,varargin{:}),objSim3Tanks.Model,varargin{:});

objSim3Tanks.getFlows = ...
    @(varargin)feval(@(obj,varargin)...
    getFlows...
    (obj,varargin{:}),objSim3Tanks.Model,varargin{:});

objSim3Tanks.getMeasurements = ...
    @(varargin)feval(@(obj,varargin)...
    getMeasurements...
    (obj,varargin{:}),objSim3Tanks.Model,varargin{:});

objSim3Tanks.getValves = ...
    @(varargin)feval(@(obj,varargin)...
    getValves...
    (obj,varargin{:}),objSim3Tanks.Model,varargin{:});

objSim3Tanks.getFaults = ...
    @(varargin)feval(@(obj,varargin)...
    getFaults...
    (obj,varargin{:}),objSim3Tanks.Model,varargin{:});

% The idea is to create a log file when this value is true.
% objSim3Tanks.LogFile = false;

varargout{1} = objSim3Tanks;

end
