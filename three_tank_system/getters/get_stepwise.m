function [fsignal] = get_stepwise(fmag, fstart, fstop)

t = get_time();
n = length(t);

fsignal = zeros(1,n);

if(fmag ~= 0)
    for j = 1 : n
        if(t(j) >= fstart && t(j) <= fstop)
            fsignal(j) = fmag;
        end
    end
end