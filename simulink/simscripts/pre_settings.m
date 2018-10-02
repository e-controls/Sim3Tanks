%restoredefaultpath();
addpath(genpath('../../three_tank_system'));
addpath(genpath('../../control_system'));
addpath(genpath('../../fdi_system'));
addpath(genpath('../../simulink'));
addpath(genpath('../../guide'));

filename  = 'Sim3Tanks_simulink';
blockname = 'Three-Tank System';

% ***DO NOT EDIT [Begin]***
fullname  = strcat(filename,'/',blockname);
bdroot(filename);
% ***DO NOT EDIT [End]***
