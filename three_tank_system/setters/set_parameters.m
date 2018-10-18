function [] = set_parameters(my_R, my_Hmax, my_r, my_h0, my_mu, my_g)
% SET_PARAMETERS(R,Hmax,r,h0,mu,g) sets the constants and the physical
% dimensions of the system. The input arguments are:
%   • R    : Radius of the tanks (cm);
%   • Hmax : Height of the tanks (cm);
%   • r    : Radius of the pipes (cm);
%   • h0   : Height of the transmission pipes (cm);
%   • mu   : Flow correction term (-);
%   • g    : Gravity constant (cm/s^2).
%
% This function does not have output arguments.
%
% See also GET_PARAMETERS.

% Written by Arllem Farias, 2018.

global R;
global Hmax;
global r;
global h0;
global mu;
global g;

R    = my_R;
Hmax = my_Hmax;
r    = my_r;
h0   = my_h0;
mu   = my_mu;
g    = my_g;

end