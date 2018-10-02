clc; clear all; close all; rng('default');

%% Paths
%restoredefaultpath();
addpath(genpath('three_tank_system'));
addpath(genpath('control_system'));
addpath(genpath('fdi_system'));
addpath(genpath('guide'));
%% Run GUI

run('gui_three_tank_system_simulator');

%% Plot FDI system responses - Run the following lines after simulation done.
% p = fout1;       % Probability vector of faults (15x1)
% g = fout2;       % GLR decision functions (8x1)
% residue = fout3; % Residual signals (8x1)
% yhat = fout4;    % Estimated outputs by UKF (8x1)
%
% plot_residues(measurements,yhat,residue);
% plot_decision_funcs(g);
% plot_probabilities(p);
