function varargout = GAME_GUI(varargin)
% GAME_GUI MATLAB code for GAME_GUI.fig
%      GAME_GUI, by itself, creates a new GAME_GUI or raises the existing
%      singleton*.
%
%      H = GAME_GUI returns the handle to a new GAME_GUI or the handle to
%      the existing singleton*.
%
%      GAME_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GAME_GUI.M with the given input arguments.
%
%      GAME_GUI('Property','Value',...) creates a new GAME_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GAME_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GAME_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GAME_GUI

% Last Modified by GUIDE v2.5 08-May-2019 19:57:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GAME_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GAME_GUI_OutputFcn, ...
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
% End initialization code - DO NOT EDIT



% --- Executes just before GAME_GUI is made visible.
function GAME_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GAME_GUI (see VARARGIN)

% Choose default command line output for GAME_GUI
handles.output = hObject;
handles.len=50; 
handles.GRID=zeros(handles.len,handles.len);
colormap([0 1 0; 1 1 1])
cla
pcolor(handles.GRID);
axis ij
axis off
axis image

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GAME_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GAME_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

len=handles.len;
GRID=handles.GRID;
colormap([1 1 1; 0 1 0])
%colormap([0 1 0; 1 1 1])

up=[2:len 1]; 
down=[len 1:len-1]; %the world is round

for i=1:1000
    neighbours=GRID(up,:)+GRID(down,:)+GRID(:,up)+GRID(:,down)+GRID(up,up)+GRID(up,down)+GRID(down,up)+GRID(down,down);
    GRID = neighbours==3 | GRID & neighbours==2;
    if ~any(GRID(:))
        colormap([1 1 1])
        cla
        pcolor(GRID);
        axis ij
        axis image
        axis off 
        break
    end 
    cla
    pcolor(GRID);
    axis ij
    axis image
    axis off 
    pause(0.1);
    
end

handles.GRID = GRID;

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in glider.
function glider_Callback(hObject, eventdata, handles)
% hObject    handle to glider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.GRID(3,1:3)=1;
handles.GRID(2,3)=1;
handles.GRID(1,2)=1;

colormap([1 1 1; 0 1 0])
cla
pcolor(handles.GRID);
axis ij
axis off
axis image

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in blinker.
function blinker_Callback(hObject, eventdata, handles)
% hObject    handle to blinker (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.GRID(5,4:6)=1;
colormap([1 1 1; 0 1 0])
cla
pcolor(handles.GRID);
axis ij
axis off
axis image

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in losowe.
function losowe_Callback(hObject, eventdata, handles)
% hObject    handle to losowe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.GRID=int8(rand(handles.len,handles.len));
colormap([1 1 1; 0 1 0])
cla
pcolor(handles.GRID);
axis ij
axis off
axis image

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in niezmienne.
function niezmienne_Callback(hObject, eventdata, handles)
% hObject    handle to niezmienne (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.GRID(5,5:6)=1;
handles.GRID(4,4)=1;
handles.GRID(4,7)=1;
handles.GRID(3,5:6)=1;

colormap([1 1 1; 0 1 0])
cla
pcolor(handles.GRID);
axis ij
axis off
axis image

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in recznie.
function recznie_Callback(hObject, eventdata, handles)
% hObject    handle to recznie (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Update handles structure
guidata(hObject, handles);

n=100;
for i=1:n
    [x1, y1]=ginput(1);
    if x1 > handles.len
        break
    end
    handles.GRID(floor(y1),floor(x1))=1;
    colormap([1 1 1; 0 1 0])
    cla
    pcolor(handles.GRID);
    axis ij
    axis off
    axis image
end

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in wyczysc.
function wyczysc_Callback(hObject, eventdata, handles)
% hObject    handle to wyczysc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.GRID(:)=0;
colormap([0 1 0; 1 1 1])
cla
pcolor(handles.GRID);
axis ij
axis off
axis image

% Update handles structure
guidata(hObject, handles);


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
handles.len = str2double(get(handles.edit1, 'String'));
handles.GRID=zeros(handles.len,handles.len);
colormap([0 1 0; 1 1 1])
cla
pcolor(handles.GRID);
axis ij
axis off
axis image

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

