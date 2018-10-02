function varargout = gui_help_simulink(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @gui_help_simulink_OpeningFcn, ...
    'gui_OutputFcn',  @gui_help_simulink_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

function varargout = gui_help_simulink_OutputFcn(~, ~, handles)

varargout{1} = handles.output;

function gui_help_simulink_OpeningFcn(hObject, ~, handles, varargin)

handles.output = hObject;

guidata(hObject, handles);

set(handles.sim_help_figure,'Name','Help');
movegui(gcf,'center');

b = get_color('b');
w = get_color('w');

fullname = import_from_ws('fullname');

if strcmpi(get_param(fullname,'cboxKp1'),'on')
    bkg = b;
    v   = 1;
    str = 'Open';
    f1_msg1 = 'Actuator fault 1';
    f1_msg2 = 'Closing valve Kp1';
else
    bkg = w;
    v   = 0;
    str = 'Closed';
    f1_msg1 = 'Disturbance in tank 1';
    f1_msg2 = 'Opening valve Kp1';
end
set(handles.gui_Kp1,'BackgroundColor',bkg,'Value',v)
set(handles.gui_pipe_Kp1,'BackgroundColor',bkg);
set(handles.gui_text_Kp1,'String',str);

if strcmpi(get_param(fullname,'cboxKp2'),'on')
    bkg = b;
    v   = 1;
    str = 'Open';
    f2_msg1 = 'Actuator fault 2';
    f2_msg2 = 'Closing valve Kp2';
else
    bkg = w;
    v   = 0;
    str = 'Closed';
    f2_msg1 = 'Disturbance in tank 2';
    f2_msg2 = 'Opening valve Kp2';
end
set(handles.gui_Kp2,'BackgroundColor',bkg,'Value',v)
set(handles.gui_pipe_Kp2,'BackgroundColor',bkg);
set(handles.gui_text_Kp2,'String',str);

if strcmpi(get_param(fullname,'cboxKa'),'on')
    bkg = b;
    v   = 1;
    str = 'Open';
    f3_msg1 = 'Clogging in the TP13';
    f3_msg2 = 'Closing valve Ka';
else
    bkg = w;
    v   = 0;
    str = 'Closed';
    f3_msg1 = 'Leakage through the TP13';
    f3_msg2 = 'Opening valve Ka';
end
set(handles.gui_Ka,'BackgroundColor',bkg,'Value',v)
set(handles.gui_pipe_Ka,'BackgroundColor',bkg);
set(handles.gui_text_Ka,'String',str);

if strcmpi(get_param(fullname,'cboxKb'),'on')
    bkg = b;
    v   = 1;
    str = 'Open';
    f4_msg1 = 'Clogging in the TP23';
    f4_msg2 = 'Closing valve Kb';
else
    bkg = w;
    v   = 0;
    str = 'Closed';
    f4_msg1 = 'Leakage through the TP23';
    f4_msg2 = 'Opening valve Kb';
end
set(handles.gui_Kb,'BackgroundColor',bkg,'Value',v)
set(handles.gui_pipe_Kb,'BackgroundColor',bkg);
set(handles.gui_text_Kb,'String',str);

if strcmpi(get_param(fullname,'cboxK13'),'on')
    bkg = b;
    v   = 1;
    str = 'Open';
    f5_msg1 = 'Clogging in the CP13';
    f5_msg2 = 'Closing valve K13';
else
    bkg = w;
    v   = 0;
    str = 'Closed';
    f5_msg1 = 'Leakage through the CP13';
    f5_msg2 = 'Opening valve K13';
end
set(handles.gui_K13,'BackgroundColor',bkg,'Value',v)
set(handles.gui_pipe_K13,'BackgroundColor',bkg);
set(handles.gui_text_K13,'String',str);

if strcmpi(get_param(fullname,'cboxK23'),'on')
    bkg = b;
    v   = 1;
    str = 'Open';
    f6_msg1 = 'Clogging in the CP23';
    f6_msg2 = 'Closing valve K23';
else
    bkg = w;
    v   = 0;
    str = 'Closed';
    f6_msg1 = 'Leakage through the CP23';
    f6_msg2 = 'Opening valve K23';
end
set(handles.gui_K23,'BackgroundColor',bkg,'Value',v)
set(handles.gui_pipe_K23,'BackgroundColor',bkg);
set(handles.gui_text_K23,'String',str);

if strcmpi(get_param(fullname,'cboxK1'),'on')
    bkg = b;
    v   = 1;
    str = 'Open';
    f7_msg1 = 'Clogging in output pipe of the tank 1';
    f7_msg2 = 'Closing valve K1';
else
    bkg = w;
    v   = 0;
    str = 'Closed';
    f7_msg1 = 'Leakage in tank 1';
    f7_msg2 = 'Opening valve K1';
end
set(handles.gui_K1,'BackgroundColor',bkg,'Value',v)
set(handles.gui_pipe_K1,'BackgroundColor',bkg);
set(handles.gui_text_K1,'String',str);

if strcmpi(get_param(fullname,'cboxK2'),'on')
    bkg = b;
    v   = 1;
    str = 'Open';
    f8_msg1 = 'Clogging in output pipe of the tank 2';
    f8_msg2 = 'Closing valve K2';
else
    bkg = w;
    v   = 0;
    str = 'Closed';
    f8_msg1 = 'Leakage in tank 2';
    f8_msg2 = 'Opening valve K2';
end
set(handles.gui_K2,'BackgroundColor',bkg,'Value',v)
set(handles.gui_pipe_K2,'BackgroundColor',bkg);
set(handles.gui_text_K2,'String',str);

if strcmpi(get_param(fullname,'cboxK3'),'on')
    bkg = b;
    v   = 1;
    str = 'Open';
    f9_msg1 = 'Clogging in output pipe of the tank 3';
    f9_msg2 = 'Closing valve K3';
else
    bkg = w;
    v   = 0;
    str = 'Closed';
    f9_msg1 = 'Leakage in tank 3';
    f9_msg2 = 'Opening valve K3';
end
set(handles.gui_K3,'BackgroundColor',bkg,'Value',v)
set(handles.gui_pipe_K3,'BackgroundColor',bkg);
set(handles.gui_text_K3,'String',str);

% Sensor faults
f10_msg1 = 'Level sensor fault of the tank 1';
f10_msg2 = 'Change measurement of the level sensor h1';

f11_msg1 = 'Level sensor fault of the tank 2';
f11_msg2 = 'Change measurement of the level sensor h2';

f12_msg1 = 'Level sensor fault of the tank 3';
f12_msg2 = 'Change measurement of the level sensor h3';

f13_msg1 = 'Flow sensor fault u1 (input tank 1)';
f13_msg2 = 'Change measurement of the flow sensor u1';

f14_msg1 = 'Flow sensor fault u2 (input tank 2)';
f14_msg2 = 'Change measurement of the flow sensor u2';

f15_msg1 = 'Flow sensor fault Qa (flow in TP13)';
f15_msg2 = 'Change measurement of the flow sensor Qa';

f16_msg1 = 'Flow sensor fault Qb (flow in TP23)';
f16_msg2 = 'Change measurement of the flow sensor Qb';

f17_msg1 = 'Flow sensor fault Q13 (flow in CP13)';
f17_msg2 = 'Change measurement of the flow sensor Q13';

f18_msg1 = 'Flow sensor fault Q23 (flow in CP23)';
f18_msg2 = 'Change measurement of the flow sensor Q23';

f19_msg1 = 'Output flow sensor fault of the tank 1';
f19_msg2 = 'Change measurement of the flow sensor Q1';

f20_msg1 = 'Output flow sensor fault of the tank 2';
f20_msg2 = 'Change measurement of the flow sensor Q2';

f21_msg1 = 'Output flow sensor fault of the tank 3';
f21_msg2 = 'Change measurement of the flow sensor Q3';

data = {
    '       F1 ',f1_msg1,f1_msg2;...
    '       F2 ',f2_msg1,f2_msg2;...
    '       F3 ',f3_msg1,f3_msg2;...
    '       F4 ',f4_msg1,f4_msg2;...
    '       F5 ',f5_msg1,f5_msg2;...
    '       F6 ',f6_msg1,f6_msg2;...
    '       F7 ',f7_msg1,f7_msg2;...
    '       F8 ',f8_msg1,f8_msg2;...
    '       F9 ',f9_msg1,f9_msg2;...
    '       F10',f10_msg1,f10_msg2;...
    '       F11',f11_msg1,f11_msg2;...
    '       F12',f12_msg1,f12_msg2;...
    '       F13',f13_msg1,f13_msg2;...
    '       F14',f14_msg1,f14_msg2;...
    '       F15',f15_msg1,f15_msg2;...
    '       F16',f16_msg1,f16_msg2;...
    '       F17',f17_msg1,f17_msg2;...
    '       F18',f18_msg1,f18_msg2;...
    '       F19',f19_msg1,f19_msg2;...
    '       F20',f20_msg1,f20_msg2;...
    '       F21',f21_msg1,f21_msg2;...
    };

set(handles.tab_faults,'Data',data);

set(handles.btn_close_help,'BackgroundColor',get_color('open'));


function btn_close_help_Callback(~, ~, ~)

delete(findobj('Tag','sim_help_figure'));
