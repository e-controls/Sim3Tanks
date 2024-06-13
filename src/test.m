clc; clear all; close all;

m1 = Sim3TanksModel;
m1.pushInternalStateVariables(rand(1,3));
m1.pushInternalStateVariables(rand(1,3));
m1.pushInternalStateVariables(rand(1,3));

m1.pushInternalFaultSignals(rand(1,23));
m1.pushInternalFaultSignals(rand(1,23));

m1.pushInternalFlowVariables(rand(1,10));
m1.pushInternalFlowVariables(rand(1,10));

m1.pushInternalSensorMeasurements(rand(1,13));
m1.pushInternalSensorMeasurements(rand(1,13));

m1.pushInternalValveSignals(rand(1,10));
m1.pushInternalValveSignals(rand(1,10));

%m1.getInternalStateVariables
m1.getStateVariables
% m1.getFaultSignals
% m1.getFlowVariables
% m1.getSensorMeasurements
% m1.getValveSignals

m2 = Sim3TanksModel();
m2.pushInternalStateVariables(rand(1,3));

m2.pushInternalFaultSignals(rand(1,23));

m2.pushInternalFlowVariables(rand(1,10));

m2.pushInternalSensorMeasurements(rand(1,13));

m2.pushInternalValveSignals(rand(1,10));

%m2.getInternalStateVariables
m2.getStateVariables
% m2.getFaultSignals
% m2.getFlowVariables
% m2.getSensorMeasurements
% m2.getValveSignals

m2.Model.PhysicalParam.CorrectionTerm = 100;
m2.Model.FaultSettings.f1.EnableSignal = true;
m2.Model.FaultSettings.f1.Magnitude = 0.5;


m1.clearModel;
m1.setDefaultModel;


% m1.Model.FaultSettings.f1.EnableSignal = true;
% m1.Model.FaultSettings.f1.Magnitude = [];
% [f,fID] = checkEnabledFaults(m1)

% m1.Model.ValveSettings.Kp1.EnableControl = true;
% m1.Model.ValveSettings.Kp1.OpeningRate =1.1;
% [v,vID] = checkEnabledValves(m1)



