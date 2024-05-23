function [dxdt] = dxdtModel(A,q,w)
% dxdtModel is a Sim3Tanks function. This function describes the state
% equations of the three-tank system.

% Written by Arllem Farias, January/2024.
% Last update January/2024 by Arllem Farias.

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

dx1dt = 1/A * (Q1in - Qa - Q13 - Q1) + w(1);
dx2dt = 1/A * (Q2in - Qb - Q23 - Q2) + w(2);
dx3dt = 1/A * (Q3in + Q13 + Q23 + Qa + Qb - Q3) + w(3);

dxdt = [dx1dt dx2dt dx3dt]';

end