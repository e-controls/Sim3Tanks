function [varargout] = checkPhysicalParam(varargin)
% checkPhysicalParam is a Sim3Tanks function. This function checks if the
% values in the PhysicalParam field are consistent (i.e., if they are real
% and finite) and returns an array with the respective values.

% Written by Arllem Farias, January/2024.
% Last update February/2024 by Arllem Farias.

%==========================================================================

if(nargin()<1)
    error(errorMessage(01));
elseif(nargin()>1)
    error(errorMessage(02));
end

if(isa(varargin{1},'Sim3TanksClass'))
    objSim3Tanks = varargin{1};
    ClassPropers = properties(objSim3Tanks);
else
    error(errorMessage(07));
end

%==========================================================================
global SIM3TANKS_LISTS; %#ok<*GVMIS>

if(isempty(SIM3TANKS_LISTS))
    error(errorMessage(04));
else
    LIST_OF_PARAM = SIM3TANKS_LISTS.LIST_OF_PARAM;
end
%==========================================================================

param = zeros(size(LIST_OF_PARAM));

for i = 1 : numel(LIST_OF_PARAM)
    value = objSim3Tanks.(ClassPropers{1}).(LIST_OF_PARAM{i});
    if(isempty(value))
        error(errorMessage(09));
    elseif(isnumeric(value) && isfinite(value))
        param(i) = value;
    else
        error(errorMessage(09));
    end
end

if(~(param(1)>0))
    % TankRadius
    error(errorMessage(13));
    
elseif(~(param(2)>0))
    % TankHeight
    error(errorMessage(14));
    
elseif(~(param(3)>0 && param(3)<param(1)))
    % PipeRadius
    error(errorMessage(15));
    
elseif(~(param(4)>0 && param(4)<param(2)))
    % TransPipeHeight
    error(errorMessage(16));
    
elseif(~(param(5)>0))
    % CorrectionTerm
    error(errorMessage(17));
    
elseif(~(param(6)>0))
    % GravityConstant
    error(errorMessage(18));
    
elseif(~(param(7)>=0))
    % PumpMinFlow
    error(errorMessage(19));
    
elseif(~(param(8)>=param(7)))
    % PumpMaxFlow
    error(errorMessage(20));
    
else
    varargout{1} = param;
end

end