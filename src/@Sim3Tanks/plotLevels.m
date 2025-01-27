function plotLevels(varargin)
% plotLevels is a Sim3Tanks method. This method plots the behavior of the
% levels over time.
%
% Example:
%   tts.plotLevels();
%
% To plot a specific level, use one of the following options as an input
% argument:
%   'h1' : to plot the level of Tank 1
%   'h2' : to plot the level of Tank 2
%   'h3' : to plot the level of Tank 3
%
% If there is no input argument, all levels will be plotted on the same
% figure.

% https://github.com/e-controls/Sim3Tanks

%==========================================================================

if(nargin()>2)
    error(getMessage('ERR002'));
else
    objSim3Tanks = varargin{1};
end

time = objSim3Tanks.getInternalSimulationTime();
X = objSim3Tanks.getInternalStateVariables(time);

if(isempty(X))
    warning(getMessage('WARN008'));
    return;
else % If I have a non-empty X, then I also have a non-empty Y.
    Y = objSim3Tanks.getInternalSensorMeasurements(time);
    time = Y.Time; % casting to seconds
end

STATE_IDs = Sim3Tanks.LIST_OF_STATES;

tagSim3Tanks = 'Sim3Tanks';

%==========================================================================

if(nargin()==1)

    plotAllLevels(tagSim3Tanks,STATE_IDs,X,Y,time);

elseif(nargin()==2)

    option = find(strcmpi(varargin{2},STATE_IDs));

    if(~isempty(option))
        ID = STATE_IDs{option};
    else
        error(getMessage('ERR003'));
    end

    plotOneLevel(tagSim3Tanks,ID,X,Y,time);

end

end

%==========================================================================

function plotAllLevels(tagSim3Tanks,STATE_IDs,X,Y,time)

FIG_ID = [tagSim3Tanks,'_fig_level_all'];

try
    delete(findobj('Tag',FIG_ID));
catch
end

N0 = numel(time);
N1 = round(N0/4);
N2 = round(N1/2);
N3 = round((N1+N2)/2);

MarkIdx1 = 01:N1:N0;
MarkIdx2 = N2:N1:N0;
MarkIdx3 = N3:N1:N0;

figure('Tag',FIG_ID,...
    'Numbertitle','off',...
    'Name',[tagSim3Tanks,': levels']);

% Real value
subplot(2,1,1); hold on; box on;
p1 = plot(time,X.(STATE_IDs{1}),'-o','MarkerIndices',MarkIdx1);
p2 = plot(time,X.(STATE_IDs{2}),'-s','MarkerIndices',MarkIdx2);
p3 = plot(time,X.(STATE_IDs{3}),'-^','MarkerIndices',MarkIdx3);
legend([p1 p2 p3],STATE_IDs{1},STATE_IDs{2},STATE_IDs{3},...
    'Location','Northeast');
xlabel('Time');
ylabel('Real values');
xlim([time(1) time(N0)]);

% Measured value
subplot(2,1,2); hold on; box on;
p1 = plot(time,Y.(STATE_IDs{1}),'-o','MarkerIndices',MarkIdx1);
p2 = plot(time,Y.(STATE_IDs{2}),'-s','MarkerIndices',MarkIdx2);
p3 = plot(time,Y.(STATE_IDs{3}),'-^','MarkerIndices',MarkIdx3);
legend([p1 p2 p3],STATE_IDs{1},STATE_IDs{2},STATE_IDs{3},...
    'Location','Northeast');
xlabel('Time');
ylabel('Measured values');
xlim([time(1) time(N0)]);

end

%==========================================================================

function plotOneLevel(tagSim3Tanks,STATE_ID,X,Y,time)

FIG_ID = [tagSim3Tanks,'_fig_level_',STATE_ID];

try
    delete(findobj('Tag',FIG_ID));
catch
end

realValue = X.(STATE_ID);
measuredValue = Y.(STATE_ID);

N0 = numel(time);
N1 = round(N0/4);
MarkIdx = 1:N1:N0;

figure('Tag',FIG_ID,...
    'Numbertitle','off',...
    'Name',[tagSim3Tanks,': ',STATE_ID]);

% Real value
subplot(2,1,1); hold on; box on;
plot(time,realValue,'b-o','MarkerIndices',MarkIdx);
legend(STATE_ID,'Location','Northeast');
xlabel('Time');
ylabel('Real value');
xlim([time(1) time(N0)]);

% Measured value
subplot(2,1,2); hold on; box on;
plot(time,measuredValue,'r-o','MarkerIndices',MarkIdx);
legend(STATE_ID,'Location','Northeast');
xlabel('Time');
ylabel('Measured value');
xlim([time(1) time(N0)]);

end