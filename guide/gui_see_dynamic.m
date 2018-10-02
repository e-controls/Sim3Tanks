function varargout = gui_see_dynamic(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @gui_see_dynamic_OpeningFcn, ...
    'gui_OutputFcn',  @gui_see_dynamic_OutputFcn, ...
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

function varargout = gui_see_dynamic_OutputFcn(~, ~, handles)

varargout{1} = handles.output;

function gui_see_dynamic_OpeningFcn(hObject, ~, handles, varargin)

handles.output = hObject;

guidata(hObject, handles);

movegui(gcf,'center');

set(handles.btn_stop_simulation,'BackgroundColor',get_color('open'));
set(handles.btn_close_rt,'BackgroundColor',get_color('open'));

b = get_color('b');
w = get_color('w');

dK = findobj('Tag','btn_dKp1');

if ishandle(dK)
    value = get(dK,'Value');
    if value == 0
        bkg = b;
        v   = 1;
    else
        bkg = w;
        v   = 0;
    end
    set(handles.gui_rt_Kp1,'BackgroundColor',bkg,'Value',v)
    set(handles.gui_rt_pipe_Kp1,'BackgroundColor',bkg);
end

dK = findobj('Tag','btn_dKp2');

if ishandle(dK)
    value = get(dK,'Value');
    if value == 0
        bkg = b;
        v   = 1;
    else
        bkg = w;
        v   = 0;
    end
    set(handles.gui_rt_Kp2,'BackgroundColor',bkg,'Value',v)
    set(handles.gui_rt_pipe_Kp2,'BackgroundColor',bkg);
end

dK = findobj('Tag','btn_dKa');

if ishandle(dK)
    value = get(dK,'Value');
    if value == 0
        bkg = b;
        v   = 1;
    else
        bkg = w;
        v   = 0;
    end
    set(handles.gui_rt_Ka,'BackgroundColor',bkg,'Value',v)
    set(handles.gui_rt_pipe_Ka,'BackgroundColor',bkg);
end

dK = findobj('Tag','btn_dKb');

if ishandle(dK)
    value = get(dK,'Value');
    if value == 0
        bkg = b;
        v   = 1;
    else
        bkg = w;
        v   = 0;
    end
    set(handles.gui_rt_Kb,'BackgroundColor',bkg,'Value',v)
    set(handles.gui_rt_pipe_Kb,'BackgroundColor',bkg);
end

dK = findobj('Tag','btn_dK13');

if ishandle(dK)
    value = get(dK,'Value');
    if value == 0
        bkg = b;
        v   = 1;
    else
        bkg = w;
        v   = 0;
    end
    set(handles.gui_rt_K13,'BackgroundColor',bkg,'Value',v)
    set(handles.gui_rt_pipe_K13,'BackgroundColor',bkg);
end

dK = findobj('Tag','btn_dK23');

if ishandle(dK)
    value = get(dK,'Value');
    if value == 0
        bkg = b;
        v   = 1;
    else
        bkg = w;
        v   = 0;
    end
    set(handles.gui_rt_K23,'BackgroundColor',bkg,'Value',v)
    set(handles.gui_rt_pipe_K23,'BackgroundColor',bkg);
end

dK = findobj('Tag','btn_dK1');

if ishandle(dK)
    value = get(dK,'Value');
    if value == 0
        bkg = b;
        v   = 1;
    else
        bkg = w;
        v   = 0;
    end
    set(handles.gui_rt_K1,'BackgroundColor',bkg,'Value',v)
    set(handles.gui_rt_pipe_K1,'BackgroundColor',bkg);
end

dK = findobj('Tag','btn_dK2');

if ishandle(dK)
    value = get(dK,'Value');
    if value == 0
        bkg = b;
        v   = 1;
    else
        bkg = w;
        v   = 0;
    end
    set(handles.gui_rt_K2,'BackgroundColor',bkg,'Value',v)
    set(handles.gui_rt_pipe_K2,'BackgroundColor',bkg);
end

dK = findobj('Tag','btn_dK3');

if ishandle(dK)
    value = get(dK,'Value');
    if value == 0
        bkg = b;
        v   = 1;
    else
        bkg = w;
        v   = 0;
    end
    set(handles.gui_rt_K3,'BackgroundColor',bkg,'Value',v)
    set(handles.gui_rt_pipe_K3,'BackgroundColor',bkg);
end

function gui_rt_edt_time_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function btn_stop_simulation_Callback(hObject, ~, handles)

disp('#Simulation cancelled by user.');

set(handles.see_dynamic_figure,'Name','Simulation cancelled by user');

set(hObject,'Value',1,'Enable','off','Visible','off');
set(handles.btn_close_rt,'Visible','on');

function btn_close_rt_Callback(~, ~, ~)

closereq();

function edit_rt_h1_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_rt_Q23_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_rt_Q1_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_rt_Q2_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_rt_Q13_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_rt_Qb_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_rt_Qa_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_rt_u2_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_rt_u1_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_rt_h3_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_rt_h2_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_rt_Q3_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
