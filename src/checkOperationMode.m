function [varargout] = checkOperationMode(varargin)
% checkOperationMode is a Sim3Tanks function. This function checks the
% operation mode of a Sim3TanksClass object and returns an array with 0 and
% 1, where 0 corresponds to Closed and 1 corresponds to Open. A second
% array with the IDs of the valves is also returned.

% https://github.com/e-controls/Sim3Tanks

%==========================================================================

if(nargin()<1)
    error(getMessage('ERR001'));
elseif(nargin()>1)
    error(getMessage('ERR002'));
end

if(isa(varargin{1},'Sim3Tanks'))
    objSim3Tanks = varargin{1};
else
    error(getMessage('ERR004'));
end

%==========================================================================

LIST_OF_FIELDS = Sim3Tanks.LIST_OF_FIELDS;
LIST_OF_VALVES = Sim3Tanks.LIST_OF_VALVES;

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
        error(getMessage('ERR009'));
    end
    valveID{i} = LIST_OF_VALVES{i};
end

varargout{1} = opMode;
varargout{2} = valveID;

end