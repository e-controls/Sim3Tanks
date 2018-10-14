function [Qp] = get_pumps(k)
% Qp = GET_PUMPS(k) returns the flow rate from the pumps P1 and P2 at
% sample k. If k is omitted from the input argument, then the full signals
% of the pumps P1 and P2 are returned.
%
% See also SET_PUMPS.

% Written by Arllem Farias, 2018.

global pumps;

if(nargin() == 0)
    Qp = pumps;
else
    Qp = pumps(:,k);
end