function [varargout] = resetModel(varargin)
% resetModel is a Sim3Tanks function. This function restores all variables
% and settings of a Sim3TanksClass object.

% Written by Arllem Farias, February/2024.
% Last update February/2024 by Arllem Farias.

%==========================================================================

if(nargin()<1)
    error(errorMessage(01));
elseif(nargin()>1)
    error(errorMessage(02));
end

if(isa(varargin{1},'Sim3TanksClass'))
    objSim3Tanks = varargin{1};
else
    error(errorMessage(07));
end

%==========================================================================

objSim3Tanks.prepareModel();

varargout{1} = resetVariables(objSim3Tanks);

end