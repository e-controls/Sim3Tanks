function [varargout] = faultStepwise(MAGNITUDE,FAULT_TIME,TIME_VECTOR)
% [SIGNAL,TIME_VECTOR] = faultStepwise(MAGNITUDE,FAULT_TIME,TIME_VECTOR)
% generates a stepwise fault signal, where MAGNITUDE specifies the maximum
% fault magnitude within the range FAULT_TIME, which is a two-position
% vector containing the start and end time of the fault, [START,END]. The
% output SIGNAL is the corresponding signal vector, and TIME_VECTOR is a
% vector of time points.
%
% If TIME_VECTOR is omitted, a default time vector is declared with the
% following settings: 0 : 0.1 : (max(FAULT_TIME)+10)
%
% Example:
%   [signal,t] = faultStepwise(0.8,[10 40]);
%   plot(t,signal);
%   grid on;
%   xlabel('Time (s)');
%   ylabel('Fault Magnitude');
%   title('Stepwise Signal');

% Written by Arllem Farias, 2024.

if(MAGNITUDE<0 || MAGNITUDE>1)
    error('MAGNITUDE must be within the range [0,1].');
elseif(numel(FAULT_TIME)~=2)
    error('FAULT_TIME must be a two-position vector.');
end

% If the TIME_VECTOR argument is omitted.
if(nargin() < 3)
    duration = max(FAULT_TIME) + 10;
    TIME_VECTOR = 0 : 0.1 : duration;
end

SIGNAL = zeros(size(TIME_VECTOR));

SIGNAL(TIME_VECTOR>=FAULT_TIME(1) & TIME_VECTOR<=FAULT_TIME(2)) = MAGNITUDE;

varargout{1} = SIGNAL;
varargout{2} = TIME_VECTOR;

end