function [y] = satSignal(varargin)
% satSignal is a Sim3Tanks function. This function ensures that a variable
% x is into the range defined by [xmin,xmax].
%
% y = satSignal(x, xrange), where x is the variable (scalar or vector), and
% xrange = [xmin,xmax].

% Written by Arllem Farias, January/2024.
% Last update June/2024 by Arllem Farias.

%==========================================================================

if(nargin()<2)
    error(getMessage('ERR001'));
elseif(nargin()>2)
    error(getMessage('ERR002'));
else
    x = varargin{1};
    xrange = varargin{2};
end

if ~(isnumeric(x) && isnumeric(xrange))
    error(getMessage('ERR003'));
elseif (numel(xrange) ~= 2)
    error(getMessage('ERR006'));
end

minValue = xrange(1);
maxValue = xrange(2);

y = min(maxValue, max(minValue,x));

end