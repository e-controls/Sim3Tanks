function [varargout] = checkEnabledValves(varargin)
% checkEnabledValves is a Sim3Tanks function. This function checks the
% valves that have the EnableControl field set to true in a Sim3TanksClass
% object and returns an array with the OpeningRate field values. If the
% EnableControl field is set to false, then the returned value will be 0 or
% 1, depending on the operation mode configured in the model (Closed or
% Open, respectively). A second array with the IDs of the enabled valves is
% also returned.

% Written by Arllem Farias, January/2024.
% Last update June/2024 by Arllem Farias.

%==========================================================================

if(nargin()<1)
    error(getMessage('ERR001'));
elseif(nargin()>1)
    error(getMessage('ERR002'));
end

if(isa(varargin{1},'Sim3TanksModel'))
    objSim3Tanks = varargin{1};
else
    error(getMessage('ERR004'));
end

%==========================================================================

LIST_OF_FIELDS = Sim3TanksModel.LIST_OF_FIELDS;
LIST_OF_VALVES = Sim3TanksModel.LIST_OF_VALVES;

%==========================================================================

opMode = checkOperationMode(objSim3Tanks);

valveOpeningRate = zeros(size(LIST_OF_VALVES));
valveID = cell(size(LIST_OF_VALVES));

for i = 1 : numel(LIST_OF_VALVES)

    valve = objSim3Tanks.Model.(LIST_OF_FIELDS{2}).(LIST_OF_VALVES{i});

    if(islogical(valve.EnableControl) && valve.EnableControl)

        if(isempty(valve.OpeningRate))
            warning(getMessage('WARN003'));
            valveOpeningRate(i) = opMode(i);
        elseif(valve.OpeningRate<0 || valve.OpeningRate>1)
            warning(getMessage('WARN004'));
            valveOpeningRate(i) = satSignal(valve.OpeningRate,[0 1]);
        else
            valveOpeningRate(i) = valve.OpeningRate;
        end

        valveID{i} = LIST_OF_VALVES{i};

    elseif(islogical(valve.EnableControl))
        valveOpeningRate(i) = opMode(i);
        valveID{i} = [];

    else
        error(getMessage('ERR010'));
    end

end

varargout{1} = valveOpeningRate;
varargout{2} = valveID;

end