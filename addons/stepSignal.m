function [varargout] = stepSignal(VALUES,TIMES,TIME_VECTOR)
% [SIGNAL,TIME_VECTOR] = stepSignal(VALUES,TIMES,TIME_VECTOR) generates a
% step signal, where VALUES specifies the amplitude of the SIGNAL at the
% corresponding TIMES position. The SIGNAL remains at zero until the first
% time in TIMES, after that it changes to the next value at the subsequent
% time, and so on. The output SIGNAL is the corresponding signal values,
% and TIME_VECTOR is a vector of time points.
%
% If TIME_VECTOR is omitted, a default time vector is declared with the
% following settings: [0 : 0.1 : max(FAULT_TIME)+10]
%
% Example:
%   VALUES = [30, 50, 40];
%   TIMES  = [10, 30, 50];
%   [signal,t] = stepSignal(VALUES,TIMES);
%   plot(t,signal);
%   grid on;
%   xlabel('time');
%   ylabel('magnitude');
%   title('Setpoint Signal');

% Written by Arllem Farias, 2024.
% https://github.com/e-controls/Sim3Tanks

if(numel(VALUES) ~= numel(TIMES))
    error('The VALUES and TIMES vectors must have the same size.');
end

% If the TIME_VECTOR argument is omitted.
if(nargin() < 3)
    duration = max(TIMES) + 10;
    TIME_VECTOR = 0 : 0.1 : duration;
end

SIGNAL = zeros(size(TIME_VECTOR));

for k = 1 : numel(TIMES)
    if(k == 1)
        SIGNAL(TIME_VECTOR >= TIMES(k)) = VALUES(k);
    else
        SIGNAL(TIME_VECTOR >= TIMES(k-1) & TIME_VECTOR < TIMES(k)) = VALUES(k-1);
        SIGNAL(TIME_VECTOR >= TIMES(k)) = VALUES(k);
    end
end

varargout{1} = SIGNAL;
varargout{2} = TIME_VECTOR;

end