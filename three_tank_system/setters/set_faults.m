function [] = set_faults(fmag, ftype, fstart, fstop)

t = get_time();
m = length(fmag);
n = length(t);

global faults;
faults = zeros(m,n);

for i = 1 : m
    
    if(ftype(i) == 0)
        faults(i,:) = get_stepwise(fmag(i), fstart(i), fstop(i));
    elseif(ftype(i) == 1)
        faults(i,:) = get_driftwise(fmag(i), fstart(i), fstop(i));
    end
    
end