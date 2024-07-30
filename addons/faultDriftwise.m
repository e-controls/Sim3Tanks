function [varargout] = faultDriftwise(MAGNITUDE,FAULT_TIME,TIME_VECTOR)
% [SIGNAL,TIME_VECTOR] = faultDriftwise(MAGNITUDE,FAULT_TIME,TIME_VECTOR)
% generates a driftwise fault signal, where MAGNITUDE specifies the maximum
% fault magnitude within the range FAULT_TIME, which is a four-position
% vector containing each transition time of the fault, [t1,t2,t3,t4]. The
% output SIGNAL is the corresponding signal vector, and TIME_VECTOR is a
% vector of time points.
%
% If TIME_VECTOR is omitted, a default time vector is declared with the
% following settings: [0 : 0.1 : max(FAULT_TIME)+10]
%
% Example:
%   [signal,t] = faultDriftwise(0.8,[20 40 80 120]);
%   plot(t,signal);
%   grid on;
%   xlabel('time');
%   ylabel('magnitude');
%   title('Driftwise Fault Signal');

% Written by Arllem Farias, 2024.
% https://github.com/e-controls/Sim3Tanks

if(MAGNITUDE<0 || MAGNITUDE>1)
    error('MAGNITUDE must be within the range [0,1].');
elseif(numel(FAULT_TIME)~=4)
    error('FAULT_TIME must be a four-position vector.');
end

% If the TIME_VECTOR argument is omitted.
if(nargin() < 3)
    duration = max(FAULT_TIME) + 10;
    TIME_VECTOR = 0 : 0.1 : duration;
end

% First part of the signal
SIGNAL = zeros(size(TIME_VECTOR));

SIGNAL(TIME_VECTOR>=FAULT_TIME(1) & TIME_VECTOR<=FAULT_TIME(2)) = 1;
NUMBER_OF_SAMPLES = sum(SIGNAL);
[~,START_INDEX] = max(SIGNAL);

for j = START_INDEX : START_INDEX+NUMBER_OF_SAMPLES-1
    SIGNAL(j) = SIGNAL(j-1) + MAGNITUDE/NUMBER_OF_SAMPLES;
    SIGNAL(j) = min(1,SIGNAL(j));
end

% Second part of the signal
SIGNAL(TIME_VECTOR>FAULT_TIME(2) & TIME_VECTOR<=FAULT_TIME(3)) = MAGNITUDE;

% Third part of the signal
SIGNAL_AUX = zeros(size(TIME_VECTOR));

SIGNAL_AUX(TIME_VECTOR>FAULT_TIME(3) & TIME_VECTOR<=FAULT_TIME(4)) = 1;
NUMBER_OF_SAMPLES = sum(SIGNAL_AUX);
[~,START_INDEX] = max(SIGNAL_AUX);

for j = START_INDEX : START_INDEX+NUMBER_OF_SAMPLES-1
    SIGNAL(j) = SIGNAL(j-1) - MAGNITUDE/NUMBER_OF_SAMPLES;
    SIGNAL(j) = max(0,SIGNAL(j));
end

varargout{1} = SIGNAL;
varargout{2} = TIME_VECTOR;

end