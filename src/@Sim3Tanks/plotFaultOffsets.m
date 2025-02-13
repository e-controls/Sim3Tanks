function plotFaultOffsets(varargin)
% plotFaultOffsets is a Sim3Tanks method. This method plots the behavior
% of the fault offsets over time.
%
% Example:
%   tts.plotFaultOffsets();
%
% To plot a specific fault offset, use one of the following options as
% an input argument: 'f11', 'f12', 'f13', ..., 'f21', 'f22', or 'f23'.
%
% If there is no input argument, all fault offsets will be plotted on the
% same figure.

% https://github.com/e-controls/Sim3Tanks

%==========================================================================

if(nargin()>2)
    error(getMessage('ERR002'));
else
    objSim3Tanks = varargin{1};
end

time = objSim3Tanks.getInternalSimulationTime();
F = objSim3Tanks.getInternalFaultOffsets(time);

if(isempty(F))
    warning(getMessage('WARN008'));
    return;
else
    time = F.Time; % casting to seconds
end

FAULT_IDs = Sim3Tanks.LIST_OF_FAULTS(11:end);

tagSim3Tanks = 'Sim3Tanks';

%==========================================================================

if(nargin()==1)

    plotAllFaults(tagSim3Tanks,FAULT_IDs,F,time);

elseif(nargin()==2)

    option = find(strcmpi(varargin{2},FAULT_IDs));

    if(~isempty(option))
        ID = FAULT_IDs{option};
    else
        error(getMessage('ERR003'));
    end

    plotOneFault(tagSim3Tanks,ID,F,time);

end

end

%==========================================================================

function plotAllFaults(tagSim3Tanks,FAULT_IDs,F,time)

FIG_ID = [tagSim3Tanks,'_figOffset_fault_all'];

try
    delete(findobj('Tag',FIG_ID));
catch
end

N0 = numel(time);
N1 = round(N0/4);
MarkIdx = 01:N1:N0;

figure('Tag',FIG_ID,...
    'Numbertitle','off',...
    'Name',[tagSim3Tanks,': fault offsets']);

for i = 1 : numel(FAULT_IDs)

    subplot(3,5,i); hold on; box on;

    p = plot(time,F.(FAULT_IDs{i}),'r-o','MarkerIndices',MarkIdx);
    legend(p,FAULT_IDs{i},'Location','Best');

    xlim([time(1) time(N0)]);

end

end

%==========================================================================

function plotOneFault(tagSim3Tanks,FAULT_ID,F,time)

FIG_ID = [tagSim3Tanks,'_figOffset_fault_',FAULT_ID];

try
    delete(findobj('Tag',FIG_ID));
catch
end

N0 = numel(time);
N1 = round(N0/4);
MarkIdx = 1:N1:N0;

figure('Tag',FIG_ID,...
    'Numbertitle','off',...
    'Name',[tagSim3Tanks,': ',FAULT_ID,' offset']); hold on; box on;

p = plot(time,F.(FAULT_ID),'r-o','MarkerIndices',MarkIdx);
legend(p,FAULT_ID,'Location','Best');

xlabel('Time');
ylabel('Offset');

xlim([time(1) time(N0)]);

end