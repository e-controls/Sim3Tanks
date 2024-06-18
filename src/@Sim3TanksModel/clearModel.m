function clearModel(varargin)
% clearModel is a Sim3Tanks method. This method restores all settings and
% clears all variables of a Sim3Tanks object.

% Written by Arllem Farias, February/2024.
% Last update June/2024 by Arllem Farias.

%==========================================================================

if(nargin()>1)
    error(getMessage('ERR001'));
else
    objSim3Tanks = varargin{1};
end

%==========================================================================

objSim3Tanks.prepareModel();

objSim3Tanks.clearVariables();

end
