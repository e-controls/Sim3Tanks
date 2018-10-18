function [] = set_time(t)
% SET_TIME(t) sets the time vector t. The time vector, t, must be a row
% vector with N samples.
%
% This function does not have output arguments.
%
% See also GET_TIME.

% Written by Arllem Farias, 2018.

global time;

time = t;

end