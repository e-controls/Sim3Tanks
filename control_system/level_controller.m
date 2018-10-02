function [out1,out2,out3] = level_controller(setpoint, Qp, y)

yk = [y(1) y(2)]'; % Level [h1 h2]' measured (cm)

u = level_pid_controller(setpoint, Qp, yk); % Digital PID

%% to outputs
out1 = u;
out2 = 0;
out3 = 0;

end