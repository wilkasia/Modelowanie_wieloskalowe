function varargout = ZARODKI(varargin)
% ZARODKI MATLAB code for ZARODKI.fig
%      ZARODKI, by itself, creates a new ZARODKI or raises the existing
%      singleton*.
%
%      H = ZARODKI returns the handle to a new ZARODKI or the handle to
%      the existing singleton*.
%
%      ZARODKI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ZARODKI.M with the given input arguments.
%
%      ZARODKI('Property','Value',...) creates a new ZARODKI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ZARODKI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ZARODKI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ZARODKI

% Last Modified by GUIDE v2.5 28-May-2019 11:22:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ZARODKI_OpeningFcn, ...
                   'gui_OutputFcn',  @ZARODKI_OutputFcn, ...
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


% --- Executes just before ZARODKI is made visible.
function ZARODKI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ZARODKI (see VARARGIN)

% Choose default command line output for ZARODKI
handles.output = hObject;

handles.len=50; 
handles.GRID=zeros(handles.len,handles.len);

for i=1:handles.len
    for j=1:handles.len
        handles.komorka(i,j).value = 0;
        handles.GRID(i,j) = handles.komorka(i,j).value;
        handles.komorka(i,j).id = j+(10*(i-1));
        handles.komorka(i,j).x = rand()+i;
        handles.komorka(i,j).y = rand()+j;
        handles.komorka(i,j).energia = 0;
    end
end


handles.cmap = colormap(hsv(256));
handles.cmap(1,:) = [1 1 1];

cla
pcolor(handles.GRID);
colormap(handles.cmap)
set(gca, 'CLim', [0 1]);

axis ij
axis off
axis image

handles.counter=1;
handles.otoczenie = 1;
handles.opcja = 0;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ZARODKI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ZARODKI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in recznie.
function recznie_Callback(hObject, eventdata, handles)
% hObject    handle to recznie (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
n=100;
counter=1;

for i=1:n
    [x1, y1]=ginput(1);
    if x1 > handles.len+1
        break
    end
    handles.GRID(floor(y1),floor(x1))=counter;
    handles.komorka(floor(y1),floor(x1)).value = counter;
    counter=counter+1;
    cla
    pcolor(handles.GRID);
    colormap(handles.cmap);
    set(gca, 'CLim', [0 counter]);
    axis ij
    axis off
    axis image
    set(handles.text3,'String',i);
end

handles.counter=counter;

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in losowe.
function losowe_Callback(hObject, eventdata, handles)
% hObject    handle to losowe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ilosc=str2double(get(handles.edit1, 'String'));
counter=1;

for i=1:ilosc
    while(1)
        index=randi(handles.len*handles.len);
        if handles.GRID(index) ~= 0
            continue;
        end
        if handles.GRID(index) == 0
            break; 
        end
    end
    handles.GRID(index)=counter;
    handles.komorka(index).value = counter;
    guidata(hObject, handles);
    counter=counter+1;
    set(handles.text3,'String',i);
end

cla
pcolor(handles.GRID);
colormap(handles.cmap);
set(gca, 'CLim', [0 ilosc]);
axis ij
axis off
axis image

handles.counter=counter;

% Update handles structure
guidata(hObject, handles);
    
% --- Executes on button press in jednorodne.
function jednorodne_Callback(hObject, eventdata, handles)
% hObject    handle to jednorodne (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

       
n=str2double(get(handles.edit2, 'String'));
m=str2double(get(handles.edit3, 'String'));
counter=1;

for i=1:n
    for j=1:m
        handles.GRID(j*floor(handles.len/n),i*floor(handles.len/m))=counter;
        handles.komorka(j*floor(handles.len/n),i*floor(handles.len/m)).value = counter;
        counter=counter+1;
        set(handles.text3,'String',n*m);
    end  
end

cla
pcolor(handles.GRID);
colormap(handles.cmap);
set(gca, 'CLim', [0 n*m]);
axis ij
axis off
axis image

handles.counter=counter;

% Update handles structure
guidata(hObject, handles);
        

% --- Executes on button press in wyczysc.
function wyczysc_Callback(hObject, eventdata, handles)
% hObject    handle to wyczysc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.GRID(:)=0;
for i=1:handles.len
    for j=1:handles.len
        handles.komorka(i,j).value = 0;
        
    end
end

cla
pcolor(handles.GRID);
colormap(handles.cmap)
set(gca, 'CLim', [0 1]);
axis ij
axis off
axis image
set(handles.text3,'String',0);
handles.counter=1;
handles.otoczenie=0;
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in zpromieniem.
function zpromieniem_Callback(hObject, eventdata, handles)
% hObject    handle to zpromieniem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

r=str2double(get(handles.edit4, 'String'));
ilosc=str2double(get(handles.edit5, 'String'));

counter=1;

for i=1:ilosc
    flag=1;
    a=0;
    while(flag==1)
        index1=randi(handles.len-1);
        index2=randi(handles.len-1);
        if handles.GRID(index1,index2) ~= 0
            continue;
        end
        B1=handles.GRID(max([index1-r,1]):min([index1+r, size(handles.GRID,1)]), max([index2-r,1]):min([index2+r, size(handles.GRID,2)]));
        a=a+1;
        if a>=ilosc
            flag=0;
        end
        if nnz(B1) == 0
            flag=0;    
            handles.GRID(index1, index2)=counter;
            handles.komorka(index1, index2).value = counter;
            guidata(hObject, handles);
            counter=counter+1;    
        end
    end

end

set(handles.text3,'String',counter-1);

cla
pcolor(handles.GRID);
colormap(handles.cmap);
set(gca, 'CLim', [0 counter]);
axis ij
axis off
axis image

handles.counter=counter;

% Update handles structure
guidata(hObject, handles);
        



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



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

GRID = handles.GRID;

otoczenie = handles.otoczenie;
opcja = handles.opcja;
r=str2double(get(handles.edit8, 'String'));

for i=1:100
    GRID_2=GRID;
    for i=1:handles.len
        for j=1:handles.len
            
            
            if opcja == 31 || opcja == 32 || opcja == 33 || opcja == 34
                opcja = randi(4) + 30;
            end
   

            if opcja == 41 || opcja == 42
                opcja = randi(2) + 40;
    
            end
            
            
            
            if GRID(j,i)==0
                if otoczenie == 2 || otoczenie == 1 || opcja == 41 || opcja == 42 || opcja == 31 || opcja == 32 || opcja == 34 || otoczenie == 6 || otoczenie == 7
                    if GRID(min([j+1,size(GRID,1)]),i)~=0 %góra G
                            GRID_2(j,i) = GRID(min([j+1,size(GRID,1)]),i);
                    end
                end
                
                if otoczenie == 2 || otoczenie == 1 || opcja == 41 || opcja == 42 || opcja == 31 || opcja == 32 || opcja == 33 || otoczenie == 6 || otoczenie == 7   
                    if GRID(max([j-1,1]),i)~=0 %dó³ D
                            GRID_2(j,i) = GRID(max([j-1,1]),i);
                    end
                end
                
                if otoczenie == 2 || otoczenie == 1 || opcja == 41 || opcja == 42 || opcja == 32 || opcja == 33 || opcja == 34 || otoczenie == 6 || otoczenie == 7
                    if GRID(j,min([i+1,size(GRID,2)]))~=0 %prawo P
                            GRID_2(j,i) = GRID(j,min([i+1,size(GRID,2)]));
                    end                   
                end
                
                if otoczenie == 2 || otoczenie == 1 || opcja == 41 || opcja == 42 || opcja == 31 || opcja == 33 || opcja == 34 || otoczenie == 6 || otoczenie == 7
                    if GRID(j,max([i-1,1]))~=0 %lewo L
                            GRID_2(j,i) = GRID(j,max([i-1,1]));
                    end
                end
                
                if otoczenie == 2 || opcja == 41 ||opcja == 32 || opcja == 34 || otoczenie == 6
                    if GRID(min([j+1,size(GRID,1)]),min([i+1,size(GRID,2)]))~=0 %prawo-góra GP
                        GRID_2(j,i) = GRID(min([j+1,size(GRID,1)]),min([i+1,size(GRID,2)]));
                    end
                end
                
                if otoczenie == 2 || opcja == 42 ||opcja == 31 || opcja == 34 || otoczenie == 7
                   if GRID(min([j+1,size(GRID,1)]),max([i-1,1]))~=0 %lewo-góra GL
                        GRID_2(j,i) = GRID(min([j+1,size(GRID,1)]),max([i-1,1]));
                   end
                end
                
                if otoczenie == 2 || opcja == 42 || opcja == 32 || opcja == 33 || otoczenie == 7                 
                    if GRID(max([j-1,1]),min([i+1,size(GRID,2)]))~=0 %prawo-dó³ DP
                        GRID_2(j,i) = GRID(max([j-1,1]),min([i+1,size(GRID,2)]));
                    end
                end
                
                if otoczenie == 2 || opcja == 41 || opcja == 31 || opcja == 33 || otoczenie == 6
                   if GRID(max([j-1,1]),max([i-1,1]))~=0 %lewo-dó³ DL
                        GRID_2(j,i) = GRID(max([j-1,1]),max([i-1,1]));
                   end
                end
            end
     
            if GRID(j,i)~=0 && handles.otoczenie == 5
                for k=1:handles.len
                    for l=1:handles.len
                        if (handles.komorka(k,l).x - j)^2 + (handles.komorka(k,l).y - i)^2 < r && GRID(k,l)==0 
                            GRID_2(k,l) = GRID(j,i);
                        end
                    end
                end
            end
            
        end
    end
    GRID=GRID_2;
    cla
    pcolor(GRID);
    colormap(handles.cmap);
    set(gca, 'CLim', [0 handles.counter]);
    axis ij
    axis off
    axis image
    pause(0.1);

    if GRID ~= 0
        break;
    end
end


function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double

handles.output = hObject;
handles.len=str2double(get(handles.edit7, 'String'));
handles.GRID=zeros(handles.len,handles.len);

for i=1:handles.len
    for j=1:handles.len
        komorka(i,j).value = 0;
        handles.GRID(i,j) = komorka(i,j).value;
        komorka(i,j).id = j+(10*(i-1));
        komorka(i,j).x = rand()+i;
        komorka(i,j).y = rand()+j;
        komorka(i,j).energia = 0;
    end
end
handles.komorka = komorka;

handles.cmap = colormap(hsv(256));
handles.cmap(1,:) = [1 1 1];

cla
pcolor(handles.GRID);
colormap(handles.cmap)
set(gca, 'CLim', [0 1]);

axis ij
axis off
axis image

handles.counter=1;
% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in uibuttongroup1.
function uibuttongroup1_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup1 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch get(eventdata.NewValue, 'Tag')
    case 'neumann',  handles.otoczenie = 1; handles.opcja=0; 
    case 'moore',  handles.otoczenie = 2; handles.opcja=0; 
    case 'pent',  handles.otoczenie = 3;
    case 'heks',  handles.otoczenie = 4;
    case 'promien', handles.otoczenie = 5; handles.opcja=0;
    case 'hprawe', handles.otoczenie = 6; handles.opcja=0;
    case 'hlewe', handles.otoczenie = 7; handles.opcja=0;
    otherwise, handles.otoczenie = 1;
end

disp(handles.otoczenie);

%losowanie opcji dla hex i pent

if handles.otoczenie == 3
    handles.opcja = randi(4) + 30;
end

if handles.otoczenie == 4
    handles.opcja = randi(2) + 40;
end

disp(handles.opcja);


% Update handles structure
guidata(hObject, handles);

      
function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
