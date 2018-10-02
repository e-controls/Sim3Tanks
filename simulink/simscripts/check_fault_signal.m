function [fsignal] = check_fault_signal(F)
% CHECK_FAULT_SIGNAL(F): receives a vector F, but only returns F if it
% satisfies the following properties:
%   1) is a column vector;
%   2) has the same number of samples as time vector;
%   3) does not have NaN in its samples;
%   4) does not have Inf in its samples;
%   5) all values of its samples are between [0,1].
%
% otherwise, returns an error message stating which property was not
% satisfied.

time = get_time();

if isempty(time)
    warning('Time vector has not been set. It will be set only when the simulation starts.');
    filename = import_from_ws('filename');
    fullname = import_from_ws('fullname');
    tstart   = str2double(get_param(filename,'StartTime'));% Gets start time from Simulink
    tstop    = str2double(get_param(filename,'StopTime'));% Gets stop time from Simulink
    Ts       = str2double(get_param(fullname,'editTs'));% Gets time span of ode45 solver
    time     = linspace(tstart, tstop, 1+tstop/Ts);
end

%% Test 1: checks if fault signal is a column vector.
if ~iscolumn(F)
    error('#The fault signal must be a column vector.');
end

%% Test 2: checks if fault signal has the same number of samples as time vector.
n = length(time);
if length(F) ~= n
    error(['#The fault signal must have the same number of samples as time vector (i.e., ',num2str(n),' samples).']);
end

%% Test 3: checks if fault signal has NaN.
[thereisnan,position] = max(isnan(F));
if thereisnan
    error(['#The fault signal has a NaN at position ',num2str(position),'.']);
end

%% Test 4: checks if fault signal has Inf.
[thereisinf,position] = max(isinf(F));
if thereisinf
    error(['#The fault signal has an Inf at position ',num2str(position),'.']);
end

%% Test 5: checks if fault signal is between [0,1].
if ~(min(F)>=0 && max(F)<=1)
    error('#The values of fault signal must be betweeen [0,1].');
end

%% The signal is ok.
% disp('#All properties are satisfied.');
fsignal = F;

end
