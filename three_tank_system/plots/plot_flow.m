function [] = plot_flow(my_legend,real_flow,measured_flow)

figure('Tag',my_legend,'Numbertitle','off','Name',['Flow: ',my_legend]);

t  = get_time();
N  = length(t);
N1 = round(N/4);

%% Real flow
subplot(2,1,1); hold on; box on;
plot(t,real_flow,'b-o','MarkerIndices',1:N1:N);
legend(my_legend,'Location','NorthEast');
xlabel('time (s)');
ylabel('real flow (cm^3/s)');
xlim([t(1) t(N)]);

%% Measured flow
subplot(2,1,2); hold on; box on;
plot(t,measured_flow,'r');
legend(my_legend,'Location','NorthEast');
xlabel('time (s)');
ylabel('measured flow (cm^3/s)');
xlim([t(1) t(N)]);

end