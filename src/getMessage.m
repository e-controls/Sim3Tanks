function [varargout] = getMessage(varargin)
% getMessage is a Sim3Tanks function. This function returns the message
% associated with a code.

% Written by Arllem Farias, June/2024.
% Last update June/2024 by Arllem Farias.

%==========================================================================

if(nargin()<1)
    error(getMessage('ERR001'));
elseif(nargin()>1)
    error(getMessage('ERR002'));
else
    messageCode = upper(varargin{1});
end

%==========================================================================

tagSim3Tanks = '#SIM3TANKS::';

if ~ischar(messageCode)
    error([tagSim3Tanks,'ERR999:','The input argument must be a char type, not a %s.'],class(messageCode));
end

switch messageCode
    case 'TAG'
        msg = [];
        messageCode = [];
    case 'ERR000'
        msg = 'Unknown error.';
    case 'ERR001'
        msg = 'Not enough input arguments.';
    case 'ERR002'
        msg = 'Too many input arguments.';
    case 'ERR003'
        msg = 'Invalid input parameter.';
    case 'WARN001'
        msg = 'An enabled fault has its Magnitude field set to empty. In this case, zero is assumed as the default value.';
    case 'WARN002'
        msg = 'The magnitude of an enabled fault is out of bounds [0,1]. In this case, its value is saturated.';
    case 'WARN003'
        msg = 'An enabled valve has its OpeningRate field set to empty. In this case, OperationMode is assumed as the default value.';
    case 'WARN004'
        msg = 'The OpeningRate of an enabled valve is out of bounds [0,1]. In this case, its value is saturated.';
    case 'WARN005'
        msg = 'The processNoise is enabled, but its magnitude is set to empty. In this case, a row vector of zeros is assumed as the default value.';
    case 'WARN006'
        msg = 'The measurmentNoise is enabled, but its magnitude is set to empty. In this case, a row vector of zeros is assumed as the default value.';
    otherwise
        msg = ['Code ',messageCode,' not found!'];
        messageCode = [];
end

varargout{1} = [tagSim3Tanks,messageCode,': ',msg];

end