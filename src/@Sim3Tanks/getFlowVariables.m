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
    Model = properties(objSim3Tanks);
end

%==========================================================================

LIST_OF_FLOWS = objSim3Tanks.(Model{1}).LIST_OF_FLOWS;

q = objSim3Tanks.(Model{1}).getFlowVariables();

if(~isempty(q))
    q = array2table(q,'VariableNames',LIST_OF_FLOWS);
end

varargout{1} = q;

end