function [varargout] = setDefaultModel(varargin)
% setDefaultModel is a Sim3Tanks function. This function configures a
% Sim3Tanks object to the default model.

% Written by Arllem Farias, January/2024.
% Last update February/2024 by Arllem Farias.

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
    LIST_OF_FAULTS = SIM3TANKS_LISTS.LIST_OF_FAULTS;
    LIST_OF_PARAM  = SIM3TANKS_LISTS.LIST_OF_PARAM;
    Nx = numel(SIM3TANKS_LISTS.LIST_OF_STATES);
    Nq = numel(SIM3TANKS_LISTS.LIST_OF_FLOWS);
end
%==========================================================================

D = defaultPhysicalParam();
for i = 1 : numel(LIST_OF_PARAM)
    objSim3Tanks.(ClassPropers{1}).(LIST_OF_PARAM{i}) = D.(LIST_OF_PARAM{i});
end

D = defaultOperationMode();
for i = 1 : numel(LIST_OF_VALVES)
    objSim3Tanks.(ClassPropers{2}).(LIST_OF_VALVES{i}).OperationMode = D.(LIST_OF_VALVES{i});
end

K = checkOperationMode(objSim3Tanks);
for i = 1 : numel(LIST_OF_VALVES)
    objSim3Tanks.(ClassPropers{2}).(LIST_OF_VALVES{i}).EnableControl = false;
    objSim3Tanks.(ClassPropers{2}).(LIST_OF_VALVES{i}).OpeningRate = K(i);
end

for i = 1 : numel(LIST_OF_FAULTS)
    objSim3Tanks.(ClassPropers{3}).(LIST_OF_FAULTS{i}).EnableSignal = false;
    objSim3Tanks.(ClassPropers{3}).(LIST_OF_FAULTS{i}).Magnitude = 0;
end

objSim3Tanks.(ClassPropers{4}).EnableSignal = false;
objSim3Tanks.(ClassPropers{4}).Magnitude = zeros(1,Nx);

objSim3Tanks.(ClassPropers{5}).EnableSignal = false;
objSim3Tanks.(ClassPropers{5}).Magnitude = zeros(1,Nx+Nq);

objSim3Tanks.(ClassPropers{6}) = [40 25 20]; % [h1 h2 h3]

varargout{1} = resetVariables(objSim3Tanks);

end