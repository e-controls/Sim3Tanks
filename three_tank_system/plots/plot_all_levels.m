function [] = plot_all_levels(real_level,measured_level)

figure('Tag','fig_all_levels','Numbertitle','off','Name','All levels');

t  = get_time();
N  = length(t);
N1 = round(N/4);
N2 = round(N1/2);
N3 = round((N1+N2)/2);

%% Real level
subplot(2,1,1); hold on; box on;
plot(t,real_level(1,:),'-o','MarkerIndices',01:N1:N);
plot(t,real_level(2,:),'-s','MarkerIndices',N2:N1:N);
plot(t,real_level(3,:),'-^','MarkerIndices',N3:N1:N);
legend('h1','h2','h3','Location','NorthEastOutside');
xlabel('time (s)');
ylabel('real level (cm)');
xlim([t(1) t(N)]);

%% Measured level
subplot(2,1,2); hold on; box on;
plot(t,measured_level');
xlabel('time (s)');
ylabel('measured level (cm)');
xlim([t(1) t(N)]);

end