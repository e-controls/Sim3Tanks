function [varargout] = defaultOperationMode(varargin)
% defaultOperationMode is a Sim3Tanks function. This function returns the
% default operation mode of the system valves.
%
% d = defaultOperationMode(v) returns the default state of a specific
% valve, the input argument can be:
%       v = 'Kp1'
%       v = 'Kp2'
%       v = 'Kp3'
%       v = 'Ka'
%       v = 'Kb'
%       v = 'K13'
%       v = 'K23'
%       v = 'K1'
%       v = 'K2'
%       v = 'K3'
%
% If the input argument is omitted, all valve states are grouped and
% returned into a single struct.

% https://github.com/e-controls/Sim3Tanks

%==========================================================================

if(nargin()>1)
    error(getMessage('ERR002'));
end

%==========================================================================

valve{1}  = 'Open';   % Default state of the valve Kp1
valve{2}  = 'Open';   % Default state of the valve Kp2
valve{3}  = 'Closed'; % Default state of the valve Kp3
valve{4}  = 'Closed'; % Default state of the valve Ka
valve{5}  = 'Closed'; % Default state of the valve Kb
valve{6}  = 'Open';   % Default state of the valve K13
valve{7}  = 'Open';   % Default state of the valve K23
valve{8}  = 'Closed'; % Default state of the valve K1
valve{9}  = 'Closed'; % Default state of the valve K2
valve{10} = 'Open';   % Default state of the valve K3

LIST_OF_VALVES = Sim3Tanks.LIST_OF_VALVES;

if(numel(valve) ~= numel(LIST_OF_VALVES))
    error(getMessage('ERR006'));
end

%==========================================================================

if(nargin()==0)

    for i = 1 : numel(LIST_OF_VALVES)
        default.(LIST_OF_VALVES{i}) = valve{i};
    end
    varargout{1} = default;

elseif(nargin()==1)

    varargout{1} = [];
    for i = 1 : numel(LIST_OF_VALVES)
        if(strcmpi(varargin{1},LIST_OF_VALVES{i}))
            varargout{1} = valve{i};
            break;
        end
    end

    if(isempty(varargout{1}))
        error(getMessage('ERR003'));
    end

else
    error(getMessage('ERR000'));
end