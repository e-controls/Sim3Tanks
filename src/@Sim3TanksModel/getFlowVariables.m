function [varargout] = getFlowVariables(varargin)
% getFlowVariables is a Sim3Tanks method. This method returns a data table
% with the values of the flow variables.

% Written by Arllem Farias, February/2024.
% Last update June/2024 by Arllem Farias.

%==========================================================================

if(nargin()>1)
    error(errorMessage(02));
else
    objSim3Tanks = varargin{1};
end

%==========================================================================

LIST_OF_FLOWS = Sim3TanksModel.LIST_OF_FLOWS;

q = objSim3Tanks.getInternalFlowVariables();

if(~isempty(q))
    q = array2table(q,'VariableNames',LIST_OF_FLOWS);
end

varargout{1} = q;

end