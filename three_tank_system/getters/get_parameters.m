function [varargout] = get_parameters(parameter)
%% Cylindrical tanks
global R;     % Tanks radius (cm)
global Hmax;  % Tanks height (cm)
A = pi()*(R^2); % Cross-section area of the tanks (cm^2)

%% Connection and transmission pipes
global r;     % Pipes radius (cm)
global h0;    % Transmission pipes height (cm)
S = pi()*(r^2); % Cross-section area of the pipes (cm^2)

%% Constants
global mi;    % Flow correction term (-)
global g;     % Gravity constant (cm/s^2)

Beta = mi*S*sqrt(2*g);

if (nargin()==0)
    varargout{1} = A;
    varargout{2} = Beta;
    varargout{3} = h0;
else
    if(strcmp(parameter,'A'))
        varargout{1} = A;
    elseif (strcmp(parameter,'Beta'))
        varargout{1} = Beta;
    elseif (strcmp(parameter,'h0'))
        varargout{1} = h0;
    elseif (strcmp(parameter,'Hmax'))
        varargout{1} = Hmax;
    end
end