function [dx_dt] = dxdt_case6(x, u, f, w)

[Kp1,Kp2,Ka,Kb,K13,K23,K1,K2,K3] = get_valves_state(f);

[A,Beta,h0] = get_parameters();

x1 = x(1);
x2 = x(2);
x3 = x(3);

u1  = Kp1 * u(1);
u2  = Kp2 * u(2);

Qa  = Ka  * Beta * sign(x1-x3) * sqrt(abs(x1-x3));
Qb  = Kb  * Beta * sign(h0-x3) * sqrt(abs(h0-x3));
Q13 = K13 * Beta * sign(x1-x3) * sqrt(abs(x1-x3));
Q23 = K23 * Beta * sign(x2-x3) * sqrt(abs(x2-x3));
Q1  = K1  * Beta * sqrt(abs(x1));
Q2  = K2  * Beta * sqrt(abs(x2));
Q3  = K3  * Beta * sqrt(abs(x3));

dx1_dt = 1/A * (u1 - Qa - Q13 - Q1);
dx2_dt = 1/A * (u2 - Qb - Q23 - Q2);
dx3_dt = 1/A * (Q13 + Q23 + Qa + Qb - Q3);

dx_dt = [dx1_dt dx2_dt dx3_dt]' + w;

end