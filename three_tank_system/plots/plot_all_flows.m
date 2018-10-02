function [] = plot_all_flows(real_flow,measured_flow)

figure('Tag','fig_all_flows','Numbertitle','off','Name','All flows');

t = get_time();

%% Real flow
subplot(2,1,1); hold on; box on;
plot(t,real_flow');
legend('u1','u2','Qa','Qb','Q13','Q23','Q1','Q2','Q3','Location','NorthEastOutside');
xlabel('time (s)');
ylabel('real flow (cm^3/s)');

%% Measured flow
subplot(2,1,2); hold on; box on;
plot(t,measured_flow');
xlabel('time (s)');
ylabel('measured flow (cm^3/s)');

end