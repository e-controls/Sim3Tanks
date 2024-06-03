function [varargout] = errorMessage(varargin)
% errorMessage is a Sim3Tanks function. This function returns the message
% associated with an error code.

% Written by Arllem Farias, January/2024.
% Last update May/2024 by Arllem Farias.

%==========================================================================

if(nargin()<1)
    error(errorMessage(01));
elseif(nargin()>1)
    error(errorMessage(02));
end

%==========================================================================

codeError = varargin{1};
tagError  = '#SIM3TANKS Error. ';

if ~isnumeric(codeError)
    error([tagError,'The input argument must be a numeric type, not a %s.'],class(codeError));
end

switch codeError
    case -1
        msg = [];
    case 00
        msg = 'Unknown error.';
    case 01
        msg = 'Not enough input arguments.';
    case 02
        msg = 'Too many input arguments.';
    case 03
        msg = 'Invalid input parameter.';
    case 04
        msg = 'The Sim3Tanks global variables have not been declared.';
    case 05
        msg = 'The state variabels must be finite.';
    case 06
        msg = 'The dimensions are not consistent.';
    case 07
        msg = 'The input argument must be a Sim3TanksClass object.';
    case 08
        msg = 'The input argument must be a row vector.';
    case 09
        msg = 'The subfields of <PhysicalParam> must have real and finite values.';
    case 10
        msg = 'The field <OperationMode> must be set to ''Open'' or ''Closed''.';
    case 11
        msg = 'The field <EnableControl> must be set to a logical value (true or false).';
    case 12
        msg = 'The field <EnableSignal> must be set to a logical value (true or false).';
    case 13
        msg = 'The field <TankRadius> must be greater than 0.';
    case 14
        msg = 'The field <TankHeight> must be greater than 0.';
    case 15
        msg = 'The field <PipeRadius> must be greater than 0 and less than <TankRadius>.';
    case 16
        msg = 'The field <TransPipeHeight> must be greater than 0 and less than <TankHeight>.';
    case 17
        msg = 'The field <CorrectionTerm> must be greater than 0.';
    case 18
        msg = 'The field <GravityConstant> must be greater than 0.';
    case 19
        msg = 'The field <PumpMinFlow> must be greater than or equal to 0.';
    case 20
        msg = 'The field <PumpMaxFlow> must be greater than or equal to <PumpMinFlow>.';
    case 21
        msg = 'Invalid number of input arguments (must be even).';
    case 22
        msg = 'Invalid number of input arguments (must be odd).';
    otherwise
        msg = 'Error code not found!';
end

varargout{1} = [tagError,msg];

end