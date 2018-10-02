function [Ts] = get_sample_time()

try
    Ts = get_time(2)-get_time(1);
catch
    tsim  = get_default_param('field6');
    Ts = tsim(3);
end