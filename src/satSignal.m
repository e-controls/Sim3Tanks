function [y] = satSignal(varargin)
% satSignal is a Sim3Tanks function. This function saturates a variable x
% into the bounds [xmin,xmax].
%
% y = satSignal(x,[xmin,xmax]), where x is the variable (scalar or vector),
% and [xmin,xmax] are the bounds.

% https://github.com/e-controls/Sim3Tanks

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
end

minValue = xrange(:,1);
maxValue = xrange(:,2);

y = min(maxValue,max(minValue,x));

end