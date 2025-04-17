function [varargout] = getMessage(varargin)
% getMessage is a Sim3Tanks function. This function returns the message
% associated with a code.

% https://github.com/e-controls/Sim3Tanks

%==========================================================================

if(nargin()<1)
    error(getMessage('ERR001'));
elseif(nargin()>1)
    error(getMessage('ERR002'));
else
    messageCode = upper(varargin{1});
end

%==========================================================================

LIST_OF_FIELDS = Sim3Tanks.LIST_OF_FIELDS;
LIST_OF_PARAM  = Sim3Tanks.LIST_OF_PARAM;

tagSim3Tanks = '#Sim3Tanks::';

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

    case 'ERR004'
        msg = 'The input argument must be a Sim3Tanks object.';

    case 'ERR005'
        msg = 'The input argument must be a row vector.';

    case 'ERR006'
        msg = 'The dimensions are not consistent.';

    case 'ERR007'
        msg = 'The state variabels must be finite.';

    case 'ERR008'                 % PhysicalParam
        msg = ['The subfields of <',LIST_OF_FIELDS{1},'> must have real and finite values.'];

    case 'ERR009'
        msg = 'The field <OperationMode> must be set to ''Open'' or ''Closed''.';

    case 'ERR010'
        msg = 'The field <EnableControl> must be set to a logical value (true or false).';

    case 'ERR011'
        msg = 'The field <EnableSignal> must be set to a logical value (true or false).';

    case 'ERR012'          % TankRadius
        msg = ['The field <',LIST_OF_PARAM{1},'> must be greater than 0.'];

    case 'ERR013'          % TankHeight
        msg = ['The field <',LIST_OF_PARAM{2},'> must be greater than 0.'];

    case 'ERR014'          % PipeRadius                                                % TankRadius
        msg = ['The field <',LIST_OF_PARAM{3},'> must be greater than 0 and less than <',LIST_OF_PARAM{1},'>.'];

    case 'ERR015'          % TransPipeHeight                                           % TankHeight
        msg = ['The field <',LIST_OF_PARAM{4},'> must be greater than 0 and less than <',LIST_OF_PARAM{2},'>.'];

    case 'ERR016'          % CorrectionTerm
        msg = ['The field <',LIST_OF_PARAM{5},'> must be greater than 0.'];

    case 'ERR017'          % GravityConstant
        msg = ['The field <',LIST_OF_PARAM{6},'> must be greater than 0.'];

    case 'ERR018'          % PumpMinFlow
        msg = ['The field <',LIST_OF_PARAM{7},'> must be greater than or equal to 0.'];

    case 'ERR019'          % PumpMaxFlow                                           % PumpMinFlow
        msg = ['The field <',LIST_OF_PARAM{8},'> must be greater than or equal to <',LIST_OF_PARAM{7},'>.'];

    case 'ERR020'
        msg = 'Invalid number of input arguments (must be even).';

    case 'ERR021'
        msg = 'Invalid number of input arguments (must be odd).';

    case 'ERR022'
        msg = 'The sensor fault offset value must be finite.';

    case 'ERR023'
        msg = 'The input argument must be a row or a column vector of numeric type.';

    case 'ERR024'
        msg = 'The initial condition must be a three-position row vector.';

        %
        %
        %

    case 'WARN001'
        msg = 'The Magnitude of an enabled fault is set to empty, so zero is assumed as the default value.';

    case 'WARN002'
        msg = 'The Magnitude of an enabled fault is out of bounds [0,1], so its value is saturated.';

    case 'WARN003'
        msg = 'The OpeningRate of an enabled valve is set to empty, so OperationMode is assumed as the default value.';

    case 'WARN004'
        msg = 'The OpeningRate of an enabled valve is out of bounds [0,1], so its value is saturated.';

    case 'WARN005'
        msg = 'The ProcessNoise Magnitude is set to empty, so a row vector of zeros is assumed as the default value.';

    case 'WARN006'
        msg = 'The MeasurmentNoise Magnitude is set to empty, so a row vector of zeros is assumed as the default value.';

    case 'WARN007'
        msg = 'The Offset of a sensor fault is set to empty, so zero is assumed as the default value.';

    case 'WARN008'
        msg = 'There is no value to plot (the variable is empty).';

    otherwise
        msg = ['Code ',messageCode,' not found!'];
        messageCode = [];

end

varargout{1} = [tagSim3Tanks,messageCode,': ',msg];

end