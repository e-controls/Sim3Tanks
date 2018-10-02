function [uk] = flow_pid_controller(setpoint, Qp, yk)

if(get_k() == 1)
    
    % Previous signals: e = [e(k-1) e(k-2)] , u = [u1(k-1) u1(k-2) ; u2(k-1) u2(k-2)]
    e = [0 0];
    u = [0 0 ; 0 0];
    
    % Current error
    ek  = setpoint - yk;
    
    % Updating data
    for j=1 : size(e,1) % Number of feedback signals
        e(j,2) = e(j,1);
        e(j,1) = ek(j);
    end
    
    set_data_control(e,u);
    
    % Control signal
    uk = [0 0]';
    
else
    
    % Previous signals: e = [e(k-1) e(k-2)] , u = [u1(k-1) u1(k-2) ; u2(k-1) u2(k-2)]
    [e, u] = get_data_control();
    
    % Current error
    ek = setpoint - yk;
    
    % Sample time
    Ts = get_sample_time();
    
    % Controller constants
    Kp = 0.004;
    Ti = 0.1;
    Td = 0.025;
    
    % Digital PID controllers (Approximate by Tustin)
    a0 = Kp*(1 + Ts/(2*Ti) + 2*Td/Ts);
    a1 = Kp*(Ts/Ti - 4*Td/Ts);
    a2 = Kp*(-1 + Ts/(2*Ti) + 2*Td/Ts);
    
    % PID to tank 1
    u1 = u(1,2) + a0*ek + a1*e(1) + a2*e(2);
    u1 = mysaturation(u1, 0, Qp(1));
    
    % PID to tank 2
    u2 = u(2,2) + a0*ek + a1*e(1) + a2*e(2);
    u2 = mysaturation(u2, 0, Qp(2));
    
    % Control signal
    uk = [u1 u2]';
    
    % Updating data
    for j=1 : size(e,1) % Number of feedback signals
        e(j,2) = e(j,1);
        e(j,1) = ek(j);
    end
    
    for j=1 : size(u,1) % Number of control signals
        u(j,2) = u(j,1);
        u(j,1) = uk(j);
    end
    
    set_data_control(e,u);
    
end
