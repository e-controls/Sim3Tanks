% ***DO NOT EDIT [Begin]***
try
    run('pre_settings');
catch
    error(['#The ',filename,'.slx file is not open or the ',blockname,' block does not exist in the current Simulink file.']);
end
% ***DO NOT EDIT [End]***

%% Gets the default parameters
fault = get_default_param('field9');

%% Resets "From workspace"
set_param(fullname,'cboxFromWS','off');

Sim3Tanks = Simulink.Mask.get(fullname);
hyperlink = Sim3Tanks.getDialogControl('hlink');
hyperlink.Visible = 'off';

mask = get_param(fullname,'MaskVisibilities');

for i = 20 : length(mask)
    mask{i} = 'on';
end

set_param(fullname,'MaskVisibilities',mask);

%% Resets the fault signals

% Fault F1 ---------------------------------------------------------------+
set_param(fullname,'f1mag',num2str(fault(1)));
set_param(fullname,'f1type',fault(2));
set_param(fullname,'f1start',num2str(fault(3)));
set_param(fullname,'f1stop',num2str(fault(4)));

% Fault F2 ---------------------------------------------------------------+
set_param(fullname,'f2mag',num2str(fault(1)));
set_param(fullname,'f2type',fault(2));
set_param(fullname,'f2start',num2str(fault(3)));
set_param(fullname,'f2stop',num2str(fault(4)));

% Fault F3 ---------------------------------------------------------------+
set_param(fullname,'f3mag',num2str(fault(1)));
set_param(fullname,'f3type',fault(2));
set_param(fullname,'f3start',num2str(fault(3)));
set_param(fullname,'f3stop',num2str(fault(4)));

% Fault F4 ---------------------------------------------------------------+
set_param(fullname,'f4mag',num2str(fault(1)));
set_param(fullname,'f4type',fault(2));
set_param(fullname,'f4start',num2str(fault(3)));
set_param(fullname,'f4stop',num2str(fault(4)));

% Fault F5 ---------------------------------------------------------------+
set_param(fullname,'f5mag',num2str(fault(1)));
set_param(fullname,'f5type',fault(2));
set_param(fullname,'f5start',num2str(fault(3)));
set_param(fullname,'f5stop',num2str(fault(4)));

% Fault F6 ---------------------------------------------------------------+
set_param(fullname,'f6mag',num2str(fault(1)));
set_param(fullname,'f6type',fault(2));
set_param(fullname,'f6start',num2str(fault(3)));
set_param(fullname,'f6stop',num2str(fault(4)));

% Fault F7 ---------------------------------------------------------------+
set_param(fullname,'f7mag',num2str(fault(1)));
set_param(fullname,'f7type',fault(2));
set_param(fullname,'f7start',num2str(fault(3)));
set_param(fullname,'f7stop',num2str(fault(4)));

% Fault F8 ---------------------------------------------------------------+
set_param(fullname,'f8mag',num2str(fault(1)));
set_param(fullname,'f8type',fault(2));
set_param(fullname,'f8start',num2str(fault(3)));
set_param(fullname,'f8stop',num2str(fault(4)));

% Fault F9 ---------------------------------------------------------------+
set_param(fullname,'f9mag',num2str(fault(1)));
set_param(fullname,'f9type',fault(2));
set_param(fullname,'f9start',num2str(fault(3)));
set_param(fullname,'f9stop',num2str(fault(4)));

% Fault F10 --------------------------------------------------------------+
set_param(fullname,'f10mag',num2str(fault(1)));
set_param(fullname,'f10type',fault(2));
set_param(fullname,'f10start',num2str(fault(3)));
set_param(fullname,'f10stop',num2str(fault(4)));

% Fault F11 --------------------------------------------------------------+
set_param(fullname,'f11mag',num2str(fault(1)));
set_param(fullname,'f11type',fault(2));
set_param(fullname,'f11start',num2str(fault(3)));
set_param(fullname,'f11stop',num2str(fault(4)));

% Fault F12 --------------------------------------------------------------+
set_param(fullname,'f12mag',num2str(fault(1)));
set_param(fullname,'f12type',fault(2));
set_param(fullname,'f12start',num2str(fault(3)));
set_param(fullname,'f12stop',num2str(fault(4)));

% Fault F13 --------------------------------------------------------------+
set_param(fullname,'f13mag',num2str(fault(1)));
set_param(fullname,'f13type',fault(2));
set_param(fullname,'f13start',num2str(fault(3)));
set_param(fullname,'f13stop',num2str(fault(4)));

% Fault F14 --------------------------------------------------------------+
set_param(fullname,'f14mag',num2str(fault(1)));
set_param(fullname,'f14type',fault(2));
set_param(fullname,'f14start',num2str(fault(3)));
set_param(fullname,'f14stop',num2str(fault(4)));

% Fault F15 --------------------------------------------------------------+
set_param(fullname,'f15mag',num2str(fault(1)));
set_param(fullname,'f15type',fault(2));
set_param(fullname,'f15start',num2str(fault(3)));
set_param(fullname,'f15stop',num2str(fault(4)));

% Fault F16 --------------------------------------------------------------+
set_param(fullname,'f16mag',num2str(fault(1)));
set_param(fullname,'f16type',fault(2));
set_param(fullname,'f16start',num2str(fault(3)));
set_param(fullname,'f16stop',num2str(fault(4)));

% Fault F17 --------------------------------------------------------------+
set_param(fullname,'f17mag',num2str(fault(1)));
set_param(fullname,'f17type',fault(2));
set_param(fullname,'f17start',num2str(fault(3)));
set_param(fullname,'f17stop',num2str(fault(4)));

% Fault F18 --------------------------------------------------------------+
set_param(fullname,'f18mag',num2str(fault(1)));
set_param(fullname,'f18type',fault(2));
set_param(fullname,'f18start',num2str(fault(3)));
set_param(fullname,'f18stop',num2str(fault(4)));

% Fault F19 --------------------------------------------------------------+
set_param(fullname,'f19mag',num2str(fault(1)));
set_param(fullname,'f19type',fault(2));
set_param(fullname,'f19start',num2str(fault(3)));
set_param(fullname,'f19stop',num2str(fault(4)));

% Fault F20 --------------------------------------------------------------+
set_param(fullname,'f20mag',num2str(fault(1)));
set_param(fullname,'f20type',fault(2));
set_param(fullname,'f20start',num2str(fault(3)));
set_param(fullname,'f20stop',num2str(fault(4)));

% Fault F21 --------------------------------------------------------------+
set_param(fullname,'f21mag',num2str(fault(1)));
set_param(fullname,'f21type',fault(2));
set_param(fullname,'f21start',num2str(fault(3)));
set_param(fullname,'f21stop',num2str(fault(4)));

clear fault Sim3Tanks hyperlink mask i;

disp('#Faults have been successfully reset.');
