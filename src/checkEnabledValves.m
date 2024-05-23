function [varargout] = checkEnabledValves(varargin)
% checkEnabledValves is a Sim3Tanks function. This function checks the
% valves that have the EnableControl field set to true in a Sim3TanksClass
% object and returns an array with the OpeningRate field values. If the
% EnableControl field is set to false, then the returned value will be 0 or
% 1, depending on the operation mode configured in the model (Closed or
% Open, respectively). A second array with the IDs of the enabled valves is
% also returned.

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
    LIST_OF_VALVES = SIM3TANKS_LISTS.LIST_OF_VALVES;
end
%==========================================================================

opMode = checkOperationMode(objSim3Tanks);

valveOpeningRate = zeros(size(LIST_OF_VALVES));
valveID = cell(size(LIST_OF_VALVES));

for i = 1 : numel(LIST_OF_VALVES)
    valve = objSim3Tanks.(ClassPropers{2}).(LIST_OF_VALVES{i});
    if(islogical(valve.EnableControl) && valve.EnableControl)
        valveOpeningRate(i) = satSignal(valve.OpeningRate,[0 1]);
        valveID{i} = LIST_OF_VALVES{i};
    elseif(islogical(valve.EnableControl))
        valveOpeningRate(i) = opMode(i);
        valveID{i} = [];
    else
        error(errorMessage(11));
    end
end

varargout{1} = valveOpeningRate;
varargout{2} = valveID;

end