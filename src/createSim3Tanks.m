function [varargout] = createSim3Tanks(varargin)
% createSim3Tanks is a Sim3Tanks function. This function does not have an
% input argument and returns a Sim3Tanks object.
%
% objSim3Tanks = createSim3Tanks() returns an object with the following
% fields:
%      Model: [1×1 Sim3TanksModel]
%      simulateModel: [function_handle]
%         clearModel: [function_handle]
%     clearVariables: [function_handle]
%    setDefaultModel: [function_handle]
%   getDefaultLinearModel: [function_handle]
%          getStates: [function_handle]
%           getFlows: [function_handle]
%    getMeasurements: [function_handle]
%          getValves: [function_handle]
%          getFaults: [function_handle]

% Written by Arllem Farias, December/2023.
% Last update May/2024 by Arllem Farias.

%==========================================================================

if(nargin()~=0)
    error(getMessage('ERR002'));
end

%==========================================================================

varargout{1} = Sim3TanksModel();

end
