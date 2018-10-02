function [f] = get_faults(k)

global faults;

if (nargin() == 0)
    f = faults;
else
    f = faults(:,k);
end