function [varargout] = defaultPhysicalParam(varargin)
% defaultPhysicalParam is a Sim3Tanks function. This function returns the
% default physical parameters of the three-tank system.
%
% d = defaultPhysicalParam(p) returns the default value of a specific
% parameter, the input argument can be:
%       p = 'tankRadius'
%       p = 'tankHeight'
%       p = 'pipeRadius'
%       p = 'transPipeHeight'
%       p = 'correctionTerm'
%       p = 'gravityConstant'
%       p = 'pumpMinFlow'
%       p = 'pumpMaxFlow'
%
% If the input argument is omitted, all parameters are grouped and returned
% in a single struct.

% Written by Arllem Farias, January/2024.
% Last update June/2024 by Arllem Farias.

%==========================================================================

if(nargin()>1)
    error(errorMessage(02));
end

%==========================================================================

param{1} = 5;   % Radius of the tanks (cm)
param{2} = 50;  % Height of the tanks (cm)
param{3} = 0.6; % Radius of the pipes (cm)
param{4} = 30;  % Height of the transmission pipes (cm)
param{5} = 1;   % Flow correction term (-)
param{6} = 981; % Gravity constant (cm/s^2)
param{7} = 0;   % Minimum flow value of the pumps (cm^3/s)
param{8} = 120; % Maximum flow value of the pumps (cm^3/s)

LIST_OF_PARAM = Sim3TanksModel.LIST_OF_PARAM;

if(numel(param) ~= numel(LIST_OF_PARAM))
    error(errorMessage(06));
end

%==========================================================================

if(nargin()==0)

    for i = 1 : numel(LIST_OF_PARAM)
        default.(LIST_OF_PARAM{i}) = param{i};
    end

    varargout{1} = default;

elseif(nargin()==1)

    varargout{1} = [];
    for i = 1 : numel(LIST_OF_PARAM)
        if(strcmpi(varargin{1},LIST_OF_PARAM{i}))
            varargout{1} = param{i};
            break;
        end
    end

    if(isempty(varargout{1}))
        error(errorMessage(03));
    end

else
    error(errorMessage(00));
end
