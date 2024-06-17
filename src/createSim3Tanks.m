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
%     getLinearModel: [function_handle]
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

varargout{1} = Sim3TanksModel();

end
