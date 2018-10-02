function [] = set_data_control(e, u)

global e_control; %[e(k-1) e(k-2)]
global u_control; %[u(k-1) u(k-2)]

e_control = e;
u_control = u;

end