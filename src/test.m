clc; clear all; close all;

m1 = Sim3TanksModel;
m1.pushInternalStateVariables(rand(1,3));
m1.pushInternalStateVariables(rand(1,3));
m1.pushInternalStateVariables(rand(1,3));

%m1.getInternalStateVariables
m1.getStateVariables

m2 = Sim3TanksModel();
m2.pushInternalStateVariables(rand(1,3));

%m2.getInternalStateVariables
m2.getStateVariables

