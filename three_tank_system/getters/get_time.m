function [t] = get_time(k)

global time;

if (nargin() == 0)
    t = time;
else
    t = time(k);
end