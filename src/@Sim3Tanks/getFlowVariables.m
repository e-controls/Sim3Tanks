function [varargout] = getFlowVariables(varargin)
% getFlowVariables is a Sim3Tanks method. This method does not have an
% input argument and returns a data table with the values of the flow
% variables.
%
% Example:
%   tts.getFlowVariables();

% https://github.com/e-controls/Sim3Tanks

%==========================================================================

if(nargin()>1)
    error(getMessage('ERR002'));
else
    objSim3Tanks = varargin{1};
end

%==========================================================================

LIST_OF_FLOWS = Sim3Tanks.LIST_OF_FLOWS;

q = objSim3Tanks.getInternalFlowVariables();

if(~isempty(q))
    q = array2table(q,'VariableNames',LIST_OF_FLOWS);
end

varargout{1} = q;

end