function [varargout] = checkEnabledFaults(varargin)
% checkEnabledFaults is a Sim3Tanks function. This function checks the
% faults that have EnableSignal field set to true in a Sim3TanksClass
% object and returns an array with the Magnitude field values. If the
% EnableSignal field is set to false, then the returned value will be 0. A
% second array with the IDs of the enabled faults is also returned.

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
LIST_OF_FAULTS = Sim3TanksModel.LIST_OF_FAULTS;

%==========================================================================

faultMag = zeros(size(LIST_OF_FAULTS));
faultID = cell(size(LIST_OF_FAULTS));

for i = 1 : numel(LIST_OF_FAULTS)

    fault = objSim3Tanks.Model.(LIST_OF_FIELDS{3}).(LIST_OF_FAULTS{i});

    if(islogical(fault.EnableSignal) && fault.EnableSignal)

        if(isempty(fault.Magnitude))
            warning(getMessage('WARN001'));
            faultMag(i) = 0;
        elseif(fault.Magnitude<0 || fault.Magnitude>1)
            warning(getMessage('WARN002'));
            faultMag(i) = satSignal(fault.Magnitude,[0 1]);
        else
            faultMag(i) = fault.Magnitude;
        end

        faultID{i} = LIST_OF_FAULTS{i};

    elseif(islogical(fault.EnableSignal))
        faultMag(i) = 0;
        faultID{i} = [];

    else
        error(getMessage('ERR011'));
    end

end

varargout{1} = faultMag;
varargout{2} = faultID;

end