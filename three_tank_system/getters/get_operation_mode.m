function [dvalve] = get_operation_mode(K)

global d_valve;

if (nargin()==0)
    dvalve = d_valve;
else
    switch lower(K)
        case 'kp1'
            dvalve = d_valve(1);
        case 'kp2'
            dvalve = d_valve(2);
        case 'ka'
            dvalve = d_valve(3);
        case 'kb'
            dvalve = d_valve(4);
        case 'k13'
            dvalve = d_valve(5);
        case 'k23'
            dvalve = d_valve(6);
        case 'k1'
            dvalve = d_valve(7);
        case 'k2'
            dvalve = d_valve(8);
        case 'k3'
            dvalve = d_valve(9);
    end
end