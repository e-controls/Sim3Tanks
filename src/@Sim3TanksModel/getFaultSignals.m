function [varargout] = getFaultSignals(varargin)
% getFaultSignals is a Sim3Tanks method. This method returns a data table
% with the values of the fault signals.

% Written by Arllem Farias, February/2024.
% Last update June/2024 by Arllem Farias.

%==========================================================================

if(nargin()>1)
    error(errorMessage(02));
else
    objSim3Tanks = varargin{1};
end

%==========================================================================

LIST_OF_FAULTS = Sim3TanksModel.LIST_OF_FAULTS;

f = objSim3Tanks.getInternalFaultSignals();

if(~isempty(f))
    f = array2table(f,'VariableNames',LIST_OF_FAULTS);
end

varargout{1} = f;

end