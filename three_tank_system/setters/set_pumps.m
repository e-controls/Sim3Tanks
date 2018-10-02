function [] = set_pumps(flow, pstart, pstop)

time = get_time();
m = length(flow);
n = length(time);

global pumps;

if(nargin()==1)
    pumps = flow;
else
    pumps = zeros(m,n);
    for i = 1 : m
        if(flow(i) >= 0)
            for j = 1 : n
                if(time(j) >= pstart(i) && time(j) <= pstop(i))
                    pumps(i,j) = flow(i);
                end
            end
        end
    end
end