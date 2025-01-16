function plotFlows(varargin)
% plotFlows is a Sim3Tanks method. This method plots the behavior of a
% flow over time.
%
% Example:
%   tts.plotFlows(option);
%
% To plot a specific flow, use one of the following options as an input
% argument:
%   'Q1in' : to plot the inflow of Tank 1
%   'Q2in' : to plot the inflow of Tank 2
%   'Q3in' : to plot the inflow of Tank 3
%   'Qa'   : to plot the transmission flow from Tank 1 to 3
%   'Qb'   : to plot the transmission flow from Tank 2 to 3
%   'Q13'  : to plot the connection flow from Tank 1 to 3
%   'Q23'  : to plot the connection flow from Tank 2 to 3
%   'Q1'   : to plot the outflow of Tank 1
%   'Q2'   : to plot the outflow of Tank 2
%   'Q3'   : to plot the outflow of Tank 3
%
% If there is no input argument, all flows will be plotted on the same
% figure.

% https://github.com/e-controls/Sim3Tanks

%==========================================================================

if(nargin()>2)
    error(getMessage('ERR002'));
end

objSim3Tanks = varargin{1};

Q = objSim3Tanks.getFlowVariables();

if(isempty(Q))
    warning(getMessage('WARN008'));
    return;
else % If I have a non-empty Q, then I also have a non-empty Y.
    Y = objSim3Tanks.getSensorMeasurements();
    time = Y.Time;
end

FLOW_IDs = Sim3Tanks.LIST_OF_FLOWS;

tagSim3Tanks = 'Sim3Tanks';

%==========================================================================

if(nargin()==1)

    plotAllFlows(tagSim3Tanks,FLOW_IDs,Q,Y,time);

elseif(nargin()==2)

    switch lower(varargin{2})
        case 'q1in'
            ID = FLOW_IDs{1};
        case 'q2in'
            ID = FLOW_IDs{2};
        case 'q3in'
            ID = FLOW_IDs{3};
        case 'qa'
            ID = FLOW_IDs{4};
        case 'qb'
            ID = FLOW_IDs{5};
        case 'q13'
            ID = FLOW_IDs{6};
        case 'q23'
            ID = FLOW_IDs{7};
        case 'q1'
            ID = FLOW_IDs{8};
        case 'q2'
            ID = FLOW_IDs{9};
        case 'q3'
            ID = FLOW_IDs{10};
        otherwise
            error(getMessage('ERR003'));
    end

    plotOneFlow(tagSim3Tanks,ID,Q,Y,time);

end

end

%==========================================================================

function plotOneFlow(tagSim3Tanks,FLOW_ID,Q,Y,time)

FIG_ID = [tagSim3Tanks,'_fig_flow_',FLOW_ID];

try
    delete(findobj('Tag',FIG_ID));
catch
end

realValue = Q.(FLOW_ID);
measuredValue = Y.(FLOW_ID);

N = numel(time);
MarkIdx = 1:round(N/4):N;

figure('Tag',FIG_ID,...
    'Numbertitle','off',...
    'Name',[tagSim3Tanks,': ',FLOW_ID]);

% Real value
subplot(2,1,1); hold on; box on;
plot(time,realValue,'b-o','MarkerIndices',MarkIdx);
legend(FLOW_ID,'Location','Northeast');
xlabel('Time');
ylabel('Real value');
xlim([time(1) time(N)]);

% Measured value
subplot(2,1,2); hold on; box on;
plot(time,measuredValue,'r-o','MarkerIndices',MarkIdx);
legend(FLOW_ID,'Location','Northeast');
xlabel('Time');
ylabel('Measured value');
xlim([time(1) time(N)]);

end

%==========================================================================

function plotAllFlows(tagSim3Tanks,FLOW_IDs,Q,Y,time)

FIG_ID = [tagSim3Tanks,'_fig_flow_all'];

try
    delete(findobj('Tag',FIG_ID));
catch
end

N = numel(time);

figure('Tag',FIG_ID,...
    'Numbertitle','off',...
    'Name',[tagSim3Tanks,': flows']);

% Real value
subplot(2,1,1); hold on; box on;
p1 = plot(time,Q.(FLOW_IDs{1}));
p2 = plot(time,Q.(FLOW_IDs{2}));
p3 = plot(time,Q.(FLOW_IDs{3}));
p4 = plot(time,Q.(FLOW_IDs{4}));
p5 = plot(time,Q.(FLOW_IDs{5}));
p6 = plot(time,Q.(FLOW_IDs{6}));
p7 = plot(time,Q.(FLOW_IDs{7}));
p8 = plot(time,Q.(FLOW_IDs{8}));
p9 = plot(time,Q.(FLOW_IDs{9}));
p10 = plot(time,Q.(FLOW_IDs{10}));
legend([p1 p2 p3 p4 p5 p6 p7 p8 p9 p10],...
    FLOW_IDs{1},FLOW_IDs{2},FLOW_IDs{3},FLOW_IDs{4},FLOW_IDs{5},...
    FLOW_IDs{6},FLOW_IDs{7},FLOW_IDs{8},FLOW_IDs{9},FLOW_IDs{10},...
    'Location','NorthEastOutside');
xlabel('Time');
ylabel('Real values');
xlim([time(1) time(N)]);

% Measured value
subplot(2,1,2); hold on; box on;
plot(time,Y.(FLOW_IDs{1}));
plot(time,Y.(FLOW_IDs{2}));
plot(time,Y.(FLOW_IDs{3}));
plot(time,Y.(FLOW_IDs{4}));
plot(time,Y.(FLOW_IDs{5}));
plot(time,Y.(FLOW_IDs{6}));
plot(time,Y.(FLOW_IDs{7}));
plot(time,Y.(FLOW_IDs{8}));
plot(time,Y.(FLOW_IDs{9}));
plot(time,Y.(FLOW_IDs{10}));
xlabel('Time');
ylabel('Measured values');
xlim([time(1) time(N)]);

end
