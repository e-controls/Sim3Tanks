function plotValves(varargin)
% plotValves is a Sim3Tanks method. This method plots the behavior of the
% valves over time.
%
% Example:
%   tts.plotValves();
%
% To plot a specific valve behavior, use one of the following options as
% an input argument: 'Kp1', 'Kp2', 'Kp3', 'Ka', 'Kb', 'K13', 'K23', 'K1',
% 'K2', or 'K3'.
%
% If there is no input argument, all valves will be plotted on the same
% figure.

% https://github.com/e-controls/Sim3Tanks

%==========================================================================

if(nargin()>2)
    error(getMessage('ERR002'));
else
    objSim3Tanks = varargin{1};
end

time = objSim3Tanks.getInternalSimulationTime();
K = objSim3Tanks.getInternalValveSignals(time);

if(isempty(K))
    warning(getMessage('WARN008'));
    return;
else
    time = K.Time; % casting to seconds
end

[opMode,VALVE_IDs] = checkOperationMode(objSim3Tanks);

tagSim3Tanks = 'Sim3Tanks';

%==========================================================================

if(nargin()==1)

    plotAllValves(tagSim3Tanks,VALVE_IDs,opMode,K,time);

elseif(nargin()==2)

    option = find(strcmpi(varargin{2},VALVE_IDs));

    if(~isempty(option))
        ID = VALVE_IDs{option};
        opMode = opMode(option);
    else
        error(getMessage('ERR003'));
    end

    plotOneValve(tagSim3Tanks,ID,K,opMode,time);

end

end

%==========================================================================

function plotAllValves(tagSim3Tanks,VALVE_IDs,opMode,K,time)

FIG_ID = [tagSim3Tanks,'_fig_valve_all'];

try
    delete(findobj('Tag',FIG_ID));
catch
end

normal = getRGBtriplet('normal');
fault  = getRGBtriplet('fault');

N0 = numel(time);
N1 = round(N0/4);
MarkIdx = 01:N1:N0;

figure('Tag',FIG_ID,...
    'Numbertitle','off',...
    'Name',[tagSim3Tanks,': valves']);

for i = 1 : numel(opMode)

    subplot(4,3,i); hold on; box on;

    flag1 = 'Closed';
    flag2 = 'Open';
    if(opMode(i) ~= 0)
        flag1 = 'Open';
        flag2 = 'Closed';
    end

    dK = repmat(opMode(i),size(time));

    plot(time,dK,'--','Color',normal);
    plot(time,1-dK,'--','Color',fault);

    p = plot(time,K.(VALVE_IDs{i}),'k-o','MarkerIndices',MarkIdx);
    legend(p,VALVE_IDs{i},'Location','Best');

    xlim([time(1) time(N0)]);
    ylim([-0.1 1.1]);

    text(time(1),opMode(i),...
        flag1,...
        'FontSize',8,...
        'HorizontalAlignment','Left',...
        'BackgroundColor',normal);
    text(time(1),1-opMode(i),...
        flag2,...
        'FontSize',8,...
        'HorizontalAlignment','Left',...
        'BackgroundColor',fault);

end

end

%==========================================================================

function plotOneValve(tagSim3Tanks,VALVE_ID,K,opMode,time)

FIG_ID = [tagSim3Tanks,'_fig_valve_',VALVE_ID];

try
    delete(findobj('Tag',FIG_ID));
catch
end

normal = getRGBtriplet('normal');
fault  = getRGBtriplet('fault');

N0 = numel(time);
N1 = round(N0/4);
MarkIdx = 1:N1:N0;

figure('Tag',FIG_ID,...
    'Numbertitle','off',...
    'Name',[tagSim3Tanks,': ',VALVE_ID]); hold on; box on;

flag1 = 'Closed';
flag2 = 'Open';
if(opMode ~= 0)
    flag1 = 'Open';
    flag2 = 'Closed';
end

dK = repmat(opMode,size(time));

plot(time,dK,'--','Color',normal);
plot(time,1-dK,'--','Color',fault);

p = plot(time,K.(VALVE_ID),'k-o','MarkerIndices',MarkIdx);
legend(p,VALVE_ID,'Location','Best');

xlabel('Time');
ylabel('Opening Rate');

xlim([time(1) time(N0)]);
ylim([-0.1 1.1]);

text(time(1),opMode,flag1,...
    'FontSize',8,...
    'HorizontalAlignment','Left',...
    'BackgroundColor',normal);
text(time(1),1-opMode,flag2,...
    'FontSize',8,...
    'HorizontalAlignment','Left',...
    'BackgroundColor',fault);

end