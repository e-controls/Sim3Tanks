% ***DO NOT EDIT [Begin]***
% >> SCROLL DOWN <<<
try
    run('pre_settings');
    t = get_time()';% Gets time vector.
    F1.time  = t; % Sets time to synchronize fault signal "F1".
    F2.time  = t; % Sets time to synchronize fault signal "F2".
    F3.time  = t; % Sets time to synchronize fault signal "F3".
    F4.time  = t; % Sets time to synchronize fault signal "F4".
    F5.time  = t; % Sets time to synchronize fault signal "F5".
    F6.time  = t; % Sets time to synchronize fault signal "F6".
    F7.time  = t; % Sets time to synchronize fault signal "F7".
    F8.time  = t; % Sets time to synchronize fault signal "F8".
    F9.time  = t; % Sets time to synchronize fault signal "F9".
    F10.time = t; % Sets time to synchronize fault signal "F10".
    F11.time = t; % Sets time to synchronize fault signal "F11".
    F12.time = t; % Sets time to synchronize fault signal "F12".
    F13.time = t; % Sets time to synchronize fault signal "F13".
    F14.time = t; % Sets time to synchronize fault signal "F14".
    F15.time = t; % Sets time to synchronize fault signal "F15".
    F16.time = t; % Sets time to synchronize fault signal "F16".
    F17.time = t; % Sets time to synchronize fault signal "F17".
    F18.time = t; % Sets time to synchronize fault signal "F18".
    F19.time = t; % Sets time to synchronize fault signal "F19".
    F20.time = t; % Sets time to synchronize fault signal "F20".
    F21.time = t; % Sets time to synchronize fault signal "F21".
    clear t;
catch
    error(['#Open the file ',filename,'.slx and run simulation.']);
end
% ***DO NOT EDIT [End]***

%% Fault signals to simulink
% The fault signals must satisfy the following properties:
%    1) be a column vector;
%    2) have the same number of samples as time vector;
%    3) does not have NaN in its samples;
%    4) does not have Inf in its samples;
%    5) all values of its samples must be between [0,1].
% Use the function "check_fault_signal(fsignal)" to check these properties,
% for more info, type "help check_fault_signal" in the command window.

% Example: replace "F1.signals.values = fsignal" for:
% F1.signals.values = mysaturation(sin(0.0125*pi*time),0,1);

% >> To see the new F1 signal:
% 1. Save this file;
% 2. Back to Simulink and run simulation;
% 3. Go to subsystem "fault generator" and open F1 scope.

time = get_time()'; % Transposed time vector.
fsignal = check_fault_signal(zeros(size(time))); % Fault signal.

%F1.signals.values = fsignal; % Sets fault signal "F1" to be read by Simulink.
F1.signals.values = mysaturation(sin(0.0125*pi*time),0,1);

F2.signals.values = fsignal; % Sets fault signal "F2" to be read by Simulink.

F3.signals.values = fsignal; % Sets fault signal "F3" to be read by Simulink.

F4.signals.values = fsignal; % Sets fault signal "F4" to be read by Simulink.

F5.signals.values = fsignal; % Sets fault signal "F5" to be read by Simulink.

F6.signals.values = fsignal; % Sets fault signal "F6" to be read by Simulink.

F7.signals.values = fsignal; % Sets fault signal "F7" to be read by Simulink.

F8.signals.values = fsignal; % Sets fault signal "F8" to be read by Simulink.

F9.signals.values = fsignal; % Sets fault signal "F9" to be read by Simulink.

F10.signals.values = fsignal; % Sets fault signal "F10" to be read by Simulink.

F11.signals.values = fsignal; % Sets fault signal "F11" to be read by Simulink.

F12.signals.values = fsignal; % Sets fault signal "F12" to be read by Simulink.

F13.signals.values = fsignal; % Sets fault signal "F13" to be read by Simulink.

F14.signals.values = fsignal; % Sets fault signal "F14" to be read by Simulink.

F15.signals.values = fsignal; % Sets fault signal "F15" to be read by Simulink.

F16.signals.values = fsignal; % Sets fault signal "F16" to be read by Simulink.

F17.signals.values = fsignal; % Sets fault signal "F17" to be read by Simulink.

F18.signals.values = fsignal; % Sets fault signal "F18" to be read by Simulink.

F19.signals.values = fsignal; % Sets fault signal "F19" to be read by Simulink.

F20.signals.values = fsignal; % Sets fault signal "F20" to be read by Simulink.

F21.signals.values = fsignal; % Sets fault signal "F21" to be read by Simulink.
