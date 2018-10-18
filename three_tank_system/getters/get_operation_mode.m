function [OPMODE] = get_operation_mode(K)
% OPMODE=GET_OPERATION_MODE(K) returns the operation mode of the valves.
%
% See also SET_OPERATION_MODE.

% Written by Arllem Farias, 2018.

global opmode;

if (nargin()==0)
    OPMODE = opmode;
else
    switch lower(K)
        case 'kp1'
            OPMODE = opmode(1);
        case 'kp2'
            OPMODE = opmode(2);
        case 'ka'
            OPMODE = opmode(3);
        case 'kb'
            OPMODE = opmode(4);
        case 'k13'
            OPMODE = opmode(5);
        case 'k23'
            OPMODE = opmode(6);
        case 'k1'
            OPMODE = opmode(7);
        case 'k2'
            OPMODE = opmode(8);
        case 'k3'
            OPMODE = opmode(9);
    end
end