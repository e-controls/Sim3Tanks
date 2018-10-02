function [Qp] = get_pumps(k)

global pumps;

if (nargin() == 0)
    Qp = pumps;
else
    Qp = pumps(:,k);
end