function [] = set_operation_mode(OPMODE)
% SET_OPERATION_MODE(OPMODE) sets the operation mode of the valves. The
% input argument must have the following structure:
%
%   OPMODE = [Kp1,Kp2,Ka,Kb,K13,K23,K1,K2,K3]
%
% where each element of OPMODE must be 0 (closed) or 1 (open).
%
% This function does not have output arguments.
%
% See also GET_OPERATION_MODE.

% • Kp1 : input valve of the tank 1;
% • Kp2 : input valve of the tank 2;
% • Ka  : transmission valve from the tank 1 to the tank 3;
% • Kb  : transmission valve from the tank 2 to the tank 3;
% • K13 : connection valve from the tank 1 to the tank 3;
% • K23 : connection valve from the tank 2 to the tank 3;
% • K1  : output valve from the tank 1;
% • K2  : output valve from the tank 2;
% • K3  : output valve from the tank 3.

% Written by Arllem Farias, 2018.

n = length(OPMODE);

global opmode;
opmode = zeros(1,n);

for i = 1 : n
    if(OPMODE(i)==0||OPMODE(i)==1)
        opmode(i) = OPMODE(i);
    end
end
