function [varargout] = checkPhysicalParam(varargin)
% checkPhysicalParam is a Sim3Tanks function. This function checks if the
% values in the PhysicalParam field are consistent (i.e., if they are real
% and finite) and returns a struct with the respective values. A second
% argument with the field names is also returned.
%
% Example:
%   [Param,ID] = checkPhysicalParam(objSim3Tanks);

% https://github.com/e-controls/Sim3Tanks

%==========================================================================

if(nargin()<1)
    error(getMessage('ERR001'));
elseif(nargin()>1)
    error(getMessage('ERR002'));
end

if(isa(varargin{1},'Sim3Tanks'))
    objSim3Tanks = varargin{1};
else
    error(getMessage('ERR004'));
end

%==========================================================================

LIST_OF_FIELDS = Sim3Tanks.LIST_OF_FIELDS;
LIST_OF_PARAM = Sim3Tanks.LIST_OF_PARAM;

%==========================================================================

Param = struct();

for i = 1 : numel(LIST_OF_PARAM)
    value = objSim3Tanks.Model.(LIST_OF_FIELDS{1}).(LIST_OF_PARAM{i});
    if(isempty(value))
        error(getMessage('ERR008'));
    elseif(isnumeric(value) && isfinite(value))
        Param.(LIST_OF_PARAM{i}) = value;
    else
        error(getMessage('ERR008'));
    end
end

if(~(Param.(LIST_OF_PARAM{1})>0))
    % TankRadius
    error(getMessage('ERR012'));

elseif(~(Param.(LIST_OF_PARAM{2})>0))
    % TankHeight
    error(getMessage('ERR013'));

elseif(~(Param.(LIST_OF_PARAM{3})>0 && Param.(LIST_OF_PARAM{3})<Param.(LIST_OF_PARAM{1})))
    % PipeRadius
    error(getMessage('ERR014'));

elseif(~(Param.(LIST_OF_PARAM{4})>0 && Param.(LIST_OF_PARAM{4})<Param.(LIST_OF_PARAM{2})))
    % TransPipeHeight
    error(getMessage('ERR015'));

elseif(~(Param.(LIST_OF_PARAM{5})>0))
    % CorrectionTerm
    error(getMessage('ERR016'));

elseif(~(Param.(LIST_OF_PARAM{6})>0))
    % GravityConstant
    error(getMessage('ERR017'));

elseif(~(Param.(LIST_OF_PARAM{7})>=0))
    % PumpMinFlow
    error(getMessage('ERR018'));

elseif(~(Param.(LIST_OF_PARAM{8})>=Param.(LIST_OF_PARAM{7})))
    % PumpMaxFlow
    error(getMessage('ERR019'));

else
    varargout{1} = Param;
    varargout{2} = fieldnames(Param);
end

end