function dxdt = sysDynamicModel(A,q,w)
% sysDynamicModel is a Sim3Tanks function. This function describes the
% dynamic model of the three-tank system.
%
% Example:
%   dxdt = sysDynamicModel(A,q,w)
%       A : cross-sectional area of the tanks
%       q : flow rate vector
%       w : process noise vector

% https://github.com/e-controls/Sim3Tanks

%==========================================================================

if(nargin()<3)
    error(getMessage('ERR001'));
elseif(nargin()>3)
    error(getMessage('ERR002'));
end

%==========================================================================

Q1in = q(1);
Q2in = q(2);
Q3in = q(3);
Qa   = q(4);
Qb   = q(5);
Q13  = q(6);
Q23  = q(7);
Q1   = q(8);
Q2   = q(9);
Q3   = q(10);

dx1dt = (1/A)*(Q1in - Qa - Q13 - Q1) + w(1);
dx2dt = (1/A)*(Q2in - Qb - Q23 - Q2) + w(2);
dx3dt = (1/A)*(Q3in + Q13 + Q23 + Qa + Qb - Q3) + w(3);

dxdt = [dx1dt ; dx2dt ; dx3dt];

end