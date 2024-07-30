function clearModel(varargin)
% clearModel is a Sim3Tanks method. This method does not have an input
% argument. It clears all variables and restores a Sim3Tanks object.
%
% Example:
%   tts.clearModel();

% https://github.com/e-controls/Sim3Tanks

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
