function varargout = Automaty_1D_GUI(varargin)
% AUTOMATY_1D_GUI MATLAB code for Automaty_1D_GUI.fig
%      AUTOMATY_1D_GUI, by itself, creates a new AUTOMATY_1D_GUI or raises the existing
%      singleton*.
%
%      H = AUTOMATY_1D_GUI returns the handle to a new AUTOMATY_1D_GUI or the handle to
%      the existing singleton*.
%
%      AUTOMATY_1D_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AUTOMATY_1D_GUI.M with the given input arguments.
%
%      AUTOMATY_1D_GUI('Property','Value',...) creates a new AUTOMATY_1D_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Automaty_1D_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Automaty_1D_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Automaty_1D_GUI

% Last Modified by GUIDE v2.5 24-Apr-2019 13:52:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Automaty_1D_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Automaty_1D_GUI_OutputFcn, ...
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


% --- Executes just before Automaty_1D_GUI is made visible.
function Automaty_1D_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Automaty_1D_GUI (see VARARGIN)

% Choose default command line output for Automaty_1D_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Automaty_1D_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Automaty_1D_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in rysuj.
function rysuj_Callback(hObject, eventdata, handles)
n_cells = str2double(get(handles.edit1, 'String')) - 2;
max_step = str2double(get(handles.edit2, 'String'));

t = [1,1,1 ; 1,1,0 ; 1,0,1 ; 1,0,0 ; 0,1,1 ; 0,1,0 ; 0,0,1 ; 0,0,0 ];

space = zeros(n_cells+2, max_step);

numer_reguly = str2double(get(handles.edit3, 'String'));
vec = de2bi(numer_reguly, 8);
%odwrocenie wektora
vec = fliplr(vec);

%losowy stan poczatkowy
%space(2:n_cells+1) = floor(2*rand(n_cells, 1));

space(floor(n_cells/2),1) = 1;
for step=2:max_step
    space(1,step-1) = space(n_cells+1,step-1);  
    space(n_cells+2,step-1) = space(2,step-1);  
end

for step=2:max_step
    for n=2:n_cells+1
        for i=1:8
            if space(n-1,step-1) == t(i,1) && space(n  ,step-1) == t(i,2) && space(n+1,step-1) == t(i,3) 
            space(n,step) = vec(i); 
            end
        end
    end
end

%set(handles.axes1,'xtick',[],'ytick',[]); 
imagesc(space')
% hObject    handle to rysuj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


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



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
