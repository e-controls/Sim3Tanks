function [varargout] = getDefaultLinearModel(varargin)
% getDefaultLinearModel is a Sim3Tanks method. This method returns a linear
% model of the default scenario.
%
% Example:
%   [SYS,OP] = getDefaultLinearModel(objSim3Tanks,x1op,METHOD,TSPAN)

% Written by Arllem Farias, Jun/2024.
% Last update Jun/2024 by Arllem Farias.

%==========================================================================

if(nargin()>4)
    error(errorMessage(02));
elseif(mod(nargin(),2) ~= 0)
    error(errorMessage(22));
else
    objSim3Tanks = varargin{1};
end

%==========================================================================

[Param,ID] = checkPhysicalParam(objSim3Tanks);

Rtank = Param.(ID{1});
Hmax  = Param.(ID{2});
Rpipe = Param.(ID{3});
h0    = Param.(ID{4});
mu    = Param.(ID{5});
g     = Param.(ID{6});
Qmin  = Param.(ID{7});
Qmax  = Param.(ID{8});

Sc = pi()*(Rtank^2); % Cross-sectional area of the tanks (cm^2)
S  = pi()*(Rpipe^2); % Cross-sectional area of the pipes (cm^2)
Beta = mu*S*sqrt(2*g); % Constant value

%==========================================================================

x1op = varargin{2};

if(~(isnumeric(x1op) && isfinite(x1op) && isscalar(x1op) && x1op>0 && x1op<Hmax))
    error(errorMessage(03));
end

%==========================================================================

% Operating point
x2op = x1op;
x3op = (4/5)*x1op;

u1op = (Beta/Qmax)*sqrt(x1op/5);
u2op = u1op;

X13 = x1op - x3op;
X23 = x2op - x3op;

Q13op = Beta*sign(X13)*sqrt(abs(X13));
Q23op = Beta*sign(X23)*sqrt(abs(X23));
Q3op  = Beta*sqrt(x3op);

x_op = [x1op; x2op; x3op];
u_op = [u1op; u2op];
y_op = [x1op; x2op; Q13op; Q23op; Q3op];

a11 = -(1/sqrt(abs(X13)))*(X13/(abs(X13)));
a22 = -(1/sqrt(abs(X23)))*(X23/(abs(X23)));
a33 = -(1/sqrt(x3op)) + a11 + a22;

A  = (Beta/(2*Sc))*[a11 0 -a11; 0 a22 -a22; -a11 -a22 a33];
B  = (1/Sc)*[Qmax 0; 0 Qmax; 0 0];
Cx = [1 0 0; 0 1 0];
Cq = (Beta/2)*[-a11 0 a11; 0 -a22 a22; 0 0 1/sqrt(x3op)];
C  = [Cx;Cq];
D  = zeros(size(C,1),size(B,2));

% Continuous model
SYS = ss(A,B,C,D);

OP.x = x_op;
OP.u = u_op;
OP.y = y_op;

% Discrete model
if(nargin()==4)

    METHOD = varargin{3};
    TS = varargin{4};

    % Valid methods
    options.zoh     = 'zoh';
    options.foh     = 'foh';
    options.impulse = 'impulse';
    options.tustin  = 'tustin';
    options.matched = 'matched';
    options.euler   = 'euler';

    if(~isfield(options,lower(METHOD)))
        error(errorMessage(03));
    end

    if(~(isnumeric(TS) && isfinite(TS) && isscalar(TS) && TS>0))
        error(errorMessage(03));
    end

    if(strcmpi(METHOD,options.euler))
        nx = size(A,2); % x = [h1 h2 h3]'
        SYS = ss(eye(nx)+TS*A,TS*B,C,D,TS);

    else
        % c2d function from MATLAB
        SYS = c2d(SYS,TS,METHOD);
    end
end

varargout{1} = SYS;
varargout{2} = OP;

end