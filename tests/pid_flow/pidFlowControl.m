function [uk] = pidFlowControl(ek_past,uk_past,Ts)

e_k   = ek_past(3);
e_k_1 = ek_past(2);
e_k_2 = ek_past(1);

u1_k_2 = uk_past(1,1);
u2_k_2 = uk_past(2,1);

% Saturation info
u_min = 0;
u_max = 1;

% Controller gains
Kp = 0.05;
Ki = 0.01;
Kd = 0.001;

Ti = Kp/Ki;
Td = Kd/Kp;

% Digital PID controllers (Approximate by Tustin)
a0 = Kp*(1 + Ts/(2*Ti) + 2*Td/Ts);
a1 = Kp*(Ts/Ti - 4*Td/Ts);
a2 = Kp*(-1 + Ts/(2*Ti) + 2*Td/Ts);

% PID to valve Kp1
u1 = u1_k_2 + a0*e_k + a1*e_k_1 + a2*e_k_2;
u1 = min(u_max,max(u_min,u1)); % Saturation

% PID to valve Kp2
u2 = u2_k_2 + a0*e_k + a1*e_k_1 + a2*e_k_2;
u2 = min(u_max,max(u_min,u2)); % Saturation

% Control signal
uk = [u1 u2]';

end