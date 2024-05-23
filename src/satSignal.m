function [y] = satSignal(x,xrange)
% satSignal is a Sim3Tanks function. This function ensures that a variable
% x is into the range defined by [xmin,xmax].

% Written by Arllem Farias, January/2024.
% Last update January/2024 by Arllem Farias.

%==========================================================================

minValue = xrange(1);
maxValue = xrange(2);

y = min(maxValue, max(minValue,x));

end