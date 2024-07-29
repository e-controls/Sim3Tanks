function [varargout] = interpolateTime(varargin)
% interpolateTime is a Sim3Tanks method. This method receives the original
% simulation time vector and returns a new interpolated time vector of size
% consistent with the number of simulations of a Sim3Tanks object.

% https://github.com/e-controls/Sim3Tanks

%==========================================================================

if(nargin()<2)
    error(getMessage('ERR001'));
elseif(nargin()>2)
    error(getMessage('ERR002'));
elseif(~isnumeric(varargin{2}))
    error(getMessage('ERR023'));
else
    objSim3Tanks = varargin{1};
    timeVector = varargin{2};
end

if(~isrow(timeVector))
    if(~iscolumn(timeVector))
        error(getMessage('ERR023'));
    end
end

%==========================================================================

x = objSim3Tanks.getInternalStateVariables();

if(isempty(x))
    time = 0;
else
    time = linspace(timeVector(1),timeVector(end),size(x,1));
end

varargout{1} = time';

end