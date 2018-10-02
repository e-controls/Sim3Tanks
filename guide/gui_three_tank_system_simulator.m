function varargout = gui_three_tank_system_simulator(varargin)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @gui_three_tank_system_simulator_OpeningFcn, ...
    'gui_OutputFcn',  @gui_three_tank_system_simulator_OutputFcn, ...
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

% --- Executes just before gui_three_tank_system_simulator is made visible.
function gui_three_tank_system_simulator_OpeningFcn(hObject, ~, handles, varargin)

handles.output = hObject;

guidata(hObject, handles);

set(handles.main_figure,'Name','Sim3Tanks');
movegui('center');

[param,hi,pump1,pump2,noise,tsim,controlsys,fdisys,fault,dK,plots] = get_default_param();

%% Parameters (field1)
set(handles.edit_RR,'String',num2str(param(1)));
set(handles.edit_Hmax,'String',num2str(param(2)));
set(handles.edit_r,'String',num2str(param(3)));
set(handles.edit_h0,'String',num2str(param(4)));
set(handles.edit_mi,'String',num2str(param(5)));
set(handles.edit_g,'String',num2str(param(6)));

%% Initial conditions (field2)
set(handles.edit_hi1,'String',num2str(hi(1)));
set(handles.edit_hi2,'String',num2str(hi(2)));
set(handles.edit_hi3,'String',num2str(hi(3)));

%% Pump P1 (field3)
set(handles.edit_Qp1,'String',num2str(pump1(2)));
set(handles.edit_Qp1_ti,'String',num2str(pump1(3)));
set(handles.edit_Qp1_tf,'String',num2str(pump1(4)));

%% Pump P2 (field4)
set(handles.edit_Qp2,'String',num2str(pump2(2)));
set(handles.edit_Qp2_ti,'String',num2str(pump2(3)));
set(handles.edit_Qp2_tf,'String',num2str(pump2(4)));

%% White noise (field5)
set(handles.edit_w_mean,'String',num2str(noise(1)));
set(handles.edit_w_std,'String',num2str(noise(2)));
set(handles.edit_vlevel_mean,'String',num2str(noise(3)));
set(handles.edit_vlevel_std,'String',num2str(noise(4)));
set(handles.edit_vflow_mean,'String',num2str(noise(5)));
set(handles.edit_vflow_std,'String',num2str(noise(6)));

%% Simulation time (field6)
set(handles.edit_time,'String',num2str(tsim(2)));

str = 'Function name';
e = 'off';

%% Control system (field7)
set(handles.cbox_control_system,'Value',controlsys(1));
set(handles.edit_control_system,'String',str,'Enable',e);
set(handles.edit_setpoint,'String',num2str(controlsys(2)),'Enable',e);

%% FDI system (field8)
set(handles.cbox_fdi_system,'Value',fdisys(1));
set(handles.edit_fdi_system,'String',str,'Enable',e);
set(handles.edit_Ts,'String',num2str(fdisys(2)),'Enable',e);

%% Fault signals (field9)
fon = num2str(fault(1));

set(handles.pf1,'Title',strcat('F1=',fon));
set(handles.pf2,'Title',strcat('F2=',fon));
set(handles.pf3,'Title',strcat('F3=',fon));
set(handles.pf4,'Title',strcat('F4=',fon));
set(handles.pf5,'Title',strcat('F5=',fon));
set(handles.pf6,'Title',strcat('F6=',fon));
set(handles.pf7,'Title',strcat('F7=',fon));
set(handles.pf8,'Title',strcat('F8=',fon));
set(handles.pf9,'Title',strcat('F9=',fon));
set(handles.pf10,'Title',strcat('F10=',fon));
set(handles.pf11,'Title',strcat('F11=',fon));
set(handles.pf12,'Title',strcat('F12=',fon));
set(handles.pf13,'Title',strcat('F13=',fon));
set(handles.pf14,'Title',strcat('F14=',fon));
set(handles.pf15,'Title',strcat('F15=',fon));
set(handles.pf16,'Title',strcat('F16=',fon));
set(handles.pf17,'Title',strcat('F17=',fon));
set(handles.pf18,'Title',strcat('F18=',fon));
set(handles.pf19,'Title',strcat('F19=',fon));
set(handles.pf20,'Title',strcat('F20=',fon));
set(handles.pf21,'Title',strcat('F21=',fon));

bkg = get_color('normal');

set(handles.btn_f1,'BackgroundColor',bkg,'Value',fault(1));
set(handles.btn_f2,'BackgroundColor',bkg,'Value',fault(1));
set(handles.btn_f3,'BackgroundColor',bkg,'Value',fault(1));
set(handles.btn_f4,'BackgroundColor',bkg,'Value',fault(1));
set(handles.btn_f5,'BackgroundColor',bkg,'Value',fault(1));
set(handles.btn_f6,'BackgroundColor',bkg,'Value',fault(1));
set(handles.btn_f7,'BackgroundColor',bkg,'Value',fault(1));
set(handles.btn_f8,'BackgroundColor',bkg,'Value',fault(1));
set(handles.btn_f9,'BackgroundColor',bkg,'Value',fault(1));
set(handles.btn_f10,'BackgroundColor',bkg,'Value',fault(1));
set(handles.btn_f11,'BackgroundColor',bkg,'Value',fault(1));
set(handles.btn_f12,'BackgroundColor',bkg,'Value',fault(1));
set(handles.btn_f13,'BackgroundColor',bkg,'Value',fault(1));
set(handles.btn_f14,'BackgroundColor',bkg,'Value',fault(1));
set(handles.btn_f15,'BackgroundColor',bkg,'Value',fault(1));
set(handles.btn_f16,'BackgroundColor',bkg,'Value',fault(1));
set(handles.btn_f17,'BackgroundColor',bkg,'Value',fault(1));
set(handles.btn_f18,'BackgroundColor',bkg,'Value',fault(1));
set(handles.btn_f19,'BackgroundColor',bkg,'Value',fault(1));
set(handles.btn_f20,'BackgroundColor',bkg,'Value',fault(1));
set(handles.btn_f21,'BackgroundColor',bkg,'Value',fault(1));

str = 'Step | Drift';
bkg = get_color('step');

set(handles.btn_f1_type, 'String',str,'BackgroundColor',bkg,'Value',fault(2),'Enable',e);
set(handles.btn_f2_type, 'String',str,'BackgroundColor',bkg,'Value',fault(2),'Enable',e);
set(handles.btn_f3_type, 'String',str,'BackgroundColor',bkg,'Value',fault(2),'Enable',e);
set(handles.btn_f4_type, 'String',str,'BackgroundColor',bkg,'Value',fault(2),'Enable',e);
set(handles.btn_f5_type, 'String',str,'BackgroundColor',bkg,'Value',fault(2),'Enable',e);
set(handles.btn_f6_type, 'String',str,'BackgroundColor',bkg,'Value',fault(2),'Enable',e);
set(handles.btn_f7_type, 'String',str,'BackgroundColor',bkg,'Value',fault(2),'Enable',e);
set(handles.btn_f8_type, 'String',str,'BackgroundColor',bkg,'Value',fault(2),'Enable',e);
set(handles.btn_f9_type, 'String',str,'BackgroundColor',bkg,'Value',fault(2),'Enable',e);
set(handles.btn_f10_type,'String',str,'BackgroundColor',bkg,'Value',fault(2),'Enable',e);
set(handles.btn_f11_type,'String',str,'BackgroundColor',bkg,'Value',fault(2),'Enable',e);
set(handles.btn_f12_type,'String',str,'BackgroundColor',bkg,'Value',fault(2),'Enable',e);
set(handles.btn_f13_type,'String',str,'BackgroundColor',bkg,'Value',fault(2),'Enable',e);
set(handles.btn_f14_type,'String',str,'BackgroundColor',bkg,'Value',fault(2),'Enable',e);
set(handles.btn_f15_type,'String',str,'BackgroundColor',bkg,'Value',fault(2),'Enable',e);
set(handles.btn_f16_type,'String',str,'BackgroundColor',bkg,'Value',fault(2),'Enable',e);
set(handles.btn_f17_type,'String',str,'BackgroundColor',bkg,'Value',fault(2),'Enable',e);
set(handles.btn_f18_type,'String',str,'BackgroundColor',bkg,'Value',fault(2),'Enable',e);
set(handles.btn_f19_type,'String',str,'BackgroundColor',bkg,'Value',fault(2),'Enable',e);
set(handles.btn_f20_type,'String',str,'BackgroundColor',bkg,'Value',fault(2),'Enable',e);
set(handles.btn_f21_type,'String',str,'BackgroundColor',bkg,'Value',fault(2),'Enable',e);

fault_ti = num2str(fault(3));

set(handles.edit_f1_ti, 'String',fault_ti,'Enable',e);
set(handles.edit_f2_ti, 'String',fault_ti,'Enable',e);
set(handles.edit_f3_ti, 'String',fault_ti,'Enable',e);
set(handles.edit_f4_ti, 'String',fault_ti,'Enable',e);
set(handles.edit_f5_ti, 'String',fault_ti,'Enable',e);
set(handles.edit_f6_ti, 'String',fault_ti,'Enable',e);
set(handles.edit_f7_ti, 'String',fault_ti,'Enable',e);
set(handles.edit_f8_ti, 'String',fault_ti,'Enable',e);
set(handles.edit_f9_ti, 'String',fault_ti,'Enable',e);
set(handles.edit_f10_ti,'String',fault_ti,'Enable',e);
set(handles.edit_f11_ti,'String',fault_ti,'Enable',e);
set(handles.edit_f12_ti,'String',fault_ti,'Enable',e);
set(handles.edit_f13_ti,'String',fault_ti,'Enable',e);
set(handles.edit_f14_ti,'String',fault_ti,'Enable',e);
set(handles.edit_f15_ti,'String',fault_ti,'Enable',e);
set(handles.edit_f16_ti,'String',fault_ti,'Enable',e);
set(handles.edit_f17_ti,'String',fault_ti,'Enable',e);
set(handles.edit_f18_ti,'String',fault_ti,'Enable',e);
set(handles.edit_f19_ti,'String',fault_ti,'Enable',e);
set(handles.edit_f20_ti,'String',fault_ti,'Enable',e);
set(handles.edit_f21_ti,'String',fault_ti,'Enable',e);

fault_tf = num2str(fault(4));

set(handles.edit_f1_tf, 'String',fault_tf,'Enable',e);
set(handles.edit_f2_tf, 'String',fault_tf,'Enable',e);
set(handles.edit_f3_tf, 'String',fault_tf,'Enable',e);
set(handles.edit_f4_tf, 'String',fault_tf,'Enable',e);
set(handles.edit_f5_tf, 'String',fault_tf,'Enable',e);
set(handles.edit_f6_tf, 'String',fault_tf,'Enable',e);
set(handles.edit_f7_tf, 'String',fault_tf,'Enable',e);
set(handles.edit_f8_tf, 'String',fault_tf,'Enable',e);
set(handles.edit_f9_tf, 'String',fault_tf,'Enable',e);
set(handles.edit_f10_tf,'String',fault_tf,'Enable',e);
set(handles.edit_f11_tf,'String',fault_tf,'Enable',e);
set(handles.edit_f12_tf,'String',fault_tf,'Enable',e);
set(handles.edit_f13_tf,'String',fault_tf,'Enable',e);
set(handles.edit_f14_tf,'String',fault_tf,'Enable',e);
set(handles.edit_f15_tf,'String',fault_tf,'Enable',e);
set(handles.edit_f16_tf,'String',fault_tf,'Enable',e);
set(handles.edit_f17_tf,'String',fault_tf,'Enable',e);
set(handles.edit_f18_tf,'String',fault_tf,'Enable',e);
set(handles.edit_f19_tf,'String',fault_tf,'Enable',e);
set(handles.edit_f20_tf,'String',fault_tf,'Enable',e);
set(handles.edit_f21_tf,'String',fault_tf,'Enable',e);

%% Operation mode (field10)
if dK(1)
    str = 'Kp1: OPEN';
    bkg = get_color('open');
else
    str = 'Kp1: CLOSED';
    bkg = get_color('closed');
end

set(handles.btn_dKp1,'String',str,'BackgroundColor',bkg,'Value',1-dK(1));

if dK(2)
    str = 'Kp2: OPEN';
    bkg = get_color('open');
else
    str = 'Kp2: CLOSED';
    bkg = get_color('closed');
end

set(handles.btn_dKp2,'String',str,'BackgroundColor',bkg,'Value',1-dK(2));

if dK(3)
    str = 'Ka: OPEN';
    bkg = get_color('open');
else
    str = 'Ka: CLOSED';
    bkg = get_color('closed');
end

set(handles.btn_dKa,'String',str,'BackgroundColor',bkg,'Value',1-dK(3));

if dK(4)
    str = 'Kb: OPEN';
    bkg = get_color('open');
else
    str = 'Kb: CLOSED';
    bkg = get_color('closed');
end

set(handles.btn_dKb,'String',str,'BackgroundColor',bkg,'Value',1-dK(4));

if dK(5)
    str = 'K13: OPEN';
    bkg = get_color('open');
else
    str = 'K13: CLOSED';
    bkg = get_color('closed');
end

set(handles.btn_dK13,'String',str,'BackgroundColor',bkg,'Value',1-dK(5));

if dK(6)
    str = 'K23: OPEN';
    bkg = get_color('open');
else
    str = 'K23: CLOSED';
    bkg = get_color('closed');
end

set(handles.btn_dK23,'String',str,'BackgroundColor',bkg,'Value',1-dK(6));

if dK(7)
    str = 'K1: OPEN';
    bkg = get_color('open');
else
    str = 'K1: CLOSED';
    bkg = get_color('closed');
end

set(handles.btn_dK1,'String',str,'BackgroundColor',bkg,'Value',1-dK(7));

if dK(8)
    str = 'K2: OPEN';
    bkg = get_color('open');
else
    str = 'K2: CLOSED';
    bkg = get_color('closed');
end

set(handles.btn_dK2,'String',str,'BackgroundColor',bkg,'Value',1-dK(8));

if dK(9)
    str = 'K3: OPEN';
    bkg = get_color('open');
else
    str = 'K3: CLOSED';
    bkg = get_color('closed');
end

set(handles.btn_dK3,'String',str,'BackgroundColor',bkg,'Value',1-dK(9));

%% Plots (field11)
set(handles.popup_levels,'Value',plots(1));
set(handles.popup_flows, 'Value',plots(2));
set(handles.popup_valves,'Value',plots(3));
set(handles.popup_faults,'Value',plots(4));

bkg = get_color('open');

set(handles.btn_plot_levels,'BackgroundColor',bkg,'Enable',e);
set(handles.btn_plot_flows, 'BackgroundColor',bkg,'Enable',e);
set(handles.btn_plot_valves,'BackgroundColor',bkg,'Enable',e);
set(handles.btn_plot_faults,'BackgroundColor',bkg,'Enable',e);

set(handles.cbox_levels,'Value',plots(5));
set(handles.cbox_flows, 'Value',plots(6));
set(handles.cbox_valves,'Value',plots(7));
set(handles.cbox_faults,'Value',plots(8));

%% Axes
axes(handles.axes1);
hold off;
plot(0,0);
xlabel('time','Fontsize',8);
ylabel('magnitude','Fontsize',8);

%% Run, Reset, Help and Exit
bkg = get_color('open');
set(handles.btn_run_simulation,'BackgroundColor',bkg);
set(handles.btn_reset,'BackgroundColor',bkg);
set(handles.btn_help,'BackgroundColor',bkg);
set(handles.btn_exit,'BackgroundColor',bkg);

% --- Outputs from this function are returned to the command line.
function varargout = gui_three_tank_system_simulator_OutputFcn(~, ~, handles)

varargout{1} = handles.output;



%% Parameters *************************************************************

function edit_RR_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_Hmax_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_r_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_h0_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_mi_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_g_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%% Initial conditions *****************************************************

function edit_hi1_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_hi2_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_hi3_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%% Simulation time ********************************************************

function edit_time_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%% Pump P1 ****************************************************************

function edit_Qp1_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_Qp1_ti_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_Qp1_tf_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%% Pump P2 ****************************************************************

function edit_Qp2_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_Qp2_ti_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_Qp2_tf_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%% White noise ************************************************************

function edit_w_mean_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_w_std_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_vlevel_mean_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_vlevel_std_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_vflow_mean_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_vflow_std_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%% Control system *********************************************************

function cbox_control_system_Callback(hObject, ~, handles)

cbox_state = get(hObject,'Value');

if cbox_state == get(hObject,'Max')
    
    pump1 = get_default_param('field3');
    pump2 = get_default_param('field4');
    
    set(handles.edit_control_system,'String','flow_controller','Enable','on');
    set(handles.edit_setpoint,'String','120','Enable','on');
    set(handles.edit_Ts,'Enable','on');
    set(handles.edit_Qp1,'String',pump1(1));
    set(handles.edit_Qp2,'String',pump2(1));
    set(handles.edit_hi1,'String','0');
    set(handles.edit_hi2,'String','0');
    set(handles.edit_hi3,'String','0');
    
elseif cbox_state == get(hObject,'Min')
    
    hi         = get_default_param('field2');
    pump1      = get_default_param('field3');
    pump2      = get_default_param('field4');
    noise      = get_default_param('field5');
    controlsys = get_default_param('field7');
    fdisys     = get_default_param('field8');
    
    set(handles.edit_control_system,'String','Function name','Enable','off');
    set(handles.edit_Qp1,'String',num2str(pump1(2)));
    set(handles.edit_Qp2,'String',num2str(pump2(2)));
    set(handles.edit_hi1,'String',num2str(hi(1)));
    set(handles.edit_hi2,'String',num2str(hi(2)));
    set(handles.edit_hi3,'String',num2str(hi(3)));
    set(handles.edit_w_mean,'String',num2str(noise(1)));
    set(handles.edit_w_std,'String',num2str(noise(2)));
    set(handles.edit_vlevel_mean,'String',num2str(noise(3)));
    set(handles.edit_vlevel_std,'String',num2str(noise(4)));
    set(handles.edit_vflow_mean,'String',num2str(noise(5)));
    set(handles.edit_vflow_std,'String',num2str(noise(6)));
    set(handles.edit_setpoint,'String',num2str(controlsys(2)),'Enable','off');
    
    if get(handles.cbox_fdi_system,'Value') == get(hObject,'Min')
        set(handles.edit_Ts,'String',num2str(fdisys(2)),'Enable','off');
    end
    
end

function edit_control_system_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_setpoint_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%% FDI system *************************************************************

function cbox_fdi_system_Callback(hObject, ~, handles)

cbox_state = get(hObject,'Value');

if cbox_state == get(hObject,'Max')
    set(handles.edit_fdi_system,'String','fdi_system','Enable','on');
    set(handles.edit_Ts,'Enable','on');
    
elseif cbox_state == get(hObject,'Min')
    
    set(handles.edit_fdi_system,'String','Function name','Enable','off');
    if get(handles.cbox_control_system,'Value') == get(hObject,'Min')
        fdisys = get_default_param('field8');
        set(handles.edit_Ts,'String',num2str(fdisys(2)),'Enable','off');
    end
    
end

function edit_fdi_system_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_Ts_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%% Operation mode *******************************************************

function btn_dKp1_Callback(hObject, ~, handles)

button_state = get(hObject,'Value');

if button_state == get(hObject,'Max')
    str   = 'Kp1: CLOSED';
    c     = get_color('closed');
    ftip  = 'F1: Disturbance in tank 1 (Valve Kp1)';
else
    str = 'Kp1: OPEN';
    c   = get_color('open');
    ftip  = 'F1: Actuator fault 1 (Valve Kp1)';
end

set(hObject,'String',str,'BackgroundColor',c);
set(handles.btn_f1,'TooltipString',ftip);

function btn_dKp2_Callback(hObject, ~, handles)

button_state = get(hObject,'Value');

if button_state == get(hObject,'Max')
    str = 'Kp2: CLOSED';
    c   = get_color('closed');
    ftip  = 'F2: Disturbance in tank 2 (Valve Kp2)';
else
    str = 'Kp2: OPEN';
    c   = get_color('open');
    ftip  = 'F2: Actuator fault 2 (Valve Kp2)';
end

set(hObject,'String',str,'BackgroundColor',c);
set(handles.btn_f2,'TooltipString',ftip);

function btn_dKa_Callback(hObject, ~, handles)

button_state = get(hObject,'Value');

if button_state == get(hObject,'Max')
    str = 'Ka: CLOSED';
    c   = get_color('closed');
    ftip  = 'F3: Leakage through the transmission pipe from tank 1 to tank 3 (Valve Ka)';
else
    str = 'Ka: OPEN';
    c   = get_color('open');
    ftip = 'F3: Clogging in the transmission pipe from tank 1 to tank 3 (Valve Ka)';
end

set(hObject,'String',str,'BackgroundColor',c);
set(handles.btn_f3,'TooltipString',ftip);

function btn_dKb_Callback(hObject, ~, handles)

button_state = get(hObject,'Value');

if button_state == get(hObject,'Max')
    str = 'Kb: CLOSED';
    c   = get_color('closed');
    ftip  = 'F4: Leakage through the transmission pipe from tank 2 to tank 3 (Valve Kb)';
else
    str = 'Kb: OPEN';
    c   = get_color('open');
    ftip = 'F4: Clogging in the transmission pipe from tank 2 to tank 3 (Valve Kb)';
end

set(hObject,'String',str,'BackgroundColor',c);
set(handles.btn_f4,'TooltipString',ftip);

function btn_dK13_Callback(hObject, ~, handles)

button_state = get(hObject,'Value');

if button_state == get(hObject,'Max')
    str = 'K13: CLOSED';
    c   = get_color('closed');
    ftip  = 'F5: Leakage through the connection pipe from tank 1 to tank 3 (Valve K13)';
else
    str = 'K13: OPEN';
    c   = get_color('open');
    ftip = 'F5: Clogging in the connection pipe from tank 1 to tank 3 (Valve K13)';
end

set(hObject,'String',str,'BackgroundColor',c);
set(handles.btn_f5,'TooltipString',ftip);

function btn_dK23_Callback(hObject, ~, handles)

button_state = get(hObject,'Value');

if button_state == get(hObject,'Max')
    str = 'K23: CLOSED';
    c   = get_color('closed');
    ftip  = 'F6: Leakage through the connection pipe from tank 2 to tank 3 (Valve K23)';
else
    str = 'K23: OPEN';
    c   = get_color('open');
    ftip = 'F6: Clogging in the connection pipe from tank 2 to tank 3 (Valve K23)';
end

set(hObject,'String',str,'BackgroundColor',c);
set(handles.btn_f6,'TooltipString',ftip);

function btn_dK1_Callback(hObject, ~, handles)

button_state = get(hObject,'Value');

if button_state == get(hObject,'Max')
    str = 'K1: CLOSED';
    c   = get_color('closed');
    ftip  = 'F7: Leakage in tank 1 (Valve K1)';
else
    str = 'K1: OPEN';
    c   = get_color('open');
    ftip = 'F7: Clogging in output pipe of the tank 1 (Valve K1)';
end

set(hObject,'String',str,'BackgroundColor',c);
set(handles.btn_f7,'TooltipString',ftip);

function btn_dK2_Callback(hObject, ~, handles)

button_state = get(hObject,'Value');

if button_state == get(hObject,'Max')
    str = 'K2: CLOSED';
    c   = get_color('closed');
    ftip  = 'F8: Leakage in tank 2 (Valve K2)';
else
    str = 'K2: OPEN';
    c   = get_color('open');
    ftip = 'F8: Clogging in output pipe of the tank 2 (Valve K2)';
end

set(hObject,'String',str,'BackgroundColor',c);
set(handles.btn_f8,'TooltipString',ftip);

function btn_dK3_Callback(hObject, ~, handles)

button_state = get(hObject,'Value');

if button_state == get(hObject,'Max')
    str = 'K3: CLOSED';
    c   = get_color('closed');
    ftip  = 'F9: Leakage in tank 3 (Valve K3)';
else
    str = 'K3: OPEN';
    c   = get_color('open');
    ftip = 'F9: Clogging in output pipe of the tank 3 (Valve K3)';
end

set(hObject,'String',str,'BackgroundColor',c);
set(handles.btn_f9,'TooltipString',ftip);



%% Fault signals **********************************************************

function btn_f1_Callback(hObject, ~, handles)

value = get(hObject,'Value');

set(handles.pf1,'Title',strcat('F1=',num2str(value)));

if value ~= 0
    set(handles.btn_f1,'BackgroundColor',get_color('fault'));
    if strcmp(get(handles.btn_f1_type,'Enable'),'off')
        set(handles.btn_f1_type,'String','Stepwise','Enable','on');
    end
    set(handles.edit_f1_ti,'Enable','on');
    set(handles.edit_f1_tf,'Enable','on');
else
    set(handles.btn_f1,'BackgroundColor',get_color('normal'));
    set(handles.btn_f1_type,'String','Step | Drift','BackgroundColor',get_color('step'),'Value',0,'Enable','off');
    set(handles.edit_f1_ti,'Enable','off');
    set(handles.edit_f1_tf,'Enable','off');
end

function btn_f1_type_Callback(hObject, ~, ~)

button_state = get(hObject,'Value');

if button_state == get(hObject,'Max')
    str = 'Driftwise';
    c   = get_color('drift');
else
    str = 'Stepwise';
    c   = get_color('step');
end

set(hObject,'String',str,'BackgroundColor',c);

function edit_f1_ti_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_f1_tf_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% f2 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

function btn_f2_Callback(hObject, ~, handles)

value = get(hObject,'Value');

set(handles.pf2,'Title',strcat('F2=',num2str(value)));

if value ~= 0
    set(handles.btn_f2,'BackgroundColor',get_color('fault'));
    if strcmp(get(handles.btn_f2_type,'Enable'),'off')
        set(handles.btn_f2_type,'String','Stepwise','Enable','on');
    end
    set(handles.edit_f2_ti,'Enable','on');
    set(handles.edit_f2_tf,'Enable','on');
else
    set(handles.btn_f2,'BackgroundColor',get_color('normal'));
    set(handles.btn_f2_type,'String','Step | Drift','BackgroundColor',get_color('step'),'Value',0,'Enable','off');
    set(handles.edit_f2_ti,'Enable','off');
    set(handles.edit_f2_tf,'Enable','off');
end

function btn_f2_type_Callback(hObject, ~, ~)

button_state = get(hObject,'Value');

if button_state == get(hObject,'Max')
    str = 'Driftwise';
    c   = get_color('drift');
else
    str = 'Stepwise';
    c   = get_color('step');
end

set(hObject,'String',str,'BackgroundColor',c);

function edit_f2_tf_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_f2_ti_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% f3 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

function btn_f3_Callback(hObject, ~, handles)

value = get(hObject,'Value');

set(handles.pf3,'Title',strcat('F3=',num2str(value)));

if value ~= 0
    set(handles.btn_f3,'BackgroundColor',get_color('fault'));
    if strcmp(get(handles.btn_f3_type,'Enable'),'off')
        set(handles.btn_f3_type,'String','Stepwise','Enable','on');
    end
    set(handles.edit_f3_ti,'Enable','on');
    set(handles.edit_f3_tf,'Enable','on');
else
    set(handles.btn_f3,'BackgroundColor',get_color('normal'));
    set(handles.btn_f3_type,'String','Step | Drift','BackgroundColor',get_color('step'),'Value',0,'Enable','off');
    set(handles.edit_f3_ti,'Enable','off');
    set(handles.edit_f3_tf,'Enable','off');
end

function btn_f3_type_Callback(hObject, ~, ~)

button_state = get(hObject,'Value');

if button_state == get(hObject,'Max')
    str = 'Driftwise';
    c   = get_color('drift');
else
    str = 'Stepwise';
    c   = get_color('step');
end

set(hObject,'String',str,'BackgroundColor',c);

function edit_f3_ti_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_f3_tf_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% f4 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

function btn_f4_Callback(hObject, ~, handles)

value = get(hObject,'Value');

set(handles.pf4,'Title',strcat('F4=',num2str(value)));

if value ~= 0
    set(handles.btn_f4,'BackgroundColor',get_color('fault'));
    if strcmp(get(handles.btn_f4_type,'Enable'),'off')
        set(handles.btn_f4_type,'String','Stepwise','Enable','on');
    end
    set(handles.edit_f4_ti,'Enable','on');
    set(handles.edit_f4_tf,'Enable','on');
else
    set(handles.btn_f4,'BackgroundColor',get_color('normal'));
    set(handles.btn_f4_type,'String','Step | Drift','BackgroundColor',get_color('step'),'Value',0,'Enable','off');
    set(handles.edit_f4_ti,'Enable','off');
    set(handles.edit_f4_tf,'Enable','off');
end

function btn_f4_type_Callback(hObject, ~, ~)

button_state = get(hObject,'Value');

if button_state == get(hObject,'Max')
    str = 'Driftwise';
    c   = get_color('drift');
else
    str = 'Stepwise';
    c   = get_color('step');
end

set(hObject,'String',str,'BackgroundColor',c);

function edit_f4_ti_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_f4_tf_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% f5 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

function btn_f5_Callback(hObject, ~, handles)

value = get(hObject,'Value');

set(handles.pf5,'Title',strcat('F5=',num2str(value)));

if value ~= 0
    set(handles.btn_f5,'BackgroundColor',get_color('fault'));
    if strcmp(get(handles.btn_f5_type,'Enable'),'off')
        set(handles.btn_f5_type,'String','Stepwise','Enable','on');
    end
    set(handles.edit_f5_ti,'Enable','on');
    set(handles.edit_f5_tf,'Enable','on');
else
    set(handles.btn_f5,'BackgroundColor',get_color('normal'));
    set(handles.btn_f5_type,'String','Step | Drift','BackgroundColor',get_color('step'),'Value',0,'Enable','off');
    set(handles.edit_f5_ti,'Enable','off');
    set(handles.edit_f5_tf,'Enable','off');
end

function btn_f5_type_Callback(hObject, ~, ~)

button_state = get(hObject,'Value');

if button_state == get(hObject,'Max')
    str = 'Driftwise';
    c   = get_color('drift');
else
    str = 'Stepwise';
    c   = get_color('step');
end

set(hObject,'String',str,'BackgroundColor',c);

function edit_f5_ti_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_f5_tf_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% f6 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

function btn_f6_Callback(hObject, ~, handles)

value = get(hObject,'Value');

set(handles.pf6,'Title',strcat('F6=',num2str(value)));

if value ~= 0
    set(handles.btn_f6,'BackgroundColor',get_color('fault'));
    if strcmp(get(handles.btn_f6_type,'Enable'),'off')
        set(handles.btn_f6_type,'String','Stepwise','Enable','on');
    end
    set(handles.edit_f6_ti,'Enable','on');
    set(handles.edit_f6_tf,'Enable','on');
else
    set(handles.btn_f6,'BackgroundColor',get_color('normal'));
    set(handles.btn_f6_type,'String','Step | Drift','BackgroundColor',get_color('step'),'Value',0,'Enable','off');
    set(handles.edit_f6_ti,'Enable','off');
    set(handles.edit_f6_tf,'Enable','off');
end

function btn_f6_type_Callback(hObject, ~, ~)

button_state = get(hObject,'Value');

if button_state == get(hObject,'Max')
    str = 'Driftwise';
    c   = get_color('drift');
else
    str = 'Stepwise';
    c   = get_color('step');
end

set(hObject,'String',str,'BackgroundColor',c);

function edit_f6_ti_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_f6_tf_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% f7 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

function btn_f7_Callback(hObject, ~, handles)

value = get(hObject,'Value');

set(handles.pf7,'Title',strcat('F7=',num2str(value)));

if value ~= 0
    set(handles.btn_f7,'BackgroundColor',get_color('fault'));
    if strcmp(get(handles.btn_f7_type,'Enable'),'off')
        set(handles.btn_f7_type,'String','Stepwise','Enable','on');
    end
    set(handles.edit_f7_ti,'Enable','on');
    set(handles.edit_f7_tf,'Enable','on');
else
    set(handles.btn_f7,'BackgroundColor',get_color('normal'));
    set(handles.btn_f7_type,'String','Step | Drift','BackgroundColor',get_color('step'),'Value',0,'Enable','off');
    set(handles.edit_f7_ti,'Enable','off');
    set(handles.edit_f7_tf,'Enable','off');
end

function btn_f7_type_Callback(hObject, ~, ~)

button_state = get(hObject,'Value');

if button_state == get(hObject,'Max')
    str = 'Driftwise';
    c   = get_color('drift');
else
    str = 'Stepwise';
    c   = get_color('step');
end

set(hObject,'String',str,'BackgroundColor',c);

function edit_f7_ti_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_f7_tf_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% f8 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

function btn_f8_Callback(hObject, ~, handles)

value = get(hObject,'Value');

set(handles.pf8,'Title',strcat('F8=',num2str(value)));

if value ~= 0
    set(handles.btn_f8,'BackgroundColor',get_color('fault'));
    if strcmp(get(handles.btn_f8_type,'Enable'),'off')
        set(handles.btn_f8_type,'String','Stepwise','Enable','on');
    end
    set(handles.edit_f8_ti,'Enable','on');
    set(handles.edit_f8_tf,'Enable','on');
else
    set(handles.btn_f8,'BackgroundColor',get_color('normal'));
    set(handles.btn_f8_type,'String','Step | Drift','BackgroundColor',get_color('step'),'Value',0,'Enable','off');
    set(handles.edit_f8_ti,'Enable','off');
    set(handles.edit_f8_tf,'Enable','off');
end

function btn_f8_type_Callback(hObject, ~, ~)

button_state = get(hObject,'Value');

if button_state == get(hObject,'Max')
    str = 'Driftwise';
    c   = get_color('drift');
else
    str = 'Stepwise';
    c   = get_color('step');
end

set(hObject,'String',str,'BackgroundColor',c);

function edit_f8_ti_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_f8_tf_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% f9 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

function btn_f9_Callback(hObject, ~, handles)

value = get(hObject,'Value');

set(handles.pf9,'Title',strcat('F9=',num2str(value)));

if value ~= 0
    set(handles.btn_f9,'BackgroundColor',get_color('fault'));
    if strcmp(get(handles.btn_f9_type,'Enable'),'off')
        set(handles.btn_f9_type,'String','Stepwise','Enable','on');
    end
    set(handles.edit_f9_ti,'Enable','on');
    set(handles.edit_f9_tf,'Enable','on');
else
    set(handles.btn_f9,'BackgroundColor',get_color('normal'));
    set(handles.btn_f9_type,'String','Step | Drift','BackgroundColor',get_color('step'),'Value',0,'Enable','off');
    set(handles.edit_f9_ti,'Enable','off');
    set(handles.edit_f9_tf,'Enable','off');
end

function btn_f9_type_Callback(hObject, ~, ~)

button_state = get(hObject,'Value');

if button_state == get(hObject,'Max')
    str = 'Driftwise';
    c   = get_color('drift');
else
    str = 'Stepwise';
    c   = get_color('step');
end

set(hObject,'String',str,'BackgroundColor',c);

function edit_f9_ti_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_f9_tf_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% f10 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

function btn_f10_Callback(hObject, ~, handles)

value = get(hObject,'Value');

set(handles.pf10,'Title',strcat('F10=',num2str(value)));

if value ~= 0
    set(handles.btn_f10,'BackgroundColor',get_color('fault'));
    if strcmp(get(handles.btn_f10_type,'Enable'),'off')
        set(handles.btn_f10_type,'String','Stepwise','Enable','on');
    end
    set(handles.edit_f10_ti,'Enable','on');
    set(handles.edit_f10_tf,'Enable','on');
else
    set(handles.btn_f10,'BackgroundColor',get_color('normal'));
    set(handles.btn_f10_type,'String','Step | Drift','BackgroundColor',get_color('step'),'Value',0,'Enable','off');
    set(handles.edit_f10_ti,'Enable','off');
    set(handles.edit_f10_tf,'Enable','off');
end

function btn_f10_type_Callback(hObject, ~, ~)

button_state = get(hObject,'Value');

if button_state == get(hObject,'Max')
    str = 'Driftwise';
    c   = get_color('drift');
else
    str = 'Stepwise';
    c   = get_color('step');
end

set(hObject,'String',str,'BackgroundColor',c);

function edit_f10_ti_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_f10_tf_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% f11 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

function btn_f11_Callback(hObject, ~, handles)

value = get(hObject,'Value');

set(handles.pf11,'Title',strcat('F11=',num2str(value)));

if value ~= 0
    set(handles.btn_f11,'BackgroundColor',get_color('fault'));
    if strcmp(get(handles.btn_f11_type,'Enable'),'off')
        set(handles.btn_f11_type,'String','Stepwise','Enable','on');
    end
    set(handles.edit_f11_ti,'Enable','on');
    set(handles.edit_f11_tf,'Enable','on');
else
    set(handles.btn_f11,'BackgroundColor',get_color('normal'));
    set(handles.btn_f11_type,'String','Step | Drift','BackgroundColor',get_color('step'),'Value',0,'Enable','off');
    set(handles.edit_f11_ti,'Enable','off');
    set(handles.edit_f11_tf,'Enable','off');
end

function btn_f11_type_Callback(hObject, ~, ~)

button_state = get(hObject,'Value');

if button_state == get(hObject,'Max')
    str = 'Driftwise';
    c   = get_color('drift');
else
    str = 'Stepwise';
    c   = get_color('step');
end

set(hObject,'String',str,'BackgroundColor',c);

function edit_f11_ti_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_f11_tf_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% f12 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

function btn_f12_Callback(hObject, ~, handles)

value = get(hObject,'Value');

set(handles.pf12,'Title',strcat('F12=',num2str(value)));

if value ~= 0
    set(handles.btn_f12,'BackgroundColor',get_color('fault'));
    if strcmp(get(handles.btn_f12_type,'Enable'),'off')
        set(handles.btn_f12_type,'String','Stepwise','Enable','on');
    end
    set(handles.edit_f12_ti,'Enable','on');
    set(handles.edit_f12_tf,'Enable','on');
else
    set(handles.btn_f12,'BackgroundColor',get_color('normal'));
    set(handles.btn_f12_type,'String','Step | Drift','BackgroundColor',get_color('step'),'Value',0,'Enable','off');
    set(handles.edit_f12_ti,'Enable','off');
    set(handles.edit_f12_tf,'Enable','off');
end

function btn_f12_type_Callback(hObject, ~, ~)

button_state = get(hObject,'Value');

if button_state == get(hObject,'Max')
    str = 'Driftwise';
    c   = get_color('drift');
else
    str = 'Stepwise';
    c   = get_color('step');
end

set(hObject,'String',str,'BackgroundColor',c);

function edit_f12_tf_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_f12_ti_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% f13 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

function btn_f13_Callback(hObject, ~, handles)

value = get(hObject,'Value');

set(handles.pf13,'Title',strcat('F13=',num2str(value)));

if value ~= 0
    set(handles.btn_f13,'BackgroundColor',get_color('fault'));
    if strcmp(get(handles.btn_f13_type,'Enable'),'off')
        set(handles.btn_f13_type,'String','Stepwise','Enable','on');
    end
    set(handles.edit_f13_ti,'Enable','on');
    set(handles.edit_f13_tf,'Enable','on');
else
    set(handles.btn_f13,'BackgroundColor',get_color('normal'));
    set(handles.btn_f13_type,'String','Step | Drift','BackgroundColor',get_color('step'),'Value',0,'Enable','off');
    set(handles.edit_f13_ti,'Enable','off');
    set(handles.edit_f13_tf,'Enable','off');
end

function btn_f13_type_Callback(hObject, ~, ~)

button_state = get(hObject,'Value');

if button_state == get(hObject,'Max')
    str = 'Driftwise';
    c   = get_color('drift');
else
    str = 'Stepwise';
    c   = get_color('step');
end

set(hObject,'String',str,'BackgroundColor',c);

function edit_f13_ti_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_f13_tf_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% f14 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

function btn_f14_Callback(hObject, ~, handles)

value = get(hObject,'Value');

set(handles.pf14,'Title',strcat('F14=',num2str(value)));

if value ~= 0
    set(handles.btn_f14,'BackgroundColor',get_color('fault'));
    if strcmp(get(handles.btn_f14_type,'Enable'),'off')
        set(handles.btn_f14_type,'String','Stepwise','Enable','on');
    end
    set(handles.edit_f14_ti,'Enable','on');
    set(handles.edit_f14_tf,'Enable','on');
else
    set(handles.btn_f14,'BackgroundColor',get_color('normal'));
    set(handles.btn_f14_type,'String','Step | Drift','BackgroundColor',get_color('step'),'Value',0,'Enable','off');
    set(handles.edit_f14_ti,'Enable','off');
    set(handles.edit_f14_tf,'Enable','off');
end

function btn_f14_type_Callback(hObject, ~, ~)

button_state = get(hObject,'Value');

if button_state == get(hObject,'Max')
    str = 'Driftwise';
    c   = get_color('drift');
else
    str = 'Stepwise';
    c   = get_color('step');
end

set(hObject,'String',str,'BackgroundColor',c);

function edit_f14_ti_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_f14_tf_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% f15 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

function btn_f15_Callback(hObject, ~, handles)

value = get(hObject,'Value');

set(handles.pf15,'Title',strcat('F15=',num2str(value)));

if value ~= 0
    set(handles.btn_f15,'BackgroundColor',get_color('fault'));
    if strcmp(get(handles.btn_f15_type,'Enable'),'off')
        set(handles.btn_f15_type,'String','Stepwise','Enable','on');
    end
    set(handles.edit_f15_ti,'Enable','on');
    set(handles.edit_f15_tf,'Enable','on');
else
    set(handles.btn_f15,'BackgroundColor',get_color('normal'));
    set(handles.btn_f15_type,'String','Step | Drift','BackgroundColor',get_color('step'),'Value',0,'Enable','off');
    set(handles.edit_f15_ti,'Enable','off');
    set(handles.edit_f15_tf,'Enable','off');
end

function btn_f15_type_Callback(hObject, ~, ~)

button_state = get(hObject,'Value');

if button_state == get(hObject,'Max')
    str = 'Driftwise';
    c   = get_color('drift');
else
    str = 'Stepwise';
    c   = get_color('step');
end

set(hObject,'String',str,'BackgroundColor',c);

function edit_f15_ti_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_f15_tf_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% f16 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

function btn_f16_Callback(hObject, ~, handles)

value = get(hObject,'Value');

set(handles.pf16,'Title',strcat('F16=',num2str(value)));

if value ~= 0
    set(handles.btn_f16,'BackgroundColor',get_color('fault'));
    if strcmp(get(handles.btn_f16_type,'Enable'),'off')
        set(handles.btn_f16_type,'String','Stepwise','Enable','on');
    end
    set(handles.edit_f16_ti,'Enable','on');
    set(handles.edit_f16_tf,'Enable','on');
else
    set(handles.btn_f16,'BackgroundColor',get_color('normal'));
    set(handles.btn_f16_type,'String','Step | Drift','BackgroundColor',get_color('step'),'Value',0,'Enable','off');
    set(handles.edit_f16_ti,'Enable','off');
    set(handles.edit_f16_tf,'Enable','off');
end

function btn_f16_type_Callback(hObject, ~, ~)

button_state = get(hObject,'Value');

if button_state == get(hObject,'Max')
    str = 'Driftwise';
    c   = get_color('drift');
else
    str = 'Stepwise';
    c   = get_color('step');
end

set(hObject,'String',str,'BackgroundColor',c);

function edit_f16_ti_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_f16_tf_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% f17 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

function btn_f17_Callback(hObject, ~, handles)

value = get(hObject,'Value');

set(handles.pf17,'Title',strcat('F17=',num2str(value)));

if value ~= 0
    set(handles.btn_f17,'BackgroundColor',get_color('fault'));
    if strcmp(get(handles.btn_f17_type,'Enable'),'off')
        set(handles.btn_f17_type,'String','Stepwise','Enable','on');
    end
    set(handles.edit_f17_ti,'Enable','on');
    set(handles.edit_f17_tf,'Enable','on');
else
    set(handles.btn_f17,'BackgroundColor',get_color('normal'));
    set(handles.btn_f17_type,'String','Step | Drift','BackgroundColor',get_color('step'),'Value',0,'Enable','off');
    set(handles.edit_f17_ti,'Enable','off');
    set(handles.edit_f17_tf,'Enable','off');
end

function btn_f17_type_Callback(hObject, ~, ~)

button_state = get(hObject,'Value');

if button_state == get(hObject,'Max')
    str = 'Driftwise';
    c   = get_color('drift');
else
    str = 'Stepwise';
    c   = get_color('step');
end

set(hObject,'String',str,'BackgroundColor',c);

function edit_f17_ti_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_f17_tf_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% f18 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

function btn_f18_Callback(hObject, ~, handles)

value = get(hObject,'Value');

set(handles.pf18,'Title',strcat('F18=',num2str(value)));

if value ~= 0
    set(handles.btn_f18,'BackgroundColor',get_color('fault'));
    if strcmp(get(handles.btn_f18_type,'Enable'),'off')
        set(handles.btn_f18_type,'String','Stepwise','Enable','on');
    end
    set(handles.edit_f18_ti,'Enable','on');
    set(handles.edit_f18_tf,'Enable','on');
else
    set(handles.btn_f18,'BackgroundColor',get_color('normal'));
    set(handles.btn_f18_type,'String','Step | Drift','BackgroundColor',get_color('step'),'Value',0,'Enable','off');
    set(handles.edit_f18_ti,'Enable','off');
    set(handles.edit_f18_tf,'Enable','off');
end

function btn_f18_type_Callback(hObject, ~, ~)

button_state = get(hObject,'Value');

if button_state == get(hObject,'Max')
    str = 'Driftwise';
    c   = get_color('drift');
else
    str = 'Stepwise';
    c   = get_color('step');
end

set(hObject,'String',str,'BackgroundColor',c);

function edit_f18_ti_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_f18_tf_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% f19 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

function btn_f19_Callback(hObject, ~, handles)

value = get(hObject,'Value');

set(handles.pf19,'Title',strcat('F19=',num2str(value)));

if value ~= 0
    set(handles.btn_f19,'BackgroundColor',get_color('fault'));
    if strcmp(get(handles.btn_f19_type,'Enable'),'off')
        set(handles.btn_f19_type,'String','Stepwise','Enable','on');
    end
    set(handles.edit_f19_ti,'Enable','on');
    set(handles.edit_f19_tf,'Enable','on');
else
    set(handles.btn_f19,'BackgroundColor',get_color('normal'));
    set(handles.btn_f19_type,'String','Step | Drift','BackgroundColor',get_color('step'),'Value',0,'Enable','off');
    set(handles.edit_f19_ti,'Enable','off');
    set(handles.edit_f19_tf,'Enable','off');
end

function btn_f19_type_Callback(hObject, ~, ~)

button_state = get(hObject,'Value');

if button_state == get(hObject,'Max')
    str = 'Driftwise';
    c   = get_color('drift');
else
    str = 'Stepwise';
    c   = get_color('step');
end

set(hObject,'String',str,'BackgroundColor',c);

function edit_f19_ti_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_f19_tf_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% f20 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

function btn_f20_Callback(hObject, ~, handles)

value = get(hObject,'Value');

set(handles.pf20,'Title',strcat('F20=',num2str(value)));

if value ~= 0
    set(handles.btn_f20,'BackgroundColor',get_color('fault'));
    if strcmp(get(handles.btn_f20_type,'Enable'),'off')
        set(handles.btn_f20_type,'String','Stepwise','Enable','on');
    end
    set(handles.edit_f20_ti,'Enable','on');
    set(handles.edit_f20_tf,'Enable','on');
else
    set(handles.btn_f20,'BackgroundColor',get_color('normal'));
    set(handles.btn_f20_type,'String','Step | Drift','BackgroundColor',get_color('step'),'Value',0,'Enable','off');
    set(handles.edit_f20_ti,'Enable','off');
    set(handles.edit_f20_tf,'Enable','off');
end

function btn_f20_type_Callback(hObject, ~, ~)

button_state = get(hObject,'Value');

if button_state == get(hObject,'Max')
    str = 'Driftwise';
    c   = get_color('drift');
else
    str = 'Stepwise';
    c   = get_color('step');
end

set(hObject,'String',str,'BackgroundColor',c);

function edit_f20_ti_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_f20_tf_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% f21 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

function btn_f21_Callback(hObject, ~, handles)

value = get(hObject,'Value');

set(handles.pf21,'Title',strcat('F21=',num2str(value)));

if value ~= 0
    set(handles.btn_f21,'BackgroundColor',get_color('fault'));
    if strcmp(get(handles.btn_f21_type,'Enable'),'off')
        set(handles.btn_f21_type,'String','Stepwise','Enable','on');
    end
    set(handles.edit_f21_ti,'Enable','on');
    set(handles.edit_f21_tf,'Enable','on');
else
    set(handles.btn_f21,'BackgroundColor',get_color('normal'));
    set(handles.btn_f21_type,'String','Step | Drift','BackgroundColor',get_color('step'),'Value',0,'Enable','off');
    set(handles.edit_f21_ti,'Enable','off');
    set(handles.edit_f21_tf,'Enable','off');
end

function btn_f21_type_Callback(hObject, ~, ~)

button_state = get(hObject,'Value');

if button_state == get(hObject,'Max')
    str = 'Driftwise';
    c   = get_color('drift');
else
    str = 'Stepwise';
    c   = get_color('step');
end

set(hObject,'String',str,'BackgroundColor',c);

function edit_f21_ti_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_f21_tf_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%% Plots ******************************************************************

function btn_plot_levels_Callback(~, ~, handles)

[t,h,y] = import_from_ws('time','levels','measurements');

N  = length(t);
N1 = round(N/4);
N2 = round(N1/2);
N3 = round((N1+N2)/2);

switch get(handles.popup_levels,'Value')
    case 1
        % Axes
        axes(handles.axes1);
        hold off;
        plot(t,h(1,:),'-o','MarkerIndices',01:N1:N);
        hold on;
        plot(t,h(2,:),'-s','MarkerIndices',N2:N1:N);
        plot(t,h(3,:),'-^','MarkerIndices',N3:N1:N);
        xlabel('time (s)','Fontsize',8);
        ylabel('real level (cm)','Fontsize',8);
        xlim([t(1) t(N)]);
        % Figure
        if get(handles.cbox_levels,'Value')
            delete(findobj('Tag','fig_all_levels'));
            plot_all_levels(h,y(1:3,:));
        end
        
    case 2
        % Axes
        axes(handles.axes1);
        hold off;
        plot(t,y(1,:),'r');
        hold on;
        plot(t,h(1,:),'b-o','MarkerIndices',1:N1:N);
        xlabel('time (s)','Fontsize',8);
        ylabel('level  h1 (cm)','Fontsize',8);
        xlim([t(1) t(N)]);
        % Figure
        if get(handles.cbox_levels,'Value')
            delete(findobj('Tag','h1'));
            plot_level('h1',h(1,:),y(1,:));
        end
        
    case 3
        % Axes
        axes(handles.axes1);
        hold off;
        plot(t,y(2,:),'r');
        hold on;
        plot(t,h(2,:),'b-o','MarkerIndices',1:N1:N);
        xlabel('time (s)','Fontsize',8);
        ylabel('level  h2 (cm)','Fontsize',8);
        xlim([t(1) t(N)]);
        % Figure
        if get(handles.cbox_levels,'Value')
            delete(findobj('Tag','h2'));
            plot_level('h2',h(2,:),y(2,:));
        end
        
    case 4
        % Axes
        axes(handles.axes1);
        hold off;
        plot(t,y(3,:),'r');
        hold on;
        plot(t,h(3,:),'b-o','MarkerIndices',1:N1:N);
        xlabel('time (s)','Fontsize',8);
        ylabel('level  h3 (cm)','Fontsize',8);
        xlim([t(1) t(N)]);
        % Figure
        if get(handles.cbox_levels,'Value')
            delete(findobj('Tag','h3'));
            plot_level('h3',h(3,:),y(3,:));
        end
end

function btn_plot_flows_Callback(~, ~, handles)

[t,q,y] = import_from_ws('time','flows','measurements');

N  = length(t);
N1 = round(N/4);

switch get(handles.popup_flows,'Value')
    case 1
        % Axes
        axes(handles.axes1);
        hold off;
        plot(t,q');
        xlabel('time (s)','Fontsize',8);
        ylabel('real flow (cm^3/s)','Fontsize',8);
        xlim([t(1) t(N)]);
        % Figure
        if get(handles.cbox_flows,'Value')
            delete(findobj('Tag','fig_all_flows'));
            plot_all_flows(q,y(4:end,:));
        end
        
    case 2
        % Axes
        axes(handles.axes1);
        hold off;
        plot(t,y(4,:),'r');
        hold on;
        plot(t,q(1,:),'b-o','MarkerIndices',1:N1:N);
        xlabel('time (s)','Fontsize',8);
        ylabel('flow  u1 (cm^3/s)','Fontsize',8);
        xlim([t(1) t(N)]);
        % Figure
        if get(handles.cbox_flows,'Value')
            delete(findobj('Tag','u1'));
            plot_flow('u1', q(1,:), y(4,:));
        end
        
    case 3
        % Axes
        axes(handles.axes1);
        hold off;
        plot(t,y(5,:),'r');
        hold on;
        plot(t,q(2,:),'b-o','MarkerIndices',1:N1:N);
        xlabel('time (s)','Fontsize',8);
        ylabel('flow  u2 (cm^3/s)','Fontsize',8);
        xlim([t(1) t(N)]);
        % Figure
        if get(handles.cbox_flows,'Value')
            delete(findobj('Tag','u2'));
            plot_flow('u2', q(2,:), y(5,:));
        end
        
    case 4
        % Axes
        axes(handles.axes1);
        hold off;
        plot(t,y(6,:),'r');
        hold on;
        plot(t,q(3,:),'b-o','MarkerIndices',1:N1:N);
        xlabel('time (s)','Fontsize',8);
        ylabel('flow  Qa (cm^3/s)','Fontsize',8);
        xlim([t(1) t(N)]);
        % Figure
        if get(handles.cbox_flows,'Value')
            delete(findobj('Tag','Qa'));
            plot_flow('Qa', q(3,:), y(6,:));
        end
        
    case 5
        % Axes
        axes(handles.axes1);
        hold off;
        plot(t,y(7,:),'r');
        hold on;
        plot(t,q(4,:),'b-o','MarkerIndices',1:N1:N);
        xlabel('time (s)','Fontsize',8);
        ylabel('flow  Qb (cm^3/s)','Fontsize',8);
        xlim([t(1) t(N)]);
        % Figure
        if get(handles.cbox_flows,'Value')
            delete(findobj('Tag','Qb'));
            plot_flow('Qb', q(4,:), y(7,:));
        end
        
    case 6
        % Axes
        axes(handles.axes1);
        hold off;
        plot(t,y(8,:),'r');
        hold on;
        plot(t,q(5,:),'b-o','MarkerIndices',1:N1:N);
        xlabel('time (s)','Fontsize',8);
        ylabel('flow  Q13 (cm^3/s)','Fontsize',8);
        xlim([t(1) t(N)]);
        % Figure
        if get(handles.cbox_flows,'Value')
            delete(findobj('Tag','Q13'));
            plot_flow('Q13', q(5,:), y(8,:));
        end
        
    case 7
        % Axes
        axes(handles.axes1);
        hold off;
        plot(t,y(9,:),'r');
        hold on;
        plot(t,q(6,:),'b-o','MarkerIndices',1:N1:N);
        xlabel('time (s)','Fontsize',8);
        ylabel('flow  Q23 (cm^3/s)','Fontsize',8);
        xlim([t(1) t(N)]);
        % Figure
        if get(handles.cbox_flows,'Value')
            delete(findobj('Tag','Q23'));
            plot_flow('Q23', q(6,:), y(9,:));
        end
        
    case 8
        % Axes
        axes(handles.axes1);
        hold off;
        plot(t,y(10,:),'r');
        hold on;
        plot(t,q(7,:),'b-o','MarkerIndices',1:N1:N);
        xlabel('time (s)','Fontsize',8);
        ylabel('flow  Q1 (cm^3/s)','Fontsize',8);
        xlim([t(1) t(N)]);
        % Figure
        if get(handles.cbox_flows,'Value')
            delete(findobj('Tag','Q1'));
            plot_flow('Q1', q(7,:), y(10,:));
        end
        
    case 9
        % Axes
        axes(handles.axes1);
        hold off;
        plot(t,y(11,:),'r');
        hold on;
        plot(t,q(8,:),'b-o','MarkerIndices',1:N1:N);
        xlabel('time (s)','Fontsize',8);
        ylabel('flow  Q2 (cm^3/s)','Fontsize',8);
        xlim([t(1) t(N)]);
        % Figure
        if get(handles.cbox_flows,'Value')
            delete(findobj('Tag','Q2'));
            plot_flow('Q2', q(8,:), y(11,:));
        end
        
    case 10
        % Axes
        axes(handles.axes1);
        hold off;
        plot(t,y(12,:),'r');
        hold on;
        plot(t,q(9,:),'b-o','MarkerIndices',1:N1:N);
        xlabel('time (s)','Fontsize',8);
        ylabel('flow  Q3 (cm^3/s)','Fontsize',8);
        xlim([t(1) t(N)]);
        % Figure
        if get(handles.cbox_flows,'Value')
            delete(findobj('Tag','Q3'));
            plot_flow('Q3', q(9,:), y(12,:));
        end
end

function btn_plot_valves_Callback(~, ~, handles)

[t,K] = import_from_ws('time','valves');

N  = length(t);
N1 = round(N/4);

switch get(handles.popup_valves,'Value')
    case 1
        % Axes
        axes(handles.axes1);
        hold off;
        plot(0,0);
        xlabel('time','Fontsize',8);
        ylabel('magnitude','Fontsize',8);
        % Figure
        delete(findobj('Tag','fig_all_valves'));
        plot_valves(K);
        
    case 2
        % Axes
        axes(handles.axes1);
        hold off;
        plot(t,K(1,:),'k-o','MarkerIndices',1:N1:N);
        xlabel('time (s)','Fontsize',8);
        ylabel('valve  Kp1','Fontsize',8);
        xlim([t(1) t(N)]);
        ylim([-0.1 1.1]);
        % Figure
        if get(handles.cbox_valves,'Value')
            delete(findobj('Tag','Kp1'));
            plot_valves(K(1,:),get_operation_mode('Kp1'),'Kp1');
        end
        
    case 3
        % Axes
        axes(handles.axes1);
        hold off;
        plot(t,K(2,:),'k-o','MarkerIndices',1:N1:N);
        xlabel('time (s)','Fontsize',8);
        ylabel('valve  Kp2','Fontsize',8);
        xlim([t(1) t(N)]);
        ylim([-0.1 1.1]);
        % Figure
        if get(handles.cbox_valves,'Value')
            delete(findobj('Tag','Kp2'));
            plot_valves(K(2,:),get_operation_mode('Kp2'),'Kp2');
        end
        
    case 4
        % Axes
        axes(handles.axes1);
        hold off;
        plot(t,K(3,:),'k-o','MarkerIndices',1:N1:N);
        xlabel('time (s)','Fontsize',8);
        ylabel('valve  Ka','Fontsize',8);
        xlim([t(1) t(N)]);
        ylim([-0.1 1.1]);
        % Figure
        if get(handles.cbox_valves,'Value')
            delete(findobj('Tag','Ka'));
            plot_valves(K(3,:),get_operation_mode('Ka'),'Ka');
        end
        
    case 5
        % Axes
        axes(handles.axes1);
        hold off;
        plot(t,K(4,:),'k-o','MarkerIndices',1:N1:N);
        xlabel('time (s)','Fontsize',8);
        ylabel('valve  Kb','Fontsize',8);
        xlim([t(1) t(N)]);
        ylim([-0.1 1.1]);
        % Figure
        if get(handles.cbox_valves,'Value')
            delete(findobj('Tag','Kb'));
            plot_valves(K(4,:),get_operation_mode('Kb'),'Kb');
        end
        
    case 6
        % Axes
        axes(handles.axes1);
        hold off;
        plot(t,K(5,:),'k-o','MarkerIndices',1:N1:N);
        xlabel('time (s)','Fontsize',8);
        ylabel('valve  K13','Fontsize',8);
        xlim([t(1) t(N)]);
        ylim([-0.1 1.1]);
        % Figure
        if get(handles.cbox_valves,'Value')
            delete(findobj('Tag','K13'));
            plot_valves(K(5,:),get_operation_mode('K13'),'K13');
        end
        
    case 7
        % Axes
        axes(handles.axes1);
        hold off;
        plot(t,K(6,:),'k-o','MarkerIndices',1:N1:N);
        xlabel('time (s)','Fontsize',8);
        ylabel('valve  K23','Fontsize',8);
        xlim([t(1) t(N)]);
        ylim([-0.1 1.1]);
        % Figure
        if get(handles.cbox_valves,'Value')
            delete(findobj('Tag','K23'));
            plot_valves(K(6,:),get_operation_mode('K23'),'K23');
        end
        
    case 8
        % Axes
        axes(handles.axes1);
        hold off;
        plot(t,K(7,:),'k-o','MarkerIndices',1:N1:N);
        xlabel('time (s)','Fontsize',8);
        ylabel('valve  K1','Fontsize',8);
        xlim([t(1) t(N)]);
        ylim([-0.1 1.1]);
        % Figure
        if get(handles.cbox_valves,'Value')
            delete(findobj('Tag','K1'));
            plot_valves(K(7,:),get_operation_mode('K1'),'K1');
        end
        
    case 9
        % Axes
        axes(handles.axes1);
        hold off;
        plot(t,K(8,:),'k-o','MarkerIndices',1:N1:N);
        xlabel('time (s)','Fontsize',8);
        ylabel('valve  K2','Fontsize',8);
        xlim([t(1) t(N)]);
        ylim([-0.1 1.1]);
        % Figure
        if get(handles.cbox_valves,'Value')
            delete(findobj('Tag','K2'));
            plot_valves(K(8,:),get_operation_mode('K2'),'K2');
        end
        
    case 10
        % Axes
        axes(handles.axes1);
        hold off;
        plot(t,K(9,:),'k-o','MarkerIndices',1:N1:N);
        xlabel('time (s)','Fontsize',8);
        ylabel('valve  K3','Fontsize',8);
        xlim([t(1) t(N)]);
        ylim([-0.1 1.1]);
        % Figure
        if get(handles.cbox_valves,'Value')
            delete(findobj('Tag','K3'));
            plot_valves(K(9,:),get_operation_mode('K3'),'K3');
        end
end

function btn_plot_faults_Callback(~, ~, handles)

[t,f] = import_from_ws('time','faults');

N  = length(t);
N1 = round(N/4);

switch get(handles.popup_faults,'Value')
    case 1
        % Axes
        axes(handles.axes1);
        hold off;
        plot(0,0);
        xlabel('time','Fontsize',8);
        ylabel('magnitude','Fontsize',8);
        % Figure
        delete(findobj('Tag','fig_all_faults'));
        plot_faults(f);
        
    case 2
        % Axes
        axes(handles.axes1);
        hold off;
        plot(t,f(1,:),'r-o','MarkerIndices',1:N1:N);
        xlabel('time (s)','Fontsize',8);
        ylabel('fault  F1','Fontsize',8);
        xlim([t(1) t(N)]);
        ylim([-0.1 1.1]);
        % Figure
        if get(handles.cbox_faults,'Value')
            delete(findobj('Tag','F1'));
            plot_faults(f(1,:),'F1');
        end
        
    case 3
        % Axes
        axes(handles.axes1);
        hold off;
        plot(t,f(2,:),'r-o','MarkerIndices',1:N1:N);
        xlabel('time (s)','Fontsize',8);
        ylabel('fault  F2','Fontsize',8);
        xlim([t(1) t(N)]);
        ylim([-0.1 1.1]);
        % Figure
        if get(handles.cbox_faults,'Value')
            delete(findobj('Tag','F2'));
            plot_faults(f(2,:),'F2');
        end
        
    case 4
        % Axes
        axes(handles.axes1);
        hold off;
        plot(t,f(3,:),'r-o','MarkerIndices',1:N1:N);
        xlabel('time (s)','Fontsize',8);
        ylabel('fault  F3','Fontsize',8);
        xlim([t(1) t(N)]);
        ylim([-0.1 1.1]);
        % Figure
        if get(handles.cbox_faults,'Value')
            delete(findobj('Tag','F3'));
            plot_faults(f(3,:),'F3');
        end
        
    case 5
        % Axes
        axes(handles.axes1);
        hold off;
        plot(t,f(4,:),'r-o','MarkerIndices',1:N1:N);
        xlabel('time (s)','Fontsize',8);
        ylabel('fault  F4','Fontsize',8);
        xlim([t(1) t(N)]);
        ylim([-0.1 1.1]);
        % Figure
        if get(handles.cbox_faults,'Value')
            delete(findobj('Tag','F4'));
            plot_faults(f(4,:),'F4');
        end
        
    case 6
        % Axes
        axes(handles.axes1);
        hold off;
        plot(t,f(5,:),'r-o','MarkerIndices',1:N1:N);
        xlabel('time (s)','Fontsize',8);
        ylabel('fault  F5','Fontsize',8);
        xlim([t(1) t(N)]);
        ylim([-0.1 1.1]);
        % Figure
        if get(handles.cbox_faults,'Value')
            delete(findobj('Tag','F5'));
            plot_faults(f(5,:),'F5');
        end
        
    case 7
        % Axes
        axes(handles.axes1);
        hold off;
        plot(t,f(6,:),'r-o','MarkerIndices',1:N1:N);
        xlabel('time (s)','Fontsize',8);
        ylabel('fault  F6','Fontsize',8);
        xlim([t(1) t(N)]);
        ylim([-0.1 1.1]);
        % Figure
        if get(handles.cbox_faults,'Value')
            delete(findobj('Tag','F6'));
            plot_faults(f(6,:),'F6');
        end
        
    case 8
        % Axes
        axes(handles.axes1);
        hold off;
        plot(t,f(7,:),'r-o','MarkerIndices',1:N1:N);
        xlabel('time (s)','Fontsize',8);
        ylabel('fault  F7','Fontsize',8);
        xlim([t(1) t(N)]);
        ylim([-0.1 1.1]);
        % Figure
        if get(handles.cbox_faults,'Value')
            delete(findobj('Tag','F7'));
            plot_faults(f(7,:),'F7');
        end
        
    case 9
        % Axes
        axes(handles.axes1);
        hold off;
        plot(t,f(8,:),'r-o','MarkerIndices',1:N1:N);
        xlabel('time (s)','Fontsize',8);
        ylabel('fault  F8','Fontsize',8);
        xlim([t(1) t(N)]);
        ylim([-0.1 1.1]);
        % Figure
        if get(handles.cbox_faults,'Value')
            delete(findobj('Tag','F8'));
            plot_faults(f(8,:),'F8');
        end
        
    case 10
        % Axes
        axes(handles.axes1);
        hold off;
        plot(t,f(9,:),'r-o','MarkerIndices',1:N1:N);
        xlabel('time (s)','Fontsize',8);
        ylabel('fault  F9','Fontsize',8);
        xlim([t(1) t(N)]);
        ylim([-0.1 1.1]);
        % Figure
        if get(handles.cbox_faults,'Value')
            delete(findobj('Tag','F9'));
            plot_faults(f(9,:),'F9');
        end
        
    case 11
        % Axes
        axes(handles.axes1);
        hold off;
        plot(t,f(10,:),'r-o','MarkerIndices',1:N1:N);
        xlabel('time (s)','Fontsize',8);
        ylabel('fault  F10','Fontsize',8);
        xlim([t(1) t(N)]);
        ylim([-0.1 1.1]);
        % Figure
        if get(handles.cbox_faults,'Value')
            delete(findobj('Tag','F10'));
            plot_faults(f(10,:),'F10');
        end
        
    case 12
        % Axes
        axes(handles.axes1);
        hold off;
        plot(t,f(11,:),'r-o','MarkerIndices',1:N1:N);
        xlabel('time (s)','Fontsize',8);
        ylabel('fault  F11','Fontsize',8);
        xlim([t(1) t(N)]);
        ylim([-0.1 1.1]);
        % Figure
        if get(handles.cbox_faults,'Value')
            delete(findobj('Tag','F11'));
            plot_faults(f(11,:),'F11');
        end
        
    case 13
        % Axes
        axes(handles.axes1);
        hold off;
        plot(t,f(12,:),'r-o','MarkerIndices',1:N1:N);
        xlabel('time (s)','Fontsize',8);
        ylabel('fault  F12','Fontsize',8);
        xlim([t(1) t(N)]);
        ylim([-0.1 1.1]);
        % Figure
        if get(handles.cbox_faults,'Value')
            delete(findobj('Tag','F12'));
            plot_faults(f(12,:),'F12');
        end
        
    case 14
        % Axes
        axes(handles.axes1);
        hold off;
        plot(t,f(13,:),'r-o','MarkerIndices',1:N1:N);
        xlabel('time (s)','Fontsize',8);
        ylabel('fault  F13','Fontsize',8);
        xlim([t(1) t(N)]);
        ylim([-0.1 1.1]);
        % Figure
        if get(handles.cbox_faults,'Value')
            delete(findobj('Tag','F13'));
            plot_faults(f(13,:),'F13');
        end
        
    case 15
        % Axes
        axes(handles.axes1);
        hold off;
        plot(t,f(14,:),'r-o','MarkerIndices',1:N1:N);
        xlabel('time (s)','Fontsize',8);
        ylabel('fault  F14','Fontsize',8);
        xlim([t(1) t(N)]);
        ylim([-0.1 1.1]);
        % Figure
        if get(handles.cbox_faults,'Value')
            delete(findobj('Tag','F14'));
            plot_faults(f(14,:),'F14');
        end
        
    case 16
        % Axes
        axes(handles.axes1);
        hold off;
        plot(t,f(15,:),'r-o','MarkerIndices',1:N1:N);
        xlabel('time (s)','Fontsize',8);
        ylabel('fault  F15','Fontsize',8);
        xlim([t(1) t(N)]);
        ylim([-0.1 1.1]);
        % Figure
        if get(handles.cbox_faults,'Value')
            delete(findobj('Tag','F15'));
            plot_faults(f(15,:),'F15');
        end
        
    case 17
        % Axes
        axes(handles.axes1);
        hold off;
        plot(t,f(16,:),'r-o','MarkerIndices',1:N1:N);
        xlabel('time (s)','Fontsize',8);
        ylabel('fault  F16','Fontsize',8);
        xlim([t(1) t(N)]);
        ylim([-0.1 1.1]);
        % Figure
        if get(handles.cbox_faults,'Value')
            delete(findobj('Tag','F16'));
            plot_faults(f(16,:),'F16');
        end
        
    case 18
        % Axes
        axes(handles.axes1);
        hold off;
        plot(t,f(17,:),'r-o','MarkerIndices',1:N1:N);
        xlabel('time (s)','Fontsize',8);
        ylabel('fault  F17','Fontsize',8);
        xlim([t(1) t(N)]);
        ylim([-0.1 1.1]);
        % Figure
        if get(handles.cbox_faults,'Value')
            delete(findobj('Tag','F17'));
            plot_faults(f(17,:),'F17');
        end
        
    case 19
        % Axes
        axes(handles.axes1);
        hold off;
        plot(t,f(18,:),'r-o','MarkerIndices',1:N1:N);
        xlabel('time (s)','Fontsize',8);
        ylabel('fault  F18','Fontsize',8);
        xlim([t(1) t(N)]);
        ylim([-0.1 1.1]);
        % Figure
        if get(handles.cbox_faults,'Value')
            delete(findobj('Tag','F18'));
            plot_faults(f(18,:),'F18');
        end
        
    case 20
        % Axes
        axes(handles.axes1);
        hold off;
        plot(t,f(19,:),'r-o','MarkerIndices',1:N1:N);
        xlabel('time (s)','Fontsize',8);
        ylabel('fault  F19','Fontsize',8);
        xlim([t(1) t(N)]);
        ylim([-0.1 1.1]);
        % Figure
        if get(handles.cbox_faults,'Value')
            delete(findobj('Tag','F19'));
            plot_faults(f(19,:),'F19');
        end
        
    case 21
        % Axes
        axes(handles.axes1);
        hold off;
        plot(t,f(20,:),'r-o','MarkerIndices',1:N1:N);
        xlabel('time (s)','Fontsize',8);
        ylabel('fault  F20','Fontsize',8);
        xlim([t(1) t(N)]);
        ylim([-0.1 1.1]);
        % Figure
        if get(handles.cbox_faults,'Value')
            delete(findobj('Tag','F20'));
            plot_faults(f(20,:),'F20');
        end
        
    case 22
        % Axes
        axes(handles.axes1);
        hold off;
        plot(t,f(21,:),'r-o','MarkerIndices',1:N1:N);
        xlabel('time (s)','Fontsize',8);
        ylabel('fault  F21','Fontsize',8);
        xlim([t(1) t(N)]);
        ylim([-0.1 1.1]);
        % Figure
        if get(handles.cbox_faults,'Value')
            delete(findobj('Tag','F21'));
            plot_faults(f(21,:),'F21');
        end
end

function popup_levels_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function popup_flows_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function popup_valves_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function popup_faults_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function cbox_valves_Callback(hObject, ~, handles)

if get(handles.popup_valves,'Value') == 1
    set(hObject,'Value',1);
end

function cbox_faults_Callback(hObject, ~, handles)

if get(handles.popup_faults,'Value') == 1
    set(hObject,'Value',1);
end

function popup_valves_Callback(hObject, ~, handles)

if get(hObject,'Value') == 1
    set(handles.cbox_valves,'Value',1);
end

function popup_faults_Callback(hObject, ~, handles)

if get(hObject,'Value') == 1
    set(handles.cbox_faults,'Value',1);
end



%% Run ********************************************************************

function btn_run_simulation_Callback(hObject, ~, handles)

delete(findobj('Tag','see_dynamic_figure'));

set(handles.output,'HandleVisibility','off');
close all; clc; clear -regexp \d;
set(handles.output,'HandleVisibility','on');

disp('#Preparing environment...');

set(hObject,'String','Running...','Enable','off');
set(handles.btn_reset,'Enable','off');

drawnow;

%% Begin getting data -----------------------------------------------------
disp('#Getting data...');

% Parameters
R    = str2double(get(handles.edit_RR,'String'));
Hmax = str2double(get(handles.edit_Hmax,'String'));
r    = str2double(get(handles.edit_r,'String'));
h0   = str2double(get(handles.edit_h0,'String'));
mi   = str2double(get(handles.edit_mi,'String'));
g    = str2double(get(handles.edit_g,'String'));

% Initial conditions
hi1 = str2double(get(handles.edit_hi1,'String'));
hi2 = str2double(get(handles.edit_hi2,'String'));
hi3 = str2double(get(handles.edit_hi3,'String'));

% Simulation time
tf = str2double(get(handles.edit_time,'String'));

% Pump P1
Qp1    = str2double(get(handles.edit_Qp1,'String'));
Qp1_ti = str2double(get(handles.edit_Qp1_ti,'String'));
Qp1_tf = str2double(get(handles.edit_Qp1_tf,'String'));

% Pump P2
Qp2    = str2double(get(handles.edit_Qp2,'String'));
Qp2_ti = str2double(get(handles.edit_Qp2_ti,'String'));
Qp2_tf = str2double(get(handles.edit_Qp2_tf,'String'));

% White noise
w_mean      = str2double(get(handles.edit_w_mean,'String'));
w_std       = str2double(get(handles.edit_w_std,'String'));
vlevel_mean = str2double(get(handles.edit_vlevel_mean,'String'));
vlevel_std  = str2double(get(handles.edit_vlevel_std,'String'));
vflow_mean  = str2double(get(handles.edit_vflow_mean,'String'));
vflow_std   = str2double(get(handles.edit_vflow_std,'String'));

% Operation mode
dKp1 = 1-get(handles.btn_dKp1,'Value');
dKp2 = 1-get(handles.btn_dKp2,'Value');
dKa  = 1-get(handles.btn_dKa,'Value');
dKb  = 1-get(handles.btn_dKb,'Value');
dK13 = 1-get(handles.btn_dK13,'Value');
dK23 = 1-get(handles.btn_dK23,'Value');
dK1  = 1-get(handles.btn_dK1,'Value');
dK2  = 1-get(handles.btn_dK2,'Value');
dK3  = 1-get(handles.btn_dK3,'Value');

% Fault signals
f1  = get(handles.btn_f1,'Value');
f2  = get(handles.btn_f2,'Value');
f3  = get(handles.btn_f3,'Value');
f4  = get(handles.btn_f4,'Value');
f5  = get(handles.btn_f5,'Value');
f6  = get(handles.btn_f6,'Value');
f7  = get(handles.btn_f7,'Value');
f8  = get(handles.btn_f8,'Value');
f9  = get(handles.btn_f9,'Value');
f10 = get(handles.btn_f10,'Value');
f11 = get(handles.btn_f11,'Value');
f12 = get(handles.btn_f12,'Value');
f13 = get(handles.btn_f13,'Value');
f14 = get(handles.btn_f14,'Value');
f15 = get(handles.btn_f15,'Value');
f16 = get(handles.btn_f16,'Value');
f17 = get(handles.btn_f17,'Value');
f18 = get(handles.btn_f18,'Value');
f19 = get(handles.btn_f19,'Value');
f20 = get(handles.btn_f20,'Value');
f21 = get(handles.btn_f21,'Value');

f1t  = get(handles.btn_f1_type,'Value');
f2t  = get(handles.btn_f2_type,'Value');
f3t  = get(handles.btn_f3_type,'Value');
f4t  = get(handles.btn_f4_type,'Value');
f5t  = get(handles.btn_f5_type,'Value');
f6t  = get(handles.btn_f6_type,'Value');
f7t  = get(handles.btn_f7_type,'Value');
f8t  = get(handles.btn_f8_type,'Value');
f9t  = get(handles.btn_f9_type,'Value');
f10t = get(handles.btn_f10_type,'Value');
f11t = get(handles.btn_f11_type,'Value');
f12t = get(handles.btn_f12_type,'Value');
f13t = get(handles.btn_f13_type,'Value');
f14t = get(handles.btn_f14_type,'Value');
f15t = get(handles.btn_f15_type,'Value');
f16t = get(handles.btn_f16_type,'Value');
f17t = get(handles.btn_f17_type,'Value');
f18t = get(handles.btn_f18_type,'Value');
f19t = get(handles.btn_f19_type,'Value');
f20t = get(handles.btn_f20_type,'Value');
f21t = get(handles.btn_f21_type,'Value');

f1i  = str2double(get(handles.edit_f1_ti,'String'));
f2i  = str2double(get(handles.edit_f2_ti,'String'));
f3i  = str2double(get(handles.edit_f3_ti,'String'));
f4i  = str2double(get(handles.edit_f4_ti,'String'));
f5i  = str2double(get(handles.edit_f5_ti,'String'));
f6i  = str2double(get(handles.edit_f6_ti,'String'));
f7i  = str2double(get(handles.edit_f7_ti,'String'));
f8i  = str2double(get(handles.edit_f8_ti,'String'));
f9i  = str2double(get(handles.edit_f9_ti,'String'));
f10i = str2double(get(handles.edit_f10_ti,'String'));
f11i = str2double(get(handles.edit_f11_ti,'String'));
f12i = str2double(get(handles.edit_f12_ti,'String'));
f13i = str2double(get(handles.edit_f13_ti,'String'));
f14i = str2double(get(handles.edit_f14_ti,'String'));
f15i = str2double(get(handles.edit_f15_ti,'String'));
f16i = str2double(get(handles.edit_f16_ti,'String'));
f17i = str2double(get(handles.edit_f17_ti,'String'));
f18i = str2double(get(handles.edit_f18_ti,'String'));
f19i = str2double(get(handles.edit_f19_ti,'String'));
f20i = str2double(get(handles.edit_f20_ti,'String'));
f21i = str2double(get(handles.edit_f21_ti,'String'));

f1f  = str2double(get(handles.edit_f1_tf,'String'));
f2f  = str2double(get(handles.edit_f2_tf,'String'));
f3f  = str2double(get(handles.edit_f3_tf,'String'));
f4f  = str2double(get(handles.edit_f4_tf,'String'));
f5f  = str2double(get(handles.edit_f5_tf,'String'));
f6f  = str2double(get(handles.edit_f6_tf,'String'));
f7f  = str2double(get(handles.edit_f7_tf,'String'));
f8f  = str2double(get(handles.edit_f8_tf,'String'));
f9f  = str2double(get(handles.edit_f9_tf,'String'));
f10f = str2double(get(handles.edit_f10_tf,'String'));
f11f = str2double(get(handles.edit_f11_tf,'String'));
f12f = str2double(get(handles.edit_f12_tf,'String'));
f13f = str2double(get(handles.edit_f13_tf,'String'));
f14f = str2double(get(handles.edit_f14_tf,'String'));
f15f = str2double(get(handles.edit_f15_tf,'String'));
f16f = str2double(get(handles.edit_f16_tf,'String'));
f17f = str2double(get(handles.edit_f17_tf,'String'));
f18f = str2double(get(handles.edit_f18_tf,'String'));
f19f = str2double(get(handles.edit_f19_tf,'String'));
f20f = str2double(get(handles.edit_f20_tf,'String'));
f21f = str2double(get(handles.edit_f21_tf,'String'));

%% End getting data -------------------------------------------------------

disp('#Preparing simulation...');

% Set system parameters
set_parameters(R, Hmax, r, h0, mi, g);

% Simulation time
Ts = str2double(get(handles.edit_Ts,'String'));
t  = linspace(0, tf, 1+tf/Ts);

set_time(t);

% Flows from pumps
pumps  = [Qp1    Qp2   ];
pstart = [Qp1_ti Qp2_ti];
pstop  = [Qp1_tf Qp2_tf];

set_pumps(pumps, pstart, pstop);

% Operation mode
operation_mode = [dKp1 dKp2 dKa dKb dK13 dK23 dK1 dK2 dK3];

set_operation_mode(operation_mode);

% Fault signals
%------->[Kp1 Kp2 Ka  Kb  K13 K23 K1  K2  K3  h1  h2  h3  u1  u2  Qa* Qb* Q13 Q23 Q1* Q2* Q3 ]
%------->[F1  F2  F3  F4  F5  F6  F7  F8  F9  F10 F11 F12 F13 F14 F15 F16 F17 F18 F19 F20 F21]
fmag   = [f1  f2  f3  f4  f5  f6  f7  f8  f9  f10  f11  f12  f13  f14  f15  f16  f17  f18  f19  f20  f21 ];
ftype  = [f1t f2t f3t f4t f5t f6t f7t f8t f9t f10t f11t f12t f13t f14t f15t f16t f17t f18t f19t f20t f21t];
fstart = [f1i f2i f3i f4i f5i f6i f7i f8i f9i f10i f11i f12i f13i f14i f15i f16i f17i f18i f19i f20i f21i];
fstop  = [f1f f2f f3f f4f f5f f6f f7f f8f f9f f10f f11f f12f f13f f14f f15f f16f f17f f18f f19f f20f f21f];

set_faults(fmag, ftype, fstart, fstop);

%% System simulation

x0 = [hi1 hi2 hi3]'; % Initial tank levels (cm)
u  = [0 0]';         % First control signal (cm^3/s)(don't change)

% Continuous three-tank system variables
N = length(get_time()); % Number of samples
x = zeros(3,N);  % States: x = [h1, h2, h3]'
q = zeros(9,N);  % Outflows: q = [u1, u2, Qa, Qb, Q13, Q23, Q1, Q2, Q3]'
y = zeros(12,N); % Outputs measured: y = [h1, h2, h3, u1, u2, Qa, Qb, Q13, Q23, Q1, Q2, Q3]'

% Control system
include_control_system = get(handles.cbox_control_system,'Value');

if include_control_system
    func_control_system = str2func(get(handles.edit_control_system,'String'));
    setpoint = str2num(get(handles.edit_setpoint,'String'));
end

% FDI system
include_fdi_system     = get(handles.cbox_fdi_system,'Value');

if include_fdi_system
    func_fdi_system = str2func(get(handles.edit_fdi_system,'String'));
end

code = strcat(num2str(include_control_system),num2str(include_fdi_system));

run('gui_see_dynamic');

time = findobj('Tag','gui_rt_edt_time');
yh1  = findobj('Tag','edit_rt_h1');
yh2  = findobj('Tag','edit_rt_h2');
yh3  = findobj('Tag','edit_rt_h3');
yu1  = findobj('Tag','edit_rt_u1');
yu2  = findobj('Tag','edit_rt_u2');
yQa  = findobj('Tag','edit_rt_Qa');
yQb  = findobj('Tag','edit_rt_Qb');
yQ13 = findobj('Tag','edit_rt_Q13');
yQ23 = findobj('Tag','edit_rt_Q23');
yQ1  = findobj('Tag','edit_rt_Q1');
yQ2  = findobj('Tag','edit_rt_Q2');
yQ3  = findobj('Tag','edit_rt_Q3');

pump1 = findobj('Tag','gui_rt_pump1');
pump2 = findobj('Tag','gui_rt_pump2');

tank1 = findobj('Tag','gui_rt_tank1');
tank2 = findobj('Tag','gui_rt_tank2');
tank3 = findobj('Tag','gui_rt_tank3');

pipeKp1 = findobj('Tag','gui_rt_pipe_Kp1');
pipeKp2 = findobj('Tag','gui_rt_pipe_Kp2');
pipeKa  = findobj('Tag','gui_rt_pipe_Ka');
pipeKb  = findobj('Tag','gui_rt_pipe_Kb');
pipeK13 = findobj('Tag','gui_rt_pipe_K13');
pipeK23 = findobj('Tag','gui_rt_pipe_K23');
pipeK1  = findobj('Tag','gui_rt_pipe_K1');
pipeK2  = findobj('Tag','gui_rt_pipe_K2');
pipeK3  = findobj('Tag','gui_rt_pipe_K3');

valveKa  = findobj('Tag','gui_rt_Ka');
valveKb  = findobj('Tag','gui_rt_Kb');

frameKp1 = findobj('Tag','frame_rt_Kp1');
frameKp2 = findobj('Tag','frame_rt_Kp2');
frameKa  = findobj('Tag','frame_rt_Ka');
frameKb  = findobj('Tag','frame_rt_Kb');
frameK13 = findobj('Tag','frame_rt_K13');
frameK23 = findobj('Tag','frame_rt_K23');
frameK1  = findobj('Tag','frame_rt_K1');
frameK2  = findobj('Tag','frame_rt_K2');
frameK3  = findobj('Tag','frame_rt_K3');

fig_stop = findobj('Tag','see_dynamic_figure');
btn_stop = findobj('Tag','btn_stop_simulation');

h_pipe  = (9/Hmax)*h0 + 5;
h_valve = h_pipe - 0.4;

set(pipeKa,'Position',[20 h_pipe 24 1]);
set(pipeKb,'Position',[55 h_pipe 24 1]);

set(valveKa,'Position',[28.5 h_valve 7 2]);
set(valveKb,'Position',[63.5 h_valve 7 2]);

drawnow;

fault = get_color('fault');
blue  = get_color('b');
white = get_color('w');

switch code
    
    case '00'
        disp(' *Control system: NO');
        disp(' *FDI system: NO');
        disp('#Running Sim3Tanks...');
        
        for k = 1 : N
            
            if(ishandle(fig_stop))
                if get(btn_stop,'Value')
                    break;
                end
            else
                break;
            end
            
            drawnow;
            
            set_k(k); % Update current k
            
            f = get_faults(k); % Fault signal
            w = get_process_noise([w_mean w_std]); % Process noise
            v = get_output_noise([vlevel_mean vlevel_std], [vflow_mean vflow_std]); % Output noise
            
            Qp = get_pumps(k); % Flow from pumps
            
            % Three-tank system
            [y(:,k), x(:,k), q(:,k)] = three_tank_system_simulator(x0, u, f, w, v);
            
            % Control signal
            u = Qp;
            
            %% Real time animation
            
            try
                tcurrent = t(k);
                
                set(time,'String',num2str(tcurrent));
                set(yh1,'String',num2str(x(1,k)));
                set(yh2,'String',num2str(x(2,k)));
                set(yh3,'String',num2str(x(3,k)));
                set(yu1,'String',num2str(q(1,k)));
                set(yu2,'String',num2str(q(2,k)));
                set(yQa,'String',num2str(q(3,k)));
                set(yQb,'String',num2str(q(4,k)));
                set(yQ13,'String',num2str(q(5,k)));
                set(yQ23,'String',num2str(q(6,k)));
                set(yQ1,'String',num2str(q(7,k)));
                set(yQ2,'String',num2str(q(8,k)));
                set(yQ3,'String',num2str(q(9,k)));
                
                level = (9/Hmax)*mysaturation(x(:,k),0.1,Hmax);
                
                if (x(1,k) >= Hmax)
                    set(tank1,'Position',[07 05 15 level(1)],'BackgroundColor',fault);
                else
                    set(tank1,'Position',[07 05 15 level(1)],'BackgroundColor',blue);
                end
                
                if (x(2,k) >= Hmax)
                    set(tank2,'Position',[77 05 15 level(2)],'BackgroundColor',fault);
                else
                    set(tank2,'Position',[77 05 15 level(2)],'BackgroundColor',blue);
                end
                
                if (x(3,k) >= Hmax)
                    set(tank3,'Position',[42 05 15 level(3)],'BackgroundColor',fault);
                else
                    set(tank3,'Position',[42 05 15 level(3)],'BackgroundColor',blue);
                end
                
                % CJ1 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                if(tcurrent >= Qp1_ti && tcurrent <= Qp1_tf && Qp1 > 0)
                    set(pump1,'BackgroundColor',blue);
                    flagQp1 = 1;
                else
                    set(pump1,'BackgroundColor',white);
                    flagQp1 = 0;
                end
                
                if(f(1)==0)
                    set(frameKp1,'Visible','off');
                    if(dKp1==1)
                        flagKp1 = 1;
                    else
                        flagKp1 = 0;
                    end
                else
                    flagKp1 = 1;
                    if(dKp1==1)
                        set(frameKp1,'Visible','on','Position',[11 15 7*f(1) 2],'BackgroundColor',white);
                        if(f(1)==1)
                            flagKp1 = 0;
                        end
                    else
                        set(frameKp1,'Visible','on','Position',[11 15 7*f(1) 2],'BackgroundColor',blue);
                    end
                end
                
                if(flagQp1 && flagKp1)
                    set(pipeKp1,'BackgroundColor',blue);
                else
                    set(pipeKp1,'BackgroundColor',white);
                end
                
                % CJ2 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                if(tcurrent >= Qp2_ti && tcurrent <= Qp2_tf && Qp2 > 0)
                    set(pump2,'BackgroundColor',blue);
                    flagQp2 = 1;
                else
                    set(pump2,'BackgroundColor',white);
                    flagQp2 = 0;
                end
                
                if(f(2)==0)
                    set(frameKp2,'Visible','off');
                    if(dKp2==1)
                        flagKp2 = 1;
                    else
                        flagKp2 = 0;
                    end
                else
                    flagKp2 = 1;
                    if(dKp2==1)
                        set(frameKp2,'Visible','on','Position',[81 15 7*f(2) 2],'BackgroundColor',white);
                        if(f(2)==1)
                            flagKp2 = 0;
                        end
                    else
                        set(frameKp2,'Visible','on','Position',[81 15 7*f(2) 2],'BackgroundColor',blue);
                    end
                end
                
                if(flagQp2 && flagKp2)
                    set(pipeKp2,'BackgroundColor',blue);
                else
                    set(pipeKp2,'BackgroundColor',white);
                end
                
                % CJ3 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                if(x(1,k) > h0 || x(3,k) > h0)
                    flagTP13 = 1;
                else
                    flagTP13 = 0;
                end
                
                if(f(3)==0)
                    set(frameKa,'Visible','off');
                    if(dKa==1)
                        flagKa = 1;
                    else
                        flagKa = 0;
                    end
                else
                    flagKa = 1;
                    if(dKa==1)
                        set(frameKa,'Visible','on','Position',[28.5 10 7*f(3) 2],'BackgroundColor',white);
                        if(f(3)==1)
                            flagKa = 0;
                        end
                    else
                        set(frameKa,'Visible','on','Position',[28.5 10 7*f(3) 2],'BackgroundColor',blue);
                    end
                end
                
                if(flagTP13 && flagKa)
                    set(pipeKa,'BackgroundColor',blue);
                else
                    set(pipeKa,'BackgroundColor',white);
                end
                
                % CJ4 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                if(x(2,k) > h0 || x(3,k) > h0)
                    flagTP23 = 1;
                else
                    flagTP23 = 0;
                end
                
                if(f(4)==0)
                    set(frameKb,'Visible','off');
                    if(dKb==1)
                        flagKb = 1;
                    else
                        flagKb = 0;
                    end
                else
                    flagKb = 1;
                    if(dKb==1)
                        set(frameKb,'Visible','on','Position',[63.5 10 7*f(4) 2],'BackgroundColor',white);
                        if(f(4)==1)
                            flagKb = 0;
                        end
                    else
                        set(frameKb,'Visible','on','Position',[63.5 10 7*f(4) 2],'BackgroundColor',blue);
                    end
                end
                
                if(flagTP23 && flagKb)
                    set(pipeKb,'BackgroundColor',blue);
                else
                    set(pipeKb,'BackgroundColor',white);
                end
                
                % CJ5 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                if(x(1,k) > 0 || x(3,k) > 0)
                    flagCP13 = 1;
                else
                    flagCP13 = 0;
                end
                
                if(f(5)==0)
                    set(frameK13,'Visible','off');
                    if(dK13==1)
                        flagK13 = 1;
                    else
                        flagK13 = 0;
                    end
                else
                    flagK13 = 1;
                    if(dK13==1)
                        set(frameK13,'Visible','on','Position',[28.6 4.6 7*f(5) 2],'BackgroundColor',white);
                        if(f(5)==1)
                            flagK13 = 0;
                        end
                    else
                        set(frameK13,'Visible','on','Position',[28.6 4.6 7*f(5) 2],'BackgroundColor',blue);
                    end
                end
                
                if(flagCP13 && flagK13)
                    set(pipeK13,'BackgroundColor',blue);
                else
                    set(pipeK13,'BackgroundColor',white);
                end
                
                % CJ6 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                if(x(2,k) > 0 || x(3,k) > 0)
                    flagCP23 = 1;
                else
                    flagCP23 = 0;
                end
                
                if(f(6)==0)
                    set(frameK23,'Visible','off');
                    if(dK23==1)
                        flagK23 = 1;
                    else
                        flagK23 = 0;
                    end
                else
                    flagK23 = 1;
                    if(dK23==1)
                        set(frameK23,'Visible','on','Position',[63.6 4.6 7*f(6) 2],'BackgroundColor',white);
                        if(f(6)==1)
                            flagK23 = 0;
                        end
                    else
                        set(frameK23,'Visible','on','Position',[63.6 4.6 7*f(6) 2],'BackgroundColor',blue);
                    end
                end
                
                if(flagCP23 && flagK23)
                    set(pipeK23,'BackgroundColor',blue);
                else
                    set(pipeK23,'BackgroundColor',white);
                end
                
                % CJ7 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                if(x(1,k) > 0)
                    flagT1 = 1;
                else
                    flagT1 = 0;
                end
                
                if(f(7)==0)
                    set(frameK1,'Visible','off');
                    if(dK1==1)
                        flagK1 = 1;
                    else
                        flagK1 = 0;
                    end
                else
                    flagK1 = 1;
                    if(dK1==1)
                        set(frameK1,'Visible','on','Position',[11 2 7*f(7) 2],'BackgroundColor',white);
                        if(f(7)==1)
                            flagK1 = 0;
                        end
                    else
                        set(frameK1,'Visible','on','Position',[11 2 7*f(7) 2],'BackgroundColor',blue);
                    end
                end
                
                if(flagT1 && flagK1)
                    set(pipeK1,'BackgroundColor',blue);
                else
                    set(pipeK1,'BackgroundColor',white);
                end
                
                % CJ8 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                if(x(2,k) > 0)
                    flagT2 = 1;
                else
                    flagT2 = 0;
                end
                
                if(f(8)==0)
                    set(frameK2,'Visible','off');
                    if(dK2==1)
                        flagK2 = 1;
                    else
                        flagK2 = 0;
                    end
                else
                    flagK2 = 1;
                    if(dK2==1)
                        set(frameK2,'Visible','on','Position',[81 2 7*f(8) 2],'BackgroundColor',white);
                        if(f(8)==1)
                            flagK2 = 0;
                        end
                    else
                        set(frameK2,'Visible','on','Position',[81 2 7*f(8) 2],'BackgroundColor',blue);
                    end
                end
                
                if(flagT2 && flagK2)
                    set(pipeK2,'BackgroundColor',blue);
                else
                    set(pipeK2,'BackgroundColor',white);
                end
                
                % CJ9 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                if(x(3,k) > 0)
                    flagT3 = 1;
                else
                    flagT3 = 0;
                end
                
                if(f(9)==0)
                    set(frameK3,'Visible','off');
                    if(dK3==1)
                        flagK3 = 1;
                    else
                        flagK3 = 0;
                    end
                else
                    flagK3 = 1;
                    if(dK3==1)
                        set(frameK3,'Visible','on','Position',[46 2 7*f(9) 2],'BackgroundColor',white);
                        if(f(9)==1)
                            flagK3 = 0;
                        end
                    else
                        set(frameK3,'Visible','on','Position',[46 2 7*f(9) 2],'BackgroundColor',blue);
                    end
                end
                
                if(flagT3 && flagK3)
                    set(pipeK3,'BackgroundColor',blue);
                else
                    set(pipeK3,'BackgroundColor',white);
                end
                
                % end try +++++++++++++++++++++++++++++++++++++++++++++++++++++
            catch
                disp('#Finished');
            end
        end
        
    case '01'
        disp(' *Control system: NO');
        disp(' *FDI system: YES');
        disp('#Running Sim3Tanks...');
        
        for k = 1 : N
            
            if(ishandle(fig_stop))
                if get(btn_stop,'Value')
                    break;
                end
            else
                break;
            end
            
            drawnow;
            
            set_k(k); % Update current k
            
            f = get_faults(k); % Fault signal
            w = get_process_noise([w_mean w_std]); % Process noise
            v = get_output_noise([vlevel_mean vlevel_std], [vflow_mean vflow_std]); % Output noise
            
            Qp = get_pumps(k); % Flow from pumps
            
            % Three-tank system
            [y(:,k), x(:,k), q(:,k)] = three_tank_system_simulator(x0, u, f, w, v);
            
            % Control signal
            u = Qp;
            
            % A/D converter
            yk = y(:,k);
            uk = u;
            
            % FDI system
            [fout1(:,k),fout2(:,k),fout3(:,k),fout4(:,k),fout5(:,k)] = feval(func_fdi_system, uk, yk);
            
            % D/A converter
            u = uk;
            
            %% Real time animation
            
            try
                tcurrent = t(k);
                
                set(time,'String',num2str(tcurrent));
                set(yh1,'String',num2str(x(1,k)));
                set(yh2,'String',num2str(x(2,k)));
                set(yh3,'String',num2str(x(3,k)));
                set(yu1,'String',num2str(q(1,k)));
                set(yu2,'String',num2str(q(2,k)));
                set(yQa,'String',num2str(q(3,k)));
                set(yQb,'String',num2str(q(4,k)));
                set(yQ13,'String',num2str(q(5,k)));
                set(yQ23,'String',num2str(q(6,k)));
                set(yQ1,'String',num2str(q(7,k)));
                set(yQ2,'String',num2str(q(8,k)));
                set(yQ3,'String',num2str(q(9,k)));
                
                level = (9/Hmax)*mysaturation(x(:,k),0.1,Hmax);
                
                if (x(1,k) >= Hmax)
                    set(tank1,'Position',[07 05 15 level(1)],'BackgroundColor',fault);
                else
                    set(tank1,'Position',[07 05 15 level(1)],'BackgroundColor',blue);
                end
                
                if (x(2,k) >= Hmax)
                    set(tank2,'Position',[77 05 15 level(2)],'BackgroundColor',fault);
                else
                    set(tank2,'Position',[77 05 15 level(2)],'BackgroundColor',blue);
                end
                
                if (x(3,k) >= Hmax)
                    set(tank3,'Position',[42 05 15 level(3)],'BackgroundColor',fault);
                else
                    set(tank3,'Position',[42 05 15 level(3)],'BackgroundColor',blue);
                end
                
                % CJ1 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                if(tcurrent >= Qp1_ti && tcurrent <= Qp1_tf && Qp1 > 0)
                    set(pump1,'BackgroundColor',blue);
                    flagQp1 = 1;
                else
                    set(pump1,'BackgroundColor',white);
                    flagQp1 = 0;
                end
                
                if(f(1)==0)
                    set(frameKp1,'Visible','off');
                    if(dKp1==1)
                        flagKp1 = 1;
                    else
                        flagKp1 = 0;
                    end
                else
                    flagKp1 = 1;
                    if(dKp1==1)
                        set(frameKp1,'Visible','on','Position',[11 15 7*f(1) 2],'BackgroundColor',white);
                        if(f(1)==1)
                            flagKp1 = 0;
                        end
                    else
                        set(frameKp1,'Visible','on','Position',[11 15 7*f(1) 2],'BackgroundColor',blue);
                    end
                end
                
                if(flagQp1 && flagKp1)
                    set(pipeKp1,'BackgroundColor',blue);
                else
                    set(pipeKp1,'BackgroundColor',white);
                end
                
                % CJ2 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                if(tcurrent >= Qp2_ti && tcurrent <= Qp2_tf && Qp2 > 0)
                    set(pump2,'BackgroundColor',blue);
                    flagQp2 = 1;
                else
                    set(pump2,'BackgroundColor',white);
                    flagQp2 = 0;
                end
                
                if(f(2)==0)
                    set(frameKp2,'Visible','off');
                    if(dKp2==1)
                        flagKp2 = 1;
                    else
                        flagKp2 = 0;
                    end
                else
                    flagKp2 = 1;
                    if(dKp2==1)
                        set(frameKp2,'Visible','on','Position',[81 15 7*f(2) 2],'BackgroundColor',white);
                        if(f(2)==1)
                            flagKp2 = 0;
                        end
                    else
                        set(frameKp2,'Visible','on','Position',[81 15 7*f(2) 2],'BackgroundColor',blue);
                    end
                end
                
                if(flagQp2 && flagKp2)
                    set(pipeKp2,'BackgroundColor',blue);
                else
                    set(pipeKp2,'BackgroundColor',white);
                end
                
                % CJ3 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                if(x(1,k) > h0 || x(3,k) > h0)
                    flagTP13 = 1;
                else
                    flagTP13 = 0;
                end
                
                if(f(3)==0)
                    set(frameKa,'Visible','off');
                    if(dKa==1)
                        flagKa = 1;
                    else
                        flagKa = 0;
                    end
                else
                    flagKa = 1;
                    if(dKa==1)
                        set(frameKa,'Visible','on','Position',[28.5 10 7*f(3) 2],'BackgroundColor',white);
                        if(f(3)==1)
                            flagKa = 0;
                        end
                    else
                        set(frameKa,'Visible','on','Position',[28.5 10 7*f(3) 2],'BackgroundColor',blue);
                    end
                end
                
                if(flagTP13 && flagKa)
                    set(pipeKa,'BackgroundColor',blue);
                else
                    set(pipeKa,'BackgroundColor',white);
                end
                
                % CJ4 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                if(x(2,k) > h0 || x(3,k) > h0)
                    flagTP23 = 1;
                else
                    flagTP23 = 0;
                end
                
                if(f(4)==0)
                    set(frameKb,'Visible','off');
                    if(dKb==1)
                        flagKb = 1;
                    else
                        flagKb = 0;
                    end
                else
                    flagKb = 1;
                    if(dKb==1)
                        set(frameKb,'Visible','on','Position',[63.5 10 7*f(4) 2],'BackgroundColor',white);
                        if(f(4)==1)
                            flagKb = 0;
                        end
                    else
                        set(frameKb,'Visible','on','Position',[63.5 10 7*f(4) 2],'BackgroundColor',blue);
                    end
                end
                
                if(flagTP23 && flagKb)
                    set(pipeKb,'BackgroundColor',blue);
                else
                    set(pipeKb,'BackgroundColor',white);
                end
                
                % CJ5 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                if(x(1,k) > 0 || x(3,k) > 0)
                    flagCP13 = 1;
                else
                    flagCP13 = 0;
                end
                
                if(f(5)==0)
                    set(frameK13,'Visible','off');
                    if(dK13==1)
                        flagK13 = 1;
                    else
                        flagK13 = 0;
                    end
                else
                    flagK13 = 1;
                    if(dK13==1)
                        set(frameK13,'Visible','on','Position',[28.6 4.6 7*f(5) 2],'BackgroundColor',white);
                        if(f(5)==1)
                            flagK13 = 0;
                        end
                    else
                        set(frameK13,'Visible','on','Position',[28.6 4.6 7*f(5) 2],'BackgroundColor',blue);
                    end
                end
                
                if(flagCP13 && flagK13)
                    set(pipeK13,'BackgroundColor',blue);
                else
                    set(pipeK13,'BackgroundColor',white);
                end
                
                % CJ6 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                if(x(2,k) > 0 || x(3,k) > 0)
                    flagCP23 = 1;
                else
                    flagCP23 = 0;
                end
                
                if(f(6)==0)
                    set(frameK23,'Visible','off');
                    if(dK23==1)
                        flagK23 = 1;
                    else
                        flagK23 = 0;
                    end
                else
                    flagK23 = 1;
                    if(dK23==1)
                        set(frameK23,'Visible','on','Position',[63.6 4.6 7*f(6) 2],'BackgroundColor',white);
                        if(f(6)==1)
                            flagK23 = 0;
                        end
                    else
                        set(frameK23,'Visible','on','Position',[63.6 4.6 7*f(6) 2],'BackgroundColor',blue);
                    end
                end
                
                if(flagCP23 && flagK23)
                    set(pipeK23,'BackgroundColor',blue);
                else
                    set(pipeK23,'BackgroundColor',white);
                end
                
                % CJ7 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                if(x(1,k) > 0)
                    flagT1 = 1;
                else
                    flagT1 = 0;
                end
                
                if(f(7)==0)
                    set(frameK1,'Visible','off');
                    if(dK1==1)
                        flagK1 = 1;
                    else
                        flagK1 = 0;
                    end
                else
                    flagK1 = 1;
                    if(dK1==1)
                        set(frameK1,'Visible','on','Position',[11 2 7*f(7) 2],'BackgroundColor',white);
                        if(f(7)==1)
                            flagK1 = 0;
                        end
                    else
                        set(frameK1,'Visible','on','Position',[11 2 7*f(7) 2],'BackgroundColor',blue);
                    end
                end
                
                if(flagT1 && flagK1)
                    set(pipeK1,'BackgroundColor',blue);
                else
                    set(pipeK1,'BackgroundColor',white);
                end
                
                % CJ8 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                if(x(2,k) > 0)
                    flagT2 = 1;
                else
                    flagT2 = 0;
                end
                
                if(f(8)==0)
                    set(frameK2,'Visible','off');
                    if(dK2==1)
                        flagK2 = 1;
                    else
                        flagK2 = 0;
                    end
                else
                    flagK2 = 1;
                    if(dK2==1)
                        set(frameK2,'Visible','on','Position',[81 2 7*f(8) 2],'BackgroundColor',white);
                        if(f(8)==1)
                            flagK2 = 0;
                        end
                    else
                        set(frameK2,'Visible','on','Position',[81 2 7*f(8) 2],'BackgroundColor',blue);
                    end
                end
                
                if(flagT2 && flagK2)
                    set(pipeK2,'BackgroundColor',blue);
                else
                    set(pipeK2,'BackgroundColor',white);
                end
                
                % CJ9 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                if(x(3,k) > 0)
                    flagT3 = 1;
                else
                    flagT3 = 0;
                end
                
                if(f(9)==0)
                    set(frameK3,'Visible','off');
                    if(dK3==1)
                        flagK3 = 1;
                    else
                        flagK3 = 0;
                    end
                else
                    flagK3 = 1;
                    if(dK3==1)
                        set(frameK3,'Visible','on','Position',[46 2 7*f(9) 2],'BackgroundColor',white);
                        if(f(9)==1)
                            flagK3 = 0;
                        end
                    else
                        set(frameK3,'Visible','on','Position',[46 2 7*f(9) 2],'BackgroundColor',blue);
                    end
                end
                
                if(flagT3 && flagK3)
                    set(pipeK3,'BackgroundColor',blue);
                else
                    set(pipeK3,'BackgroundColor',white);
                end
                
                % end try +++++++++++++++++++++++++++++++++++++++++++++++++++++
            catch
                disp('#Finished');
            end
        end
        
    case '10'
        disp(' *Control system: YES');
        disp(' *FDI system: NO');
        disp('#Running Sim3Tanks...');
        
        for k = 1 : N
            
            if(ishandle(fig_stop))
                if get(btn_stop,'Value')
                    break;
                end
            else
                break;
            end
            
            drawnow;
            
            set_k(k); % Update current k
            
            f = get_faults(k); % Fault signal
            w = get_process_noise([w_mean w_std]); % Process noise
            v = get_output_noise([vlevel_mean vlevel_std], [vflow_mean vflow_std]); % Output noise
            
            Qp = get_pumps(k); % Flow from pumps
            
            % Three-tank system
            [y(:,k), x(:,k), q(:,k)] = three_tank_system_simulator(x0, u, f, w, v);
            
            % A/D converter
            yk = y(:,k);
            
            % Digital control system
            [cout1(:,k),cout2(:,k),cout3(:,k)] = feval(func_control_system, setpoint, Qp, yk);
            
            uk = cout1(:,k);
            
            % D/A converter
            u = uk;
            
            %% Real time animation
            
            try
                tcurrent = t(k);
                
                set(time,'String',num2str(tcurrent));
                set(yh1,'String',num2str(x(1,k)));
                set(yh2,'String',num2str(x(2,k)));
                set(yh3,'String',num2str(x(3,k)));
                set(yu1,'String',num2str(q(1,k)));
                set(yu2,'String',num2str(q(2,k)));
                set(yQa,'String',num2str(q(3,k)));
                set(yQb,'String',num2str(q(4,k)));
                set(yQ13,'String',num2str(q(5,k)));
                set(yQ23,'String',num2str(q(6,k)));
                set(yQ1,'String',num2str(q(7,k)));
                set(yQ2,'String',num2str(q(8,k)));
                set(yQ3,'String',num2str(q(9,k)));
                
                level = (9/Hmax)*mysaturation(x(:,k),0.1,Hmax);
                
                if (x(1,k) >= Hmax)
                    set(tank1,'Position',[07 05 15 level(1)],'BackgroundColor',fault);
                else
                    set(tank1,'Position',[07 05 15 level(1)],'BackgroundColor',blue);
                end
                
                if (x(2,k) >= Hmax)
                    set(tank2,'Position',[77 05 15 level(2)],'BackgroundColor',fault);
                else
                    set(tank2,'Position',[77 05 15 level(2)],'BackgroundColor',blue);
                end
                
                if (x(3,k) >= Hmax)
                    set(tank3,'Position',[42 05 15 level(3)],'BackgroundColor',fault);
                else
                    set(tank3,'Position',[42 05 15 level(3)],'BackgroundColor',blue);
                end
                
                % CJ1 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                if(tcurrent >= Qp1_ti && tcurrent <= Qp1_tf && Qp1 > 0)
                    if(uk(1) >= Qp1)
                        set(pump1,'BackgroundColor',fault);
                    else
                        set(pump1,'BackgroundColor',blue);
                    end
                    flagQp1 = 1;
                else
                    set(pump1,'BackgroundColor',white);
                    flagQp1 = 0;
                end
                
                if(f(1)==0)
                    set(frameKp1,'Visible','off');
                    if(dKp1==1)
                        flagKp1 = 1;
                    else
                        flagKp1 = 0;
                    end
                else
                    flagKp1 = 1;
                    if(dKp1==1)
                        set(frameKp1,'Visible','on','Position',[11 15 7*f(1) 2],'BackgroundColor',white);
                        if(f(1)==1)
                            flagKp1 = 0;
                        end
                    else
                        set(frameKp1,'Visible','on','Position',[11 15 7*f(1) 2],'BackgroundColor',blue);
                    end
                end
                
                if(flagQp1 && flagKp1)
                    set(pipeKp1,'BackgroundColor',blue);
                else
                    set(pipeKp1,'BackgroundColor',white);
                end
                
                % CJ2 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                if(tcurrent >= Qp2_ti && tcurrent <= Qp2_tf && Qp2 > 0)
                    if(uk(2) >= Qp2)
                        set(pump2,'BackgroundColor',fault);
                    else
                        set(pump2,'BackgroundColor',blue);
                    end
                    flagQp2 = 1;
                else
                    set(pump2,'BackgroundColor',white);
                    flagQp2 = 0;
                end
                
                if(f(2)==0)
                    set(frameKp2,'Visible','off');
                    if(dKp2==1)
                        flagKp2 = 1;
                    else
                        flagKp2 = 0;
                    end
                else
                    flagKp2 = 1;
                    if(dKp2==1)
                        set(frameKp2,'Visible','on','Position',[81 15 7*f(2) 2],'BackgroundColor',white);
                        if(f(2)==1)
                            flagKp2 = 0;
                        end
                    else
                        set(frameKp2,'Visible','on','Position',[81 15 7*f(2) 2],'BackgroundColor',blue);
                    end
                end
                
                if(flagQp2 && flagKp2)
                    set(pipeKp2,'BackgroundColor',blue);
                else
                    set(pipeKp2,'BackgroundColor',white);
                end
                
                % CJ3 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                if(x(1,k) > h0 || x(3,k) > h0)
                    flagTP13 = 1;
                else
                    flagTP13 = 0;
                end
                
                if(f(3)==0)
                    set(frameKa,'Visible','off');
                    if(dKa==1)
                        flagKa = 1;
                    else
                        flagKa = 0;
                    end
                else
                    flagKa = 1;
                    if(dKa==1)
                        set(frameKa,'Visible','on','Position',[28.5 10 7*f(3) 2],'BackgroundColor',white);
                        if(f(3)==1)
                            flagKa = 0;
                        end
                    else
                        set(frameKa,'Visible','on','Position',[28.5 10 7*f(3) 2],'BackgroundColor',blue);
                    end
                end
                
                if(flagTP13 && flagKa)
                    set(pipeKa,'BackgroundColor',blue);
                else
                    set(pipeKa,'BackgroundColor',white);
                end
                
                % CJ4 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                if(x(2,k) > h0 || x(3,k) > h0)
                    flagTP23 = 1;
                else
                    flagTP23 = 0;
                end
                
                if(f(4)==0)
                    set(frameKb,'Visible','off');
                    if(dKb==1)
                        flagKb = 1;
                    else
                        flagKb = 0;
                    end
                else
                    flagKb = 1;
                    if(dKb==1)
                        set(frameKb,'Visible','on','Position',[63.5 10 7*f(4) 2],'BackgroundColor',white);
                        if(f(4)==1)
                            flagKb = 0;
                        end
                    else
                        set(frameKb,'Visible','on','Position',[63.5 10 7*f(4) 2],'BackgroundColor',blue);
                    end
                end
                
                if(flagTP23 && flagKb)
                    set(pipeKb,'BackgroundColor',blue);
                else
                    set(pipeKb,'BackgroundColor',white);
                end
                
                % CJ5 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                if(x(1,k) > 0 || x(3,k) > 0)
                    flagCP13 = 1;
                else
                    flagCP13 = 0;
                end
                
                if(f(5)==0)
                    set(frameK13,'Visible','off');
                    if(dK13==1)
                        flagK13 = 1;
                    else
                        flagK13 = 0;
                    end
                else
                    flagK13 = 1;
                    if(dK13==1)
                        set(frameK13,'Visible','on','Position',[28.6 4.6 7*f(5) 2],'BackgroundColor',white);
                        if(f(5)==1)
                            flagK13 = 0;
                        end
                    else
                        set(frameK13,'Visible','on','Position',[28.6 4.6 7*f(5) 2],'BackgroundColor',blue);
                    end
                end
                
                if(flagCP13 && flagK13)
                    set(pipeK13,'BackgroundColor',blue);
                else
                    set(pipeK13,'BackgroundColor',white);
                end
                
                % CJ6 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                if(x(2,k) > 0 || x(3,k) > 0)
                    flagCP23 = 1;
                else
                    flagCP23 = 0;
                end
                
                if(f(6)==0)
                    set(frameK23,'Visible','off');
                    if(dK23==1)
                        flagK23 = 1;
                    else
                        flagK23 = 0;
                    end
                else
                    flagK23 = 1;
                    if(dK23==1)
                        set(frameK23,'Visible','on','Position',[63.6 4.6 7*f(6) 2],'BackgroundColor',white);
                        if(f(6)==1)
                            flagK23 = 0;
                        end
                    else
                        set(frameK23,'Visible','on','Position',[63.6 4.6 7*f(6) 2],'BackgroundColor',blue);
                    end
                end
                
                if(flagCP23 && flagK23)
                    set(pipeK23,'BackgroundColor',blue);
                else
                    set(pipeK23,'BackgroundColor',white);
                end
                
                % CJ7 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                if(x(1,k) > 0)
                    flagT1 = 1;
                else
                    flagT1 = 0;
                end
                
                if(f(7)==0)
                    set(frameK1,'Visible','off');
                    if(dK1==1)
                        flagK1 = 1;
                    else
                        flagK1 = 0;
                    end
                else
                    flagK1 = 1;
                    if(dK1==1)
                        set(frameK1,'Visible','on','Position',[11 2 7*f(7) 2],'BackgroundColor',white);
                        if(f(7)==1)
                            flagK1 = 0;
                        end
                    else
                        set(frameK1,'Visible','on','Position',[11 2 7*f(7) 2],'BackgroundColor',blue);
                    end
                end
                
                if(flagT1 && flagK1)
                    set(pipeK1,'BackgroundColor',blue);
                else
                    set(pipeK1,'BackgroundColor',white);
                end
                
                % CJ8 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                if(x(2,k) > 0)
                    flagT2 = 1;
                else
                    flagT2 = 0;
                end
                
                if(f(8)==0)
                    set(frameK2,'Visible','off');
                    if(dK2==1)
                        flagK2 = 1;
                    else
                        flagK2 = 0;
                    end
                else
                    flagK2 = 1;
                    if(dK2==1)
                        set(frameK2,'Visible','on','Position',[81 2 7*f(8) 2],'BackgroundColor',white);
                        if(f(8)==1)
                            flagK2 = 0;
                        end
                    else
                        set(frameK2,'Visible','on','Position',[81 2 7*f(8) 2],'BackgroundColor',blue);
                    end
                end
                
                if(flagT2 && flagK2)
                    set(pipeK2,'BackgroundColor',blue);
                else
                    set(pipeK2,'BackgroundColor',white);
                end
                
                % CJ9 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                if(x(3,k) > 0)
                    flagT3 = 1;
                else
                    flagT3 = 0;
                end
                
                if(f(9)==0)
                    set(frameK3,'Visible','off');
                    if(dK3==1)
                        flagK3 = 1;
                    else
                        flagK3 = 0;
                    end
                else
                    flagK3 = 1;
                    if(dK3==1)
                        set(frameK3,'Visible','on','Position',[46 2 7*f(9) 2],'BackgroundColor',white);
                        if(f(9)==1)
                            flagK3 = 0;
                        end
                    else
                        set(frameK3,'Visible','on','Position',[46 2 7*f(9) 2],'BackgroundColor',blue);
                    end
                end
                
                if(flagT3 && flagK3)
                    set(pipeK3,'BackgroundColor',blue);
                else
                    set(pipeK3,'BackgroundColor',white);
                end
                
                % end try +++++++++++++++++++++++++++++++++++++++++++++++++++++
            catch
                disp('#Finished');
            end
        end
        
    case '11'
        disp(' *Control system: YES');
        disp(' *FDI system: YES');
        disp('#Running Sim3Tanks...');
        
        for k = 1 : N
            
            if(ishandle(fig_stop))
                if get(btn_stop,'Value')
                    break;
                end
            else
                break;
            end
            
            drawnow;
            
            set_k(k); % Update current k
            
            f = get_faults(k); % Fault signal
            w = get_process_noise([w_mean w_std]); % Process noise
            v = get_output_noise([vlevel_mean vlevel_std], [vflow_mean vflow_std]); % Output noise
            
            Qp = get_pumps(k); % Flow from pumps
            
            % Three-tank system
            [y(:,k), x(:,k), q(:,k)] = three_tank_system_simulator(x0, u, f, w, v);
            
            % A/D converter
            yk = y(:,k);
            
            % Digital control system
            [cout1(:,k),cout2(:,k),cout3(:,k)] = feval(func_control_system, setpoint, Qp, yk);
            
            uk = cout1(:,k);
            
            % FDI system
            [fout1(:,k),fout2(:,k),fout3(:,k),fout4(:,k),fout5(:,k)] = feval(func_fdi_system, uk, yk);
            
            % D/A converter
            u = uk;
            
            %% Real time animation
            
            try
                tcurrent = t(k);
                
                set(time,'String',num2str(tcurrent));
                set(yh1,'String',num2str(x(1,k)));
                set(yh2,'String',num2str(x(2,k)));
                set(yh3,'String',num2str(x(3,k)));
                set(yu1,'String',num2str(q(1,k)));
                set(yu2,'String',num2str(q(2,k)));
                set(yQa,'String',num2str(q(3,k)));
                set(yQb,'String',num2str(q(4,k)));
                set(yQ13,'String',num2str(q(5,k)));
                set(yQ23,'String',num2str(q(6,k)));
                set(yQ1,'String',num2str(q(7,k)));
                set(yQ2,'String',num2str(q(8,k)));
                set(yQ3,'String',num2str(q(9,k)));
                
                level = (9/Hmax)*mysaturation(x(:,k),0.1,Hmax);
                
                if (x(1,k) >= Hmax)
                    set(tank1,'Position',[07 05 15 level(1)],'BackgroundColor',fault);
                else
                    set(tank1,'Position',[07 05 15 level(1)],'BackgroundColor',blue);
                end
                
                if (x(2,k) >= Hmax)
                    set(tank2,'Position',[77 05 15 level(2)],'BackgroundColor',fault);
                else
                    set(tank2,'Position',[77 05 15 level(2)],'BackgroundColor',blue);
                end
                
                if (x(3,k) >= Hmax)
                    set(tank3,'Position',[42 05 15 level(3)],'BackgroundColor',fault);
                else
                    set(tank3,'Position',[42 05 15 level(3)],'BackgroundColor',blue);
                end
                
                % CJ1 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                if(tcurrent >= Qp1_ti && tcurrent <= Qp1_tf && Qp1 > 0)
                    if(uk(1) >= Qp1)
                        set(pump1,'BackgroundColor',fault);
                    else
                        set(pump1,'BackgroundColor',blue);
                    end
                    flagQp1 = 1;
                else
                    set(pump1,'BackgroundColor',white);
                    flagQp1 = 0;
                end
                
                if(f(1)==0)
                    set(frameKp1,'Visible','off');
                    if(dKp1==1)
                        flagKp1 = 1;
                    else
                        flagKp1 = 0;
                    end
                else
                    flagKp1 = 1;
                    if(dKp1==1)
                        set(frameKp1,'Visible','on','Position',[11 15 7*f(1) 2],'BackgroundColor',white);
                        if(f(1)==1)
                            flagKp1 = 0;
                        end
                    else
                        set(frameKp1,'Visible','on','Position',[11 15 7*f(1) 2],'BackgroundColor',blue);
                    end
                end
                
                if(flagQp1 && flagKp1)
                    set(pipeKp1,'BackgroundColor',blue);
                else
                    set(pipeKp1,'BackgroundColor',white);
                end
                
                % CJ2 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                if(tcurrent >= Qp2_ti && tcurrent <= Qp2_tf && Qp2 > 0)
                    if(uk(2) >= Qp2)
                        set(pump2,'BackgroundColor',fault);
                    else
                        set(pump2,'BackgroundColor',blue);
                    end
                    flagQp2 = 1;
                else
                    set(pump2,'BackgroundColor',white);
                    flagQp2 = 0;
                end
                
                if(f(2)==0)
                    set(frameKp2,'Visible','off');
                    if(dKp2==1)
                        flagKp2 = 1;
                    else
                        flagKp2 = 0;
                    end
                else
                    flagKp2 = 1;
                    if(dKp2==1)
                        set(frameKp2,'Visible','on','Position',[81 15 7*f(2) 2],'BackgroundColor',white);
                        if(f(2)==1)
                            flagKp2 = 0;
                        end
                    else
                        set(frameKp2,'Visible','on','Position',[81 15 7*f(2) 2],'BackgroundColor',blue);
                    end
                end
                
                if(flagQp2 && flagKp2)
                    set(pipeKp2,'BackgroundColor',blue);
                else
                    set(pipeKp2,'BackgroundColor',white);
                end
                
                % CJ3 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                if(x(1,k) > h0 || x(3,k) > h0)
                    flagTP13 = 1;
                else
                    flagTP13 = 0;
                end
                
                if(f(3)==0)
                    set(frameKa,'Visible','off');
                    if(dKa==1)
                        flagKa = 1;
                    else
                        flagKa = 0;
                    end
                else
                    flagKa = 1;
                    if(dKa==1)
                        set(frameKa,'Visible','on','Position',[28.5 10 7*f(3) 2],'BackgroundColor',white);
                        if(f(3)==1)
                            flagKa = 0;
                        end
                    else
                        set(frameKa,'Visible','on','Position',[28.5 10 7*f(3) 2],'BackgroundColor',blue);
                    end
                end
                
                if(flagTP13 && flagKa)
                    set(pipeKa,'BackgroundColor',blue);
                else
                    set(pipeKa,'BackgroundColor',white);
                end
                
                % CJ4 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                if(x(2,k) > h0 || x(3,k) > h0)
                    flagTP23 = 1;
                else
                    flagTP23 = 0;
                end
                
                if(f(4)==0)
                    set(frameKb,'Visible','off');
                    if(dKb==1)
                        flagKb = 1;
                    else
                        flagKb = 0;
                    end
                else
                    flagKb = 1;
                    if(dKb==1)
                        set(frameKb,'Visible','on','Position',[63.5 10 7*f(4) 2],'BackgroundColor',white);
                        if(f(4)==1)
                            flagKb = 0;
                        end
                    else
                        set(frameKb,'Visible','on','Position',[63.5 10 7*f(4) 2],'BackgroundColor',blue);
                    end
                end
                
                if(flagTP23 && flagKb)
                    set(pipeKb,'BackgroundColor',blue);
                else
                    set(pipeKb,'BackgroundColor',white);
                end
                
                % CJ5 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                if(x(1,k) > 0 || x(3,k) > 0)
                    flagCP13 = 1;
                else
                    flagCP13 = 0;
                end
                
                if(f(5)==0)
                    set(frameK13,'Visible','off');
                    if(dK13==1)
                        flagK13 = 1;
                    else
                        flagK13 = 0;
                    end
                else
                    flagK13 = 1;
                    if(dK13==1)
                        set(frameK13,'Visible','on','Position',[28.6 4.6 7*f(5) 2],'BackgroundColor',white);
                        if(f(5)==1)
                            flagK13 = 0;
                        end
                    else
                        set(frameK13,'Visible','on','Position',[28.6 4.6 7*f(5) 2],'BackgroundColor',blue);
                    end
                end
                
                if(flagCP13 && flagK13)
                    set(pipeK13,'BackgroundColor',blue);
                else
                    set(pipeK13,'BackgroundColor',white);
                end
                
                % CJ6 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                if(x(2,k) > 0 || x(3,k) > 0)
                    flagCP23 = 1;
                else
                    flagCP23 = 0;
                end
                
                if(f(6)==0)
                    set(frameK23,'Visible','off');
                    if(dK23==1)
                        flagK23 = 1;
                    else
                        flagK23 = 0;
                    end
                else
                    flagK23 = 1;
                    if(dK23==1)
                        set(frameK23,'Visible','on','Position',[63.6 4.6 7*f(6) 2],'BackgroundColor',white);
                        if(f(6)==1)
                            flagK23 = 0;
                        end
                    else
                        set(frameK23,'Visible','on','Position',[63.6 4.6 7*f(6) 2],'BackgroundColor',blue);
                    end
                end
                
                if(flagCP23 && flagK23)
                    set(pipeK23,'BackgroundColor',blue);
                else
                    set(pipeK23,'BackgroundColor',white);
                end
                
                % CJ7 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                if(x(1,k) > 0)
                    flagT1 = 1;
                else
                    flagT1 = 0;
                end
                
                if(f(7)==0)
                    set(frameK1,'Visible','off');
                    if(dK1==1)
                        flagK1 = 1;
                    else
                        flagK1 = 0;
                    end
                else
                    flagK1 = 1;
                    if(dK1==1)
                        set(frameK1,'Visible','on','Position',[11 2 7*f(7) 2],'BackgroundColor',white);
                        if(f(7)==1)
                            flagK1 = 0;
                        end
                    else
                        set(frameK1,'Visible','on','Position',[11 2 7*f(7) 2],'BackgroundColor',blue);
                    end
                end
                
                if(flagT1 && flagK1)
                    set(pipeK1,'BackgroundColor',blue);
                else
                    set(pipeK1,'BackgroundColor',white);
                end
                
                % CJ8 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                if(x(2,k) > 0)
                    flagT2 = 1;
                else
                    flagT2 = 0;
                end
                
                if(f(8)==0)
                    set(frameK2,'Visible','off');
                    if(dK2==1)
                        flagK2 = 1;
                    else
                        flagK2 = 0;
                    end
                else
                    flagK2 = 1;
                    if(dK2==1)
                        set(frameK2,'Visible','on','Position',[81 2 7*f(8) 2],'BackgroundColor',white);
                        if(f(8)==1)
                            flagK2 = 0;
                        end
                    else
                        set(frameK2,'Visible','on','Position',[81 2 7*f(8) 2],'BackgroundColor',blue);
                    end
                end
                
                if(flagT2 && flagK2)
                    set(pipeK2,'BackgroundColor',blue);
                else
                    set(pipeK2,'BackgroundColor',white);
                end
                
                % CJ9 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                if(x(3,k) > 0)
                    flagT3 = 1;
                else
                    flagT3 = 0;
                end
                
                if(f(9)==0)
                    set(frameK3,'Visible','off');
                    if(dK3==1)
                        flagK3 = 1;
                    else
                        flagK3 = 0;
                    end
                else
                    flagK3 = 1;
                    if(dK3==1)
                        set(frameK3,'Visible','on','Position',[46 2 7*f(9) 2],'BackgroundColor',white);
                        if(f(9)==1)
                            flagK3 = 0;
                        end
                    else
                        set(frameK3,'Visible','on','Position',[46 2 7*f(9) 2],'BackgroundColor',blue);
                    end
                end
                
                if(flagT3 && flagK3)
                    set(pipeK3,'BackgroundColor',blue);
                else
                    set(pipeK3,'BackgroundColor',white);
                end
                
                % end try +++++++++++++++++++++++++++++++++++++++++++++++++++++
            catch
                disp('#Finished');
            end
        end
end

if ishandle(findobj('Tag','main_figure'))
    set(handles.btn_run_simulation,'String','Run simulation','Enable','on');
    set(handles.btn_reset,'String','Reset','Enable','on');
    drawnow;
end

if ishandle(fig_stop)
    
    btn_stop  = findobj('Tag','btn_stop_simulation');
    btn_close = findobj('Tag','btn_close_rt');
    
    if ~get(btn_stop,'Value')
        
        set(btn_stop,'Value',1,'Enable','off','Visible','off');
        set(btn_close,'Visible','on');
        
        set(handles.btn_plot_levels,'BackgroundColor',get_color('open'),'Enable','on');
        set(handles.btn_plot_flows,'BackgroundColor',get_color('open'),'Enable','on');
        set(handles.btn_plot_valves,'BackgroundColor',get_color('open'),'Enable','on');
        set(handles.btn_plot_faults,'BackgroundColor',get_color('open'),'Enable','on');
        
        drawnow;
        
        f = get_faults();
        K = get_valves_state();
        
        disp('#Exporting data to workspace...');
        
        export_to_ws('time',t,'levels',x,'flows',q,'measurements',y,'faults',f,'valves',K);
        
        if include_control_system
            export_to_ws('cout1',cout1,'cout2',cout2,'cout3',cout3);
        end
        
        if include_fdi_system
            export_to_ws('fout1',fout1,'fout2',fout2,'fout3',fout3,'fout4',fout4,'fout5',fout5);
        end
        
        %% Axes
        N  = length(t);
        N1 = round(N/4);
        N2 = round(N1/2);
        N3 = round((N1+N2)/2);
        
        axes(handles.axes1);
        hold off;
        plot(t,x(1,:),'-o','MarkerIndices',01:N1:N);
        hold on;
        plot(t,x(2,:),'-s','MarkerIndices',N2:N1:N);
        plot(t,x(3,:),'-^','MarkerIndices',N3:N1:N);
        xlabel('time (s)','Fontsize',8);
        ylabel('real level (cm)','Fontsize',8);
        xlim([t(1) t(N)]);
        
        disp('#Done!');
        
        set(fig_stop,'Name','Simulation done');
        
    else
        % Axes
        axes(handles.axes1);
        hold off;
        plot(0,0);
        xlabel('time','Fontsize',8);
        ylabel('magnitude','Fontsize',8);
    end
    
end



%% Reset ******************************************************************

function btn_reset_Callback(~, ~, handles)

delete(findobj('Tag','see_dynamic_figure'));

set(handles.output,'HandleVisibility','off');
close all; clc; clear -regexp \d;
set(handles.output,'HandleVisibility','on');

[param,hi,pump1,pump2,noise,tsim,controlsys,fdisys,fault,dK,plots] = get_default_param();

%% Parameters
set(handles.edit_RR,'String',num2str(param(1)));
set(handles.edit_Hmax,'String',num2str(param(2)));
set(handles.edit_r,'String',num2str(param(3)));
set(handles.edit_h0,'String',num2str(param(4)));
set(handles.edit_mi,'String',num2str(param(5)));
set(handles.edit_g,'String',num2str(param(6)));

%% Initial conditions
set(handles.edit_hi1,'String',num2str(hi(1)));
set(handles.edit_hi2,'String',num2str(hi(2)));
set(handles.edit_hi3,'String',num2str(hi(3)));

%% Pump P1
set(handles.edit_Qp1,'String',num2str(pump1(2)));
set(handles.edit_Qp1_ti,'String',num2str(pump1(3)));
set(handles.edit_Qp1_tf,'String',num2str(pump1(4)));

%% Pump P2
set(handles.edit_Qp2,'String',num2str(pump2(2)));
set(handles.edit_Qp2_ti,'String',num2str(pump2(3)));
set(handles.edit_Qp2_tf,'String',num2str(pump2(4)));

%% White noise
set(handles.edit_w_mean,'String',num2str(noise(1)));
set(handles.edit_w_std,'String',num2str(noise(2)));
set(handles.edit_vlevel_mean,'String',num2str(noise(3)));
set(handles.edit_vlevel_std,'String',num2str(noise(4)));
set(handles.edit_vflow_mean,'String',num2str(noise(5)));
set(handles.edit_vflow_std,'String',num2str(noise(6)));

%% Simulation time
set(handles.edit_time,'String',num2str(tsim(2)));

str = 'Function name';
e = 'off';

%% Control system
set(handles.cbox_control_system,'Value',controlsys(1));
set(handles.edit_control_system,'String',str,'Enable',e);
set(handles.edit_setpoint,'String',num2str(controlsys(2)),'Enable',e);

%% FDI system
set(handles.cbox_fdi_system,'Value',fdisys(1));
set(handles.edit_fdi_system,'String',str,'Enable',e);
set(handles.edit_Ts,'String',num2str(fdisys(2)),'Enable',e);

%% Fault signals
fon = num2str(fault(1));

set(handles.pf1,'Title',strcat('F1=',fon));
set(handles.pf2,'Title',strcat('F2=',fon));
set(handles.pf3,'Title',strcat('F3=',fon));
set(handles.pf4,'Title',strcat('F4=',fon));
set(handles.pf5,'Title',strcat('F5=',fon));
set(handles.pf6,'Title',strcat('F6=',fon));
set(handles.pf7,'Title',strcat('F7=',fon));
set(handles.pf8,'Title',strcat('F8=',fon));
set(handles.pf9,'Title',strcat('F9=',fon));
set(handles.pf10,'Title',strcat('F10=',fon));
set(handles.pf11,'Title',strcat('F11=',fon));
set(handles.pf12,'Title',strcat('F12=',fon));
set(handles.pf13,'Title',strcat('F13=',fon));
set(handles.pf14,'Title',strcat('F14=',fon));
set(handles.pf15,'Title',strcat('F15=',fon));
set(handles.pf16,'Title',strcat('F16=',fon));
set(handles.pf17,'Title',strcat('F17=',fon));
set(handles.pf18,'Title',strcat('F18=',fon));
set(handles.pf19,'Title',strcat('F19=',fon));
set(handles.pf20,'Title',strcat('F20=',fon));
set(handles.pf21,'Title',strcat('F21=',fon));

bkg = get_color('normal');

f1tip = 'F1: Actuator fault 1 (Valve Kp1)';
f2tip = 'F2: Actuator fault 2 (Valve Kp2)';
f3tip = 'F3: Leakage through the transmission pipe from tank 1 to tank 3 (Valve Ka)';
f4tip = 'F4: Leakage through the transmission pipe from tank 2 to tank 3 (Valve Kb)';
f5tip = 'F5: Clogging in the connection pipe from tank 1 to tank 3 (Valve K13)';
f6tip = 'F6: Clogging in the connection pipe from tank 2 to tank 3 (Valve K23)';
f7tip = 'F7: Leakage in tank 1 (Valve K1)';
f8tip = 'F8: Leakage in tank 2 (Valve K2)';
f9tip = 'F9: Clogging in output pipe of the tank 3 (Valve K3)';

set(handles.btn_f1,'BackgroundColor',bkg,'TooltipString',f1tip,'Value',fault(1));
set(handles.btn_f2,'BackgroundColor',bkg,'TooltipString',f2tip,'Value',fault(1));
set(handles.btn_f3,'BackgroundColor',bkg,'TooltipString',f3tip,'Value',fault(1));
set(handles.btn_f4,'BackgroundColor',bkg,'TooltipString',f4tip,'Value',fault(1));
set(handles.btn_f5,'BackgroundColor',bkg,'TooltipString',f5tip,'Value',fault(1));
set(handles.btn_f6,'BackgroundColor',bkg,'TooltipString',f6tip,'Value',fault(1));
set(handles.btn_f7,'BackgroundColor',bkg,'TooltipString',f7tip,'Value',fault(1));
set(handles.btn_f8,'BackgroundColor',bkg,'TooltipString',f8tip,'Value',fault(1));
set(handles.btn_f9,'BackgroundColor',bkg,'TooltipString',f9tip,'Value',fault(1));
set(handles.btn_f10,'BackgroundColor',bkg,'Value',fault(1));
set(handles.btn_f11,'BackgroundColor',bkg,'Value',fault(1));
set(handles.btn_f12,'BackgroundColor',bkg,'Value',fault(1));
set(handles.btn_f13,'BackgroundColor',bkg,'Value',fault(1));
set(handles.btn_f14,'BackgroundColor',bkg,'Value',fault(1));
set(handles.btn_f15,'BackgroundColor',bkg,'Value',fault(1));
set(handles.btn_f16,'BackgroundColor',bkg,'Value',fault(1));
set(handles.btn_f17,'BackgroundColor',bkg,'Value',fault(1));
set(handles.btn_f18,'BackgroundColor',bkg,'Value',fault(1));
set(handles.btn_f19,'BackgroundColor',bkg,'Value',fault(1));
set(handles.btn_f20,'BackgroundColor',bkg,'Value',fault(1));
set(handles.btn_f21,'BackgroundColor',bkg,'Value',fault(1));

str = 'Step | Drift';
bkg = get_color('step');

set(handles.btn_f1_type, 'String',str,'BackgroundColor',bkg,'Value',fault(2),'Enable',e);
set(handles.btn_f2_type, 'String',str,'BackgroundColor',bkg,'Value',fault(2),'Enable',e);
set(handles.btn_f3_type, 'String',str,'BackgroundColor',bkg,'Value',fault(2),'Enable',e);
set(handles.btn_f4_type, 'String',str,'BackgroundColor',bkg,'Value',fault(2),'Enable',e);
set(handles.btn_f5_type, 'String',str,'BackgroundColor',bkg,'Value',fault(2),'Enable',e);
set(handles.btn_f6_type, 'String',str,'BackgroundColor',bkg,'Value',fault(2),'Enable',e);
set(handles.btn_f7_type, 'String',str,'BackgroundColor',bkg,'Value',fault(2),'Enable',e);
set(handles.btn_f8_type, 'String',str,'BackgroundColor',bkg,'Value',fault(2),'Enable',e);
set(handles.btn_f9_type, 'String',str,'BackgroundColor',bkg,'Value',fault(2),'Enable',e);
set(handles.btn_f10_type,'String',str,'BackgroundColor',bkg,'Value',fault(2),'Enable',e);
set(handles.btn_f11_type,'String',str,'BackgroundColor',bkg,'Value',fault(2),'Enable',e);
set(handles.btn_f12_type,'String',str,'BackgroundColor',bkg,'Value',fault(2),'Enable',e);
set(handles.btn_f13_type,'String',str,'BackgroundColor',bkg,'Value',fault(2),'Enable',e);
set(handles.btn_f14_type,'String',str,'BackgroundColor',bkg,'Value',fault(2),'Enable',e);
set(handles.btn_f15_type,'String',str,'BackgroundColor',bkg,'Value',fault(2),'Enable',e);
set(handles.btn_f16_type,'String',str,'BackgroundColor',bkg,'Value',fault(2),'Enable',e);
set(handles.btn_f17_type,'String',str,'BackgroundColor',bkg,'Value',fault(2),'Enable',e);
set(handles.btn_f18_type,'String',str,'BackgroundColor',bkg,'Value',fault(2),'Enable',e);
set(handles.btn_f19_type,'String',str,'BackgroundColor',bkg,'Value',fault(2),'Enable',e);
set(handles.btn_f20_type,'String',str,'BackgroundColor',bkg,'Value',fault(2),'Enable',e);
set(handles.btn_f21_type,'String',str,'BackgroundColor',bkg,'Value',fault(2),'Enable',e);

fault_ti = num2str(fault(3));

set(handles.edit_f1_ti, 'String',fault_ti,'Enable',e);
set(handles.edit_f2_ti, 'String',fault_ti,'Enable',e);
set(handles.edit_f3_ti, 'String',fault_ti,'Enable',e);
set(handles.edit_f4_ti, 'String',fault_ti,'Enable',e);
set(handles.edit_f5_ti, 'String',fault_ti,'Enable',e);
set(handles.edit_f6_ti, 'String',fault_ti,'Enable',e);
set(handles.edit_f7_ti, 'String',fault_ti,'Enable',e);
set(handles.edit_f8_ti, 'String',fault_ti,'Enable',e);
set(handles.edit_f9_ti, 'String',fault_ti,'Enable',e);
set(handles.edit_f10_ti,'String',fault_ti,'Enable',e);
set(handles.edit_f11_ti,'String',fault_ti,'Enable',e);
set(handles.edit_f12_ti,'String',fault_ti,'Enable',e);
set(handles.edit_f13_ti,'String',fault_ti,'Enable',e);
set(handles.edit_f14_ti,'String',fault_ti,'Enable',e);
set(handles.edit_f15_ti,'String',fault_ti,'Enable',e);
set(handles.edit_f16_ti,'String',fault_ti,'Enable',e);
set(handles.edit_f17_ti,'String',fault_ti,'Enable',e);
set(handles.edit_f18_ti,'String',fault_ti,'Enable',e);
set(handles.edit_f19_ti,'String',fault_ti,'Enable',e);
set(handles.edit_f20_ti,'String',fault_ti,'Enable',e);
set(handles.edit_f21_ti,'String',fault_ti,'Enable',e);

fault_tf = num2str(fault(4));

set(handles.edit_f1_tf, 'String',fault_tf,'Enable',e);
set(handles.edit_f2_tf, 'String',fault_tf,'Enable',e);
set(handles.edit_f3_tf, 'String',fault_tf,'Enable',e);
set(handles.edit_f4_tf, 'String',fault_tf,'Enable',e);
set(handles.edit_f5_tf, 'String',fault_tf,'Enable',e);
set(handles.edit_f6_tf, 'String',fault_tf,'Enable',e);
set(handles.edit_f7_tf, 'String',fault_tf,'Enable',e);
set(handles.edit_f8_tf, 'String',fault_tf,'Enable',e);
set(handles.edit_f9_tf, 'String',fault_tf,'Enable',e);
set(handles.edit_f10_tf,'String',fault_tf,'Enable',e);
set(handles.edit_f11_tf,'String',fault_tf,'Enable',e);
set(handles.edit_f12_tf,'String',fault_tf,'Enable',e);
set(handles.edit_f13_tf,'String',fault_tf,'Enable',e);
set(handles.edit_f14_tf,'String',fault_tf,'Enable',e);
set(handles.edit_f15_tf,'String',fault_tf,'Enable',e);
set(handles.edit_f16_tf,'String',fault_tf,'Enable',e);
set(handles.edit_f17_tf,'String',fault_tf,'Enable',e);
set(handles.edit_f18_tf,'String',fault_tf,'Enable',e);
set(handles.edit_f19_tf,'String',fault_tf,'Enable',e);
set(handles.edit_f20_tf,'String',fault_tf,'Enable',e);
set(handles.edit_f21_tf,'String',fault_tf,'Enable',e);

%% Operation mode
if dK(1)
    str = 'Kp1: OPEN';
    bkg = get_color('open');
else
    str = 'Kp1: CLOSED';
    bkg = get_color('closed');
end

set(handles.btn_dKp1,'String',str,'BackgroundColor',bkg,'Value',1-dK(1));

if dK(2)
    str = 'Kp2: OPEN';
    bkg = get_color('open');
else
    str = 'Kp2: CLOSED';
    bkg = get_color('closed');
end

set(handles.btn_dKp2,'String',str,'BackgroundColor',bkg,'Value',1-dK(2));

if dK(3)
    str = 'Ka: OPEN';
    bkg = get_color('open');
else
    str = 'Ka: CLOSED';
    bkg = get_color('closed');
end

set(handles.btn_dKa,'String',str,'BackgroundColor',bkg,'Value',1-dK(3));

if dK(4)
    str = 'Kb: OPEN';
    bkg = get_color('open');
else
    str = 'Kb: CLOSED';
    bkg = get_color('closed');
end

set(handles.btn_dKb,'String',str,'BackgroundColor',bkg,'Value',1-dK(4));

if dK(5)
    str = 'K13: OPEN';
    bkg = get_color('open');
else
    str = 'K13: CLOSED';
    bkg = get_color('closed');
end

set(handles.btn_dK13,'String',str,'BackgroundColor',bkg,'Value',1-dK(5));

if dK(6)
    str = 'K23: OPEN';
    bkg = get_color('open');
else
    str = 'K23: CLOSED';
    bkg = get_color('closed');
end

set(handles.btn_dK23,'String',str,'BackgroundColor',bkg,'Value',1-dK(6));

if dK(7)
    str = 'K1: OPEN';
    bkg = get_color('open');
else
    str = 'K1: CLOSED';
    bkg = get_color('closed');
end

set(handles.btn_dK1,'String',str,'BackgroundColor',bkg,'Value',1-dK(7));

if dK(8)
    str = 'K2: OPEN';
    bkg = get_color('open');
else
    str = 'K2: CLOSED';
    bkg = get_color('closed');
end

set(handles.btn_dK2,'String',str,'BackgroundColor',bkg,'Value',1-dK(8));

if dK(9)
    str = 'K3: OPEN';
    bkg = get_color('open');
else
    str = 'K3: CLOSED';
    bkg = get_color('closed');
end

set(handles.btn_dK3,'String',str,'BackgroundColor',bkg,'Value',1-dK(9));

%% Plots
set(handles.popup_levels,'Value',plots(1));
set(handles.popup_flows, 'Value',plots(2));
set(handles.popup_valves,'Value',plots(3));
set(handles.popup_faults,'Value',plots(4));

bkg = get_color('open');

set(handles.btn_plot_levels,'BackgroundColor',bkg,'Enable',e);
set(handles.btn_plot_flows, 'BackgroundColor',bkg,'Enable',e);
set(handles.btn_plot_valves,'BackgroundColor',bkg,'Enable',e);
set(handles.btn_plot_faults,'BackgroundColor',bkg,'Enable',e);

set(handles.cbox_levels,'Value',plots(5));
set(handles.cbox_flows, 'Value',plots(6));
set(handles.cbox_valves,'Value',plots(7));
set(handles.cbox_faults,'Value',plots(8));

%% Axes
axes(handles.axes1);
hold off;
plot(0,0);
xlabel('time','Fontsize',8);
ylabel('magnitude','Fontsize',8);



%% Help *******************************************************************

function btn_help_Callback(~, ~, ~)

run('gui_help');



%% Exit *******************************************************************

function btn_exit_Callback(~, ~, ~)

fig_stop = findobj('Tag','see_dynamic_figure');

if ishandle(fig_stop)
    btn_stop = findobj('Tag','btn_stop_simulation');
    if ~get(btn_stop,'Value')
        disp('#Simulation aborted!');
    end
    delete(fig_stop);
end

delete(findobj('Tag','main_figure'));

close all;
