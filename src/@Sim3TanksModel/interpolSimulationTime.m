function [varargout] = interpolSimulationTime(varargin)
% interpolSimulationTime is a Sim3Tanks method. This method receives a
% two-position vector containing the start and stop time of a simulation
% (in ascending order) and returns an interpolated time vector of size
% consistent with the number of simulations of a Sim3Tanks object.

% https://github.com/e-controls/Sim3Tanks

%==========================================================================

if(nargin()<2)
    error(getMessage('ERR001'));
elseif(nargin()>2)
    error(getMessage('ERR002'));
else
    objSim3Tanks = varargin{1};
    simTime = varargin{2};
end

if(numel(simTime)~=2)
    error(getMessage('ERR023'));
end

%==========================================================================

x = objSim3Tanks.getInternalStateVariables();

if(isempty(x))
    time = 0;
else
    time = linspace(simTime(1),simTime(2),size(x,1));
end

varargout{1} = time';

end