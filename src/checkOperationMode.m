function [varargout] = checkOperationMode(varargin)
% checkOperationMode is a Sim3Tanks function. This function checks the
% operation mode of a Sim3TanksClass object and returns an array with 0 and
% 1, where 0 corresponds to Closed and 1 corresponds to Open. A second
% array with the IDs of the valves is also returned.

% Written by Arllem Farias, January/2024.
% Last update June/2024 by Arllem Farias.

%==========================================================================

if(nargin()<1)
    error(errorMessage(01));
elseif(nargin()>1)
    error(errorMessage(02));
end

if(isa(varargin{1},'Sim3TanksModel'))
    objSim3Tanks = varargin{1};
else
    error(errorMessage(07));
end

%==========================================================================

LIST_OF_FIELDS = Sim3TanksModel.LIST_OF_FIELDS;
LIST_OF_VALVES = Sim3TanksModel.LIST_OF_VALVES;

%==========================================================================

opMode = zeros(size(LIST_OF_VALVES));
valveID = cell(size(LIST_OF_VALVES));

for i = 1 : numel(LIST_OF_VALVES)
    valve = objSim3Tanks.Model.(LIST_OF_FIELDS{2}).(LIST_OF_VALVES{i}).OperationMode;
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