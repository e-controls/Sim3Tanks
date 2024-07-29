function [varargout] = checkEnabledValves(varargin)
% checkEnabledValves is a Sim3Tanks function. This function checks the
% valves that have the EnableControl field set to true in a Sim3TanksClass
% object and returns an array with the IDs of the enabled valves. A second
% array with the OpeningRate field values is also returned. If the
% EnableControl field is set to false, then the returned value will be 0
% or 1, depending on the operation mode configured in the model (Closed or
% Open, respectively).

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

opMode = checkOperationMode(objSim3Tanks);

valveID = cell(size(LIST_OF_VALVES));
openingRate = zeros(size(LIST_OF_VALVES));

for i = 1 : numel(LIST_OF_VALVES)

    valve = objSim3Tanks.Model.(LIST_OF_FIELDS{2}).(LIST_OF_VALVES{i});

    if(islogical(valve.EnableControl) && valve.EnableControl)

        if(isempty(valve.OpeningRate))
            warning(getMessage('WARN003'));
            openingRate(i) = opMode(i);
        elseif(valve.OpeningRate<0 || valve.OpeningRate>1)
            warning(getMessage('WARN004'));
            openingRate(i) = satSignal(valve.OpeningRate,[0 1]);
        else
            openingRate(i) = valve.OpeningRate;
        end

        valveID{i} = LIST_OF_VALVES{i};

    elseif(islogical(valve.EnableControl))
        openingRate(i) = opMode(i);
        valveID{i} = [];
    else
        error(getMessage('ERR010'));
    end

end

varargout{1} = valveID;
varargout{2} = openingRate;

end