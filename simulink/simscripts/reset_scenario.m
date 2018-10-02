% ***DO NOT EDIT [Begin]***
try
    run('pre_settings');
catch
    error(['#The ',filename,'.slx file is not open or the ',blockname,' block does not exist in the current Simulink file.']);
end
% ***DO NOT EDIT [End]***

%% Gets the default parameters
dK = get_default_param('field10');

%% Resets the system operation mode
set_param(fullname,'cboxKp1',dK(1));
set_param(fullname,'cboxKp2',dK(2));
set_param(fullname,'cboxKa',dK(3));
set_param(fullname,'cboxKb',dK(4));
set_param(fullname,'cboxK13',dK(5));
set_param(fullname,'cboxK23',dK(6));
set_param(fullname,'cboxK1',dK(7));
set_param(fullname,'cboxK2',dK(8));
set_param(fullname,'cboxK3',dK(9));

clear dK;

disp('#Scenario have been successfully reset.');
