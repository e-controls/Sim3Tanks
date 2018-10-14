function [varargout] = get_parameters(PARAM)
% GET_PARAMETERS(PARAM) returns the parameter PARAM from the system.
%
% PARAM options:
%   • If PARAM='A', then returns the cross-sectional area of the tanks;
%   • If PARAM='Beta', then returns the constant terms of the flow equation;
%   • If PARAM='h0', then returns the height of the transmission pipes;
%   • If PARAM='Hmax', then returns the height of the tanks;
%   • If PARAM is omitted from the argument, then returns [A,Beta,h0,Hmax].
%
% See also SET_PARAMETERS.

% Written by Arllem Farias, 2018.

%% Cylindrical tanks
global R;       % Radius of the tanks (cm)
global Hmax;    % Height of the tanks (cm)
A = pi()*(R^2); % Cross-sectional area of the tanks (cm^2)

%% Connection and transmission pipes
global r;       % Radius of the pipes (cm)
global h0;      % Height of the transmission pipes (cm)
S = pi()*(r^2); % Cross-sectional area of the pipes (cm^2)

%% Constants
global mu; % Flow correction term (-)
global g;  % Gravity constant (cm/s^2)

Beta = mu*S*sqrt(2*g);

%% Output arguments
if (nargin()==0)
    varargout{1} = A;
    varargout{2} = Beta;
    varargout{3} = h0;
    varargout{4} = Hmax;
else
    switch(PARAM)
        case 'A'
            varargout{1} = A;
        case 'Beta'
            varargout{1} = Beta;
        case 'h0'
            varargout{1} = h0;
        case 'Hmax'
            varargout{1} = Hmax;
        otherwise
            error('Invalid parameter option, try: A, Beta, h0, or Hmax.');
    end
end