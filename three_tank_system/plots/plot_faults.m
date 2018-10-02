function [] = plot_faults(f,name)

t  = get_time();
N  = length(t);
N1 = round(N/4);

if(nargin() <= 1)
    
    if(nargin()==0)
        f = get_faults();
    end
    
    figure('Tag','fig_all_faults','Numbertitle','off','Name','All faults');
    name = {'F1','F2','F3','F4','F5','F6','F7','F8','F9','F10','F11','F12','F13','F14','F15','F16','F17','F18','F19','F20','F21'};
    
    for i = 1 : length(name)
        
        subplot(3,7,i); hold on; box on;
        plot(t,f(i,:),'r-o','MarkerIndices',1:N1:N);
        title(name(i),'FontSize',12);
        xlim([t(1) t(N)]);
        ylim([0 1]);
        
    end
    
elseif(nargin() == 2)
    
    figure('Tag',name,'Numbertitle','off','Name',['Fault: ',name]); hold on; box on;
    
    plot(t,f,'r-o','MarkerIndices',1:N1:N);
    legend(name,'Location','NorthEast');
    xlabel('time (s)');
    ylabel('fault magnitude');
    xlim([t(1) t(N)]);
    ylim([0 1]);
    
end