function [uk] = pidLevelControl(ek_past,uk_past,Ts)

e1_k   = ek_past(1,3);
e1_k_1 = ek_past(1,2);
e1_k_2 = ek_past(1,1);

e2_k   = ek_past(2,3);
e2_k_1 = ek_past(2,2);
e2_k_2 = ek_past(2,1);

u1_k_2 = uk_past(1,1);
u2_k_2 = uk_past(2,1);

% Saturation info
u_min = 0;
u_max = 120;

% Controller gains
Kp = 5;
Ki = 10;
Kd = 0.05;

Ti = Kp/Ki;
Td = Kd/Kp;

% Digital PID controllers (Approximate by Tustin)
a0 = Kp*(1 + Ts/(2*Ti) + 2*Td/Ts);
a1 = Kp*(Ts/Ti - 4*Td/Ts);
a2 = Kp*(-1 + Ts/(2*Ti) + 2*Td/Ts);

% PID to valve Kp1
u1 = u1_k_2 + a0*e1_k + a1*e1_k_1 + a2*e1_k_2;
u1 = min(u_max,max(u_min,u1)); % Saturation

% PID to valve Kp2
u2 = u2_k_2 + a0*e2_k + a1*e2_k_1 + a2*e2_k_2;
u2 = min(u_max,max(u_min,u2)); % Saturation

% Control signal
uk = [u1 u2]';

end