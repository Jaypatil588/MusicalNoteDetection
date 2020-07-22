function varargout = opengui(varargin)



gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @opengui_OpeningFcn, ...
                   'gui_OutputFcn',  @opengui_OutputFcn, ...
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




function opengui_OpeningFcn(hObject, eventdata, handles, varargin)



handles.output = hObject;


guidata(hObject, handles);





function varargout = opengui_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;



function pushbutton1_Callback(hObject, eventdata, handles)

[name,path]=uigetfile('.wav','' ,'select your file'); 
cplpath=strcat(path, name); 

[x,fs] = audioread(cplpath); 
[freq, sym] = findtheff(x,fs);

FF = [num2str(floor(freq)) ,' Hz']; 
sound(x,fs);


set(handles.path, 'string', cplpath);
set(handles.FF, 'string', FF);
set(handles.NSym, 'string', sym); 

plot(handles.plotx,x);  





function path_Callback(hObject, eventdata, handles)



function path_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function content_Callback(hObject, eventdata, handles)

function content_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FF_Callback(hObject, eventdata, handles)

function FF_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NSym_Callback(hObject, eventdata, handles)



function NSym_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Replay_Callback(hObject, eventdata, handles)
cplpath=get(handles.path,'string');
[x,fs]=audioread(cplpath);
sound(x,fs);
