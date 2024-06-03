function [varargout] = checkPhysicalParam(varargin)
% checkPhysicalParam is a Sim3Tanks function. This function checks if the
% values in the PhysicalParam field are consistent (i.e., if they are real
% and finite) and returns a struct with the respective values. A second
% argument with the field names is also returned.
%
% Example:
%   [Param,ID] = checkPhysicalParam(objSim3Tanks);

% Written by Arllem Farias, January/2024.
% Last update Jun/2024 by Arllem Farias.

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

Param = struct();

for i = 1 : numel(LIST_OF_PARAM)
    value = objSim3Tanks.(ClassPropers{1}).(LIST_OF_PARAM{i});
    if(isempty(value))
        error(errorMessage(09));
    elseif(isnumeric(value) && isfinite(value))
        Param.(LIST_OF_PARAM{i}) = value;
    else
        error(errorMessage(09));
    end
end

if(~(Param.(LIST_OF_PARAM{1})>0))
    % TankRadius
    error(errorMessage(13));

elseif(~(Param.(LIST_OF_PARAM{2})>0))
    % TankHeight
    error(errorMessage(14));

elseif(~(Param.(LIST_OF_PARAM{3})>0 && Param.(LIST_OF_PARAM{3})<Param.(LIST_OF_PARAM{1})))
    % PipeRadius
    error(errorMessage(15));

elseif(~(Param.(LIST_OF_PARAM{4})>0 && Param.(LIST_OF_PARAM{4})<Param.(LIST_OF_PARAM{2})))
    % TransPipeHeight
    error(errorMessage(16));

elseif(~(Param.(LIST_OF_PARAM{5})>0))
    % CorrectionTerm
    error(errorMessage(17));

elseif(~(Param.(LIST_OF_PARAM{6})>0))
    % GravityConstant
    error(errorMessage(18));

elseif(~(Param.(LIST_OF_PARAM{7})>=0))
    % PumpMinFlow
    error(errorMessage(19));

elseif(~(Param.(LIST_OF_PARAM{8})>=Param.(LIST_OF_PARAM{7})))
    % PumpMaxFlow
    error(errorMessage(20));

else
    varargout{1} = Param;
    varargout{2} = fieldnames(Param);
end

end