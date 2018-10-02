% ***DO NOT EDIT [Begin]***
try
    run('pre_settings');
catch
    error(['#The ',filename,'.slx file is not open or the ',blockname,' block does not exist in the current Simulink file.']);
end
% ***DO NOT EDIT [End]***

%% Gets the default parameters
param = get_default_param('field1');
tsim  = get_default_param('field6');

%% Resets the system parameters
set_param(filename,'StartTime',num2str(tsim(1)));
set_param(filename,'StopTime',num2str(tsim(2)));
set_param(fullname,'editTs',num2str(tsim(3)));
set_param(fullname,'editRR',num2str(param(1)));
set_param(fullname,'editHmax',num2str(param(2)));
set_param(fullname,'editR',num2str(param(3)));
set_param(fullname,'edith0',num2str(param(4)));
set_param(fullname,'editmi',num2str(param(5)));
set_param(fullname,'editg',num2str(param(6)));

clear param tsim;

disp('#Parameters have been successfully reset.');
