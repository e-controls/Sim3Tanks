function [] = plot_probabilities(p)

figure('Tag','probs','Numbertitle','off','Name','Probabilities');

name = {'F1','F2','F5','F6','F7','F8','F9','F10','F11','F12','F13','F14','F17','F18','F21'};

t = get_time();
N = length(t);

for i = 1 : length(name)
    
    subplot(3,5,i); hold on; box off;
    bar(t,p(i,:));
    title(name(i),'FontSize',10);
    ylabel(strcat('p(',name(i),'|z1,z2,...,z8)'),'FontSize',8);
    xlim([t(1) t(N)]);
    ylim([0 1]);
    
end