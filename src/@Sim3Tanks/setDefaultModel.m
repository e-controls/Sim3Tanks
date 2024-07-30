function setDefaultModel(varargin)
% setDefaultModel is a Sim3Tanks method. This method does not have an input
% argument and configures a Sim3Tanks object to the default model.
%
% Example:
%   tts.setDefaultModel();

% https://github.com/e-controls/Sim3Tanks

%==========================================================================

if(nargin()>1)
    error(getMessage('ERR002'));
else
    objSim3Tanks = varargin{1};
end

%==========================================================================

LIST_OF_FIELDS = Sim3Tanks.LIST_OF_FIELDS;
LIST_OF_VALVES = Sim3Tanks.LIST_OF_VALVES;
LIST_OF_FAULTS = Sim3Tanks.LIST_OF_FAULTS;
LIST_OF_PARAM  = Sim3Tanks.LIST_OF_PARAM;
Nx = numel(Sim3Tanks.LIST_OF_STATES);
Nq = numel(Sim3Tanks.LIST_OF_FLOWS);

%==========================================================================

D = defaultPhysicalParam();
for i = 1 : numel(LIST_OF_PARAM)
    objSim3Tanks.Model.(LIST_OF_FIELDS{1}).(LIST_OF_PARAM{i}) = D.(LIST_OF_PARAM{i});
end

D = defaultOperationMode();
for i = 1 : numel(LIST_OF_VALVES)
    objSim3Tanks.Model.(LIST_OF_FIELDS{2}).(LIST_OF_VALVES{i}).OperationMode = D.(LIST_OF_VALVES{i});
end

K = checkOperationMode(objSim3Tanks);
for i = 1 : numel(LIST_OF_VALVES)
    objSim3Tanks.Model.(LIST_OF_FIELDS{2}).(LIST_OF_VALVES{i}).EnableControl = false;
    objSim3Tanks.Model.(LIST_OF_FIELDS{2}).(LIST_OF_VALVES{i}).OpeningRate = K(i);
end
objSim3Tanks.Model.(LIST_OF_FIELDS{2}).(LIST_OF_VALVES{1}).EnableControl = true;
objSim3Tanks.Model.(LIST_OF_FIELDS{2}).(LIST_OF_VALVES{2}).EnableControl = true;

for i = 1 : numel(LIST_OF_FAULTS)
    objSim3Tanks.Model.(LIST_OF_FIELDS{3}).(LIST_OF_FAULTS{i}).EnableSignal = false;
    objSim3Tanks.Model.(LIST_OF_FIELDS{3}).(LIST_OF_FAULTS{i}).Magnitude = 0;
end

for i = 11 : numel(LIST_OF_FAULTS)
    objSim3Tanks.Model.(LIST_OF_FIELDS{3}).(LIST_OF_FAULTS{i}).Offset = 0;
end

objSim3Tanks.Model.(LIST_OF_FIELDS{4}).EnableSignal = false;
objSim3Tanks.Model.(LIST_OF_FIELDS{4}).Magnitude = zeros(1,Nx);

objSim3Tanks.Model.(LIST_OF_FIELDS{5}).EnableSignal = false;
objSim3Tanks.Model.(LIST_OF_FIELDS{5}).Magnitude = zeros(1,Nx+Nq);

objSim3Tanks.Model.(LIST_OF_FIELDS{6}) = [40 25 20]; % [h1 h2 h3]

objSim3Tanks.clearVariables();

end