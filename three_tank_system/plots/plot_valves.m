function [] = plot_valves(K,dK,name)

t  = get_time();
N  = length(t);
N1 = round(N/4);
l  = ones(1,N);

normal = get_color('normal');
fault  = get_color('fault');

if(nargin() <= 1)
    
    if(nargin()==0)
        K  = get_valves_state();
    end
    
    dK = get_operation_mode();
    
    figure('Tag','fig_all_valves','Numbertitle','off','Name','All valves');
    name = {'Kp1','Kp2','Ka','Kb','K13','K23','K1','K2','K3'};
    
    for i = 1 : length(name)
        
        flag1 = 'Closed';
        flag2 = 'Open';
        if(dK(i) ~= 0)
            flag1 = 'Open';
            flag2 = 'Closed';
        end
        
        subplot(3,3,i); hold on; box on;
        plot(t,dK(i)*l,'--','Color',normal);
        plot(t,(1-dK(i))*l,'--','Color',fault);
        plot(t,K(i,:),'k-o','MarkerIndices',1:N1:N);
        title(name(i),'FontSize',12);
        xlim([t(1) t(N)]);
        ylim([-0.1 1.1]);
        
        text(t(1),dK(i),flag1,'FontSize',8,'HorizontalAlignment','Left','BackgroundColor',normal);
        text(t(1),1-dK(i),flag2,'FontSize',8,'HorizontalAlignment','Left','BackgroundColor',fault);
        
    end
    
elseif(nargin() == 3)
    
    flag1 = 'Closed';
    flag2 = 'Open';
    if(dK ~= 0)
        flag1 = 'Open';
        flag2 = 'Closed';
    end
    
    figure('Tag',name,'Numbertitle','off','Name',['Valve: ',name]); hold on; box on;
    
    plot(t,dK*l,'--','Color',normal);
    plot(t,(1-dK)*l,'--','Color',fault);
    p = plot(t,K,'k-o','MarkerIndices',1:N1:N);
    legend(p,name,'Location','NorthEast');
    xlabel('time (s)');
    ylabel('valve behavior');
    xlim([t(1) t(N)]);
    ylim([-0.05 1.05]);
    
    text(t(1),dK,flag1,'FontSize',8,'HorizontalAlignment','Left','BackgroundColor',normal);
    text(t(1),1-dK,flag2,'FontSize',8,'HorizontalAlignment','Left','BackgroundColor',fault);
    
end