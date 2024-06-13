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
        msg = 'Uma falha Habilitada esta com o campo Magnitude Vazio, assume-se 0!';%'An enabled fault has its Magnitude field set to empty.';
    case 'WARN002'
        msg = 'A magnitude de uma falha esta fora dos limites [0,1], satura-se!';
    case 'WARN003'
        msg = 'Uma valvula Habilitada esta com o campo OpeningRate Vazio, assume-se OperationMode!';
    case 'WARN004'
        msg = 'O OpeningRate de uma valvula esta fora dos limites [0,1], satura-se!';
    case 'WARN005'
        msg = 'processNoise esta habilitado, mas Magnitude eh vazio, assume-se zero!';
    case 'WARN006'
        msg = 'measurmentNoise esta habilitado, mas Magnitude eh vazio, assume-se zero!';
    otherwise
        msg = ['Code ',messageCode,' not found!'];
        messageCode = [];
end

varargout{1} = [tagSim3Tanks,messageCode,': ',msg];

end