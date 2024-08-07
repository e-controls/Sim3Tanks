function [varargout] = checkEnabledFaults(varargin)
% checkEnabledFaults is a Sim3Tanks function. This function checks the
% faults that have EnableSignal field set to true in a Sim3Tanks object and
% returns an array with the IDs of the enabled faults. Two more arrays with
% the values ​​of the Magnitude and Offset fields are also returned. If the
% EnableSignal field is set to false, then the returned values will be 0.
%
% Example:
%   [faultID,faultMag,offset] = checkEnabledFaults(objSim3Tanks);

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
LIST_OF_FAULTS = Sim3Tanks.LIST_OF_FAULTS;

%==========================================================================

faultID  = cell(size(LIST_OF_FAULTS));
faultMag = zeros(size(LIST_OF_FAULTS));
offset   = zeros(size(LIST_OF_FAULTS));

for i = 1 : numel(LIST_OF_FAULTS)

    fault = objSim3Tanks.Model.(LIST_OF_FIELDS{3}).(LIST_OF_FAULTS{i});

    if(islogical(fault.EnableSignal) && fault.EnableSignal)

        % Check magnitude values
        if(isempty(fault.Magnitude))
            warning(getMessage('WARN001'));
            faultMag(i) = 0;
        elseif(fault.Magnitude<0 || fault.Magnitude>1)
            warning(getMessage('WARN002'));
            faultMag(i) = satSignal(fault.Magnitude,[0 1]);
        else
            faultMag(i) = fault.Magnitude;
        end

        % Check offset values
        if(isfield(fault,'Offset'))
            if(isempty(fault.Offset))
                warning(getMessage('WARN007'));
                offset(i) = 0;
            elseif(~isfinite(fault.Offset))
                error(getMessage('ERR022'));
            else
                offset(i) = fault.Offset;
            end
        end

        faultID{i} = LIST_OF_FAULTS{i};

    elseif(islogical(fault.EnableSignal))
        faultID{i}  = [];
        faultMag(i) = 0;
        offset(i)   = 0;
    else
        error(getMessage('ERR011'));
    end

end

varargout{1} = faultID;
varargout{2} = faultMag;
varargout{3} = offset;

end