function [varargout] = checkEnabledFaults(varargin)
% checkEnabledFaults is a Sim3Tanks function. This function checks the
% faults that have EnableSignal field set to true in a Sim3TanksClass
% object and returns an array with the Magnitude field values. If the
% EnableSignal field is set to false, then the returned value will be 0. A
% second array with the IDs of the enabled faults is also returned.

% Written by Arllem Farias, January/2024.
% Last update January/2024 by Arllem Farias.

%==========================================================================

if(nargin()<1)
    error(errorMessage(01));
elseif(nargin()>1)
    error(errorMessage(02));
end

if(isa(varargin{1},'Sim3TanksClass'))
    objSim3Tanks = varargin{1};
    ClassPropers = properties(objSim3Tanks);
else
    error(errorMessage(07));
end

%==========================================================================
global SIM3TANKS_LISTS; %#ok<*GVMIS>

if(isempty(SIM3TANKS_LISTS))
    error(errorMessage(04));
else
    LIST_OF_FAULTS = SIM3TANKS_LISTS.LIST_OF_FAULTS;
end
%==========================================================================

faultMag = zeros(size(LIST_OF_FAULTS));
faultID = cell(size(LIST_OF_FAULTS));

for i = 1 : numel(LIST_OF_FAULTS)
    fault = objSim3Tanks.(ClassPropers{3}).(LIST_OF_FAULTS{i});
    if(islogical(fault.EnableSignal) && fault.EnableSignal)
        faultMag(i) = satSignal(fault.Magnitude,[0 1]);
        faultID{i}  = LIST_OF_FAULTS{i};
    elseif(islogical(fault.EnableSignal))
        faultMag(i) = 0;
        faultID{i}  = [];
    else
        error(errorMessage(12));
    end
end

varargout{1} = faultMag;
varargout{2} = faultID;

end