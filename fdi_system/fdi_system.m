function [out1,out2,out3,out4,out5] = fdi_system(u,y)
%% FDI algorithm

% Selection of the FDI system inputs
uk = [u(1) u(2)]'; % Control signals: uk = [u1 u2]';
yk = [y(1) y(2) y(3) y(4) y(5) y(8) y(9) y(12)]'; % Output signals from Sim3Tanks: yk = [h1 h2 h3 u1 u2 Q13 Q23 Q3]';

% UKF-Based residual generation
xhat0 = [0 0 0]'; % Initial conditions of UKF: xhat = [h1, h2, h3]' (cm)

[residue,yhat] = ukf(xhat0,uk,yk); % Unscented Kalman Filter

% GLR-Based residual evaluation
meanr = [0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0]'; % Mean of the residues in a fault-free scenario
stdr  = [0.3  0.3  0.3  2.5  2.5  1.5  1.5  1.5]'; % Standard deviation of the residues in a fault-free scenario
thr   = [20   20   20   40   40   20   20   20 ]'; % Thresholds chosen for a fault-free scenario

datawindow = 20; % Data window length

g = glr_decision_func(residue,meanr,stdr,datawindow); % Decision function response of GLR method
g = mysaturation(g,zeros(size(thr)),1.5*thr); % Saturation of g(k)

% Threshold-based fault detection
z = glr_check_threshold(g,thr); % Threshold crossing vector => if g(i)>thr(i), then z(i)=1, otherwise, z(i)=0 (i=1,2,3,...,8)

% BN-based fault isolation
p = compute_fault_probabilities(z);

%% To outputs
out1 = p;       % Vector of fault Probabilities (15x1)
out2 = g;       % GLR decision functions (8x1)
out3 = residue; % Residual signals (8x1)
out4 = yhat;    % Estimated outputs by UKF (8x1)
out5 = z;       % Threshold crossing vector (8x1)

end