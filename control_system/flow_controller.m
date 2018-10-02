function [out1,out2,out3] = flow_controller(setpoint, Qp, y)

yk = y(12); % Flow Q3 measured (cm^3/s)

u = flow_pid_controller(setpoint, Qp, yk); % Digital PID

%% to outputs
out1 = u;
out2 = 0;
out3 = 0;

end