function [spsignal] = get_setpoint(setpoint,time)
% gera um sinal de setpoint. Por exemplo, get_setpoint([10 50 40],[0 20 35])
% gera um sinal que tem valor 10 a partir de t=0s, em t=20s o sinal sobe
% para 50, e em t=35s o sinal desce para 40.

t = get_time();
N = length(t);

smerge = [0,setpoint];
tmerge = [time,t(N)+1];

spsignal = zeros(1,N);

p=1;
for i=1 : length(smerge)
    for k=p : N
        if(t(k)>=tmerge(i))
            p=k;
            break;
        else
            spsignal(k)=smerge(i);
        end
    end
end