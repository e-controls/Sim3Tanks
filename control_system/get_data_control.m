function [e, u] = get_data_control()

global e_control; %[e(k-1) e(k-2)]
global u_control; %[u(k-1) u(k-2)]

e = e_control;
u = u_control;

end