function [varargout] = checkOperationMode(varargin)
% checkOperationMode is a Sim3Tanks function. This function checks the
% operation mode of a Sim3TanksClass object and returns an array with 0 and
% 1, where 0 corresponds to Closed and 1 corresponds to Open. A second
% array with the IDs of the valves is also returned.

% Written by Arllem Farias, January/2024.
% Last update May/2024 by Arllem Farias.

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

opMode = zeros(size(LIST_OF_VALVES));
valveID = cell(size(LIST_OF_VALVES));

for i = 1 : numel(LIST_OF_VALVES)
    valve = objSim3Tanks.(ClassPropers{2}).(LIST_OF_VALVES{i}).OperationMode;
    if(strcmpi(valve,'Open'))
        opMode(i) = 1;
    elseif(strcmpi(valve,'Closed'))
        opMode(i) = 0;
    else
        error(errorMessage(10));
    end
    valveID{i} = LIST_OF_VALVES{i};
end

varargout{1} = opMode;
varargout{2} = valveID;

end