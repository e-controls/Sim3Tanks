function [varargout] = checkEnabledNoises(varargin)
% checkEnabledNoises is a Sim3Tanks function. This function checks if the
% process and measurement noises have their EnableSignal field set to true
% in a Sim3TanksClass object and returns an array with the Magnitude field
% values. If the EnableSignal field is set to false, then the returned
% value will be an array of 0s with appropriate dimensions.

% https://github.com/e-controls/Sim3Tanks

%==========================================================================

if(nargin()<1)
    error(getMessage('ERR001'));
elseif(nargin()>1)
    error(getMessage('ERR002'));
end

if(isa(varargin{1},'Sim3TanksModel'))
    objSim3Tanks = varargin{1};
else
    error(getMessage('ERR004'));
end

%==========================================================================

LIST_OF_FIELDS = Sim3TanksModel.LIST_OF_FIELDS;
Nx = numel(Sim3TanksModel.LIST_OF_STATES);
Nq = numel(Sim3TanksModel.LIST_OF_FLOWS);

%==========================================================================

pNoise = objSim3Tanks.Model.(LIST_OF_FIELDS{4});

if(islogical(pNoise.EnableSignal) && pNoise.EnableSignal)

    if(isempty(pNoise.Magnitude))
        warning(getMessage('WARN005'));
        pNoiseMag = zeros(1,Nx);
    elseif(numel(pNoise.Magnitude)~=Nx)
        error(getMessage('ERR006'));
    else
        pNoiseMag = pNoise.Magnitude;
    end

elseif(islogical(pNoise.EnableSignal))
    pNoiseMag = zeros(1,Nx);
else
    error(getMessage('ERR011'));
end

%==========================================================================

mNoise = objSim3Tanks.Model.(LIST_OF_FIELDS{5});

if(islogical(mNoise.EnableSignal) && mNoise.EnableSignal)

    if(isempty(mNoise.Magnitude))
        warning(getMessage('WARN006'));
        mNoiseMag = zeros(1,Nx+Nq);
    elseif(numel(mNoise.Magnitude)~=Nx+Nq)
        error(getMessage('ERR006'));
    else
        mNoiseMag = mNoise.Magnitude;
    end

elseif(islogical(mNoise.EnableSignal))
    mNoiseMag = zeros(1,Nx+Nq);
else
    error(getMessage('ERR011'));
end

varargout{1} = pNoiseMag;
varargout{2} = mNoiseMag;

end