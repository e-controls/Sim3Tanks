function [t] = get_time(k)
% GET_TIME(k) returns the time at sample k. If k is omitted from the input
% argument, then the full time vector is returned.
%
% See also SET_TIME.

% Written by Arllem Farias, 2018.

global time;

if (nargin() == 0)
    t = time;
else
    t = time(k);
end