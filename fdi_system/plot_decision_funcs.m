function [] = plot_decision_funcs(g)

figure('Tag','glr','Numbertitle','off','Name','GLR');

name = {'g1(k)','g2(k)','g3(k)','g4(k)','g5(k)','g6(k)','g7(k)','g8(k)'};

th = [20 20 20 40 40 20 20 20]';
t  = get_time();
N  = length(t);

for i = 1 : length(name)
    
    subplot(4,2,i); hold on; box off;
    plot(t,g(i,:),'b');
    plot(th(i)*ones(1,N),'--r');
    ylabel(name(i),'FontSize',10);
    xlim([t(1) t(N)]);
    
end