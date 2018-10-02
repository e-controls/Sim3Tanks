% ***DO NOT EDIT [Begin]***
try
    run('pre_settings');
catch
    error(['#The ',filename,'.slx file is not open or the ',blockname,' block does not exist in the current Simulink file.']);
end
% ***DO NOT EDIT [End]***

Sim3Tanks = Simulink.Mask.get(fullname);
hyperlink = Sim3Tanks.getDialogControl('hlink');

mask = get_param(fullname,'MaskVisibilities');

if strcmpi(get_param(fullname,'cboxFromWS'),'off')
    hyperlink.Visible = 'off';
    for i = 20 : length(mask)
        mask{i} = 'on';
    end
else
    hyperlink.Visible = 'on';
    for i = 20 : length(mask)
        mask{i} = 'off';
    end
end

set_param(fullname,'MaskVisibilities',mask);

clear Sim3Tanks hyperlink mask i;
