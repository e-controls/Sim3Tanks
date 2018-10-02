function [] = plot_level(my_legend,real_level,measured_level)

figure('Tag',my_legend,'Numbertitle','off','Name',['Level: ',my_legend]);

t  = get_time();
N  = length(t);
N1 = round(N/4);

%% Real level
subplot(2,1,1); hold on; box on;
plot(t,real_level,'b-o','MarkerIndices',1:N1:N);
legend(my_legend,'Location','NorthEast');
xlabel('time (s)');
ylabel('real level (cm)');
xlim([t(1) t(N)]);

%% Measured level
subplot(2,1,2); hold on; box on;
plot(t,measured_level,'r');
legend(my_legend,'Location','NorthEast');
xlabel('time (s)');
ylabel('measured level (cm)');
xlim([t(1) t(N)]);

end