function [] = plot_residues(y, yhat, r)

figure('Tag','residues','Numbertitle','off','Name','Residues');

yout = [y(1,:); y(2,:); y(3,:); y(4,:); y(5,:); y(8,:); y(9,:); y(12,:)];
name = {'h1','h2','h3','u1','u2','Q13','Q23','Q3'};

t  = get_time();
N  = length(t);
N1 = round(N/4);

for i = 1 : length(name)
    
    subplot(4,2,i); hold on; box off;
    plot(t,yout(i,:),'r');
    plot(t,yhat(i,:),'b--o','MarkerIndices',1:N1:N);
    plot(t,r(i,:),'k');
    ylabel(name(i),'FontSize',10);
    xlim([t(1) t(N)]);
    
end