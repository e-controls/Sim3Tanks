function [varargout] = createSim3Tanks(varargin)
% createSim3Tanks is a Sim3Tanks function. This function returns the
% necessary basic structure of Sim3Tanks object.

% Written by Arllem Farias, December/2023.
% Last update January/2024 by Arllem Farias.

%==========================================================================

if(nargin()~=0)
    error(errorMessage(02));
end

%==========================================================================

objSim3Tanks.Model = Sim3TanksClass();
objSim3Tanks.Model.prepareModel();

objSim3Tanks.simulateModel = @(Qp1,Qp2,Qp3,Ts)feval(@(obj,Qp1,Qp2,Qp3,Ts)...
    simulateModel(obj,Qp1,Qp2,Qp3,Ts),objSim3Tanks.Model,Qp1,Qp2,Qp3,Ts);

objSim3Tanks.resetModel = @()feval(@(obj)...
    resetModel(obj),objSim3Tanks.Model);

objSim3Tanks.resetVariables = @()feval(@(obj)...
    resetVariables(obj),objSim3Tanks.Model);

objSim3Tanks.setDefaultModel = @()feval(@(obj)...
    setDefaultModel(obj),objSim3Tanks.Model);

objSim3Tanks.getStates = @()feval(@(obj)...
    getStates(obj),objSim3Tanks.Model);

objSim3Tanks.getFlows = @()feval(@(obj)...
    getFlows(obj),objSim3Tanks.Model);

objSim3Tanks.getMeasurements = @()feval(@(obj)...
    getMeasurements(obj),objSim3Tanks.Model);

objSim3Tanks.getValves = @()feval(@(obj)...
    getValves(obj),objSim3Tanks.Model);

objSim3Tanks.getFaults = @()feval(@(obj)...
    getFaults(obj),objSim3Tanks.Model);

% The idea is to create a log file when this value is true.
% objSim3Tanks.CreateLogFile = false;

varargout{1} = objSim3Tanks;

end
