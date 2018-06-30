function varargout = main(varargin)
% VIEW M-file for view.fig
%      VIEW, by itself, creates a new VIEW or raises the existing
%      singleton*.
%
%      H = VIEW returns the handle to a new VIEW or the handle to
%      the existing singleton*.
%
%      VIEW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIEW.M with the given input arguments.
%
%      VIEW('Property','Value',...) creates a new VIEW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help view

% Last Modified by GUIDE v2.5 10-Sep-2011 12:12:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
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


% --- Executes just before view is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to view (see VARARGIN)

% Choose default command line output for view
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes view wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function Openfile_Callback(hObject, eventdata, handles)
% hObject    handle to Openbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[NameArchivo,PathArchivo]=uigetfile({'*.txt'});
if ~isequal(NameArchivo,0)
    FileName = strcat(PathArchivo,NameArchivo);
    fid=fopen(FileName,'r');
    Voc=textscan(fid,'%s','Delimiter','\n');
    t = uitable(handles.figure1, 'Data', Voc{1,1});
    
end

% --------------------------------------------------------------------
function Openbutton_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to Openbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when uipanel1 is resized.
function uipanel1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to uipanel1 (see GCBO)
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


% --- Executes on button press in pushbutton.
function pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[NameArchivo,PathArchivo]=uigetfile({'*.txt'});
if ~isequal(NameArchivo,0)
    FileName = strcat(PathArchivo,NameArchivo);
    handles.path=PathArchivo;
    fid=fopen(FileName,'r');
    Voc=textscan(fid,'%s','Delimiter','\n');
    
    
    FileName = strcat(PathArchivo,'Current_Day.txt');%µ±Ç°Ìì
    Currentday=load(FileName);
    handles.day=Currentday;
    
    FileName = strcat(PathArchivo,'Current_List.txt');%the nth list of each day
    CurrentList=load(FileName);
    handles.list=CurrentList;
    
    
    FileName=strcat(handles.path,'Schedule.txt');%schedule
    Schedule=load(FileName);
    handles.sch=Schedule;
    [i,j,s]=find(handles.sch(handles.day,:));%to delet zero in the schedule
    handles.daytask=s;
    handles.cur=handles.daytask(1,handles.list);% the nth list of the whole vocabulary
    set(handles.edit3,'String',[num2str(handles.day) 'th day' ' ' num2str(handles.cur) 'th list']);
    
    g=get(handles.edit1,'String');
    Numberwords=str2num(g);%the number of words in one list,each word possesses three lines
    [TotalLines,g]=size(Voc{1,1});clear g;%the number of lines of Voc
    Numberlists=floor(TotalLines/Numberwords(1)/3);%how many lists
    Numberlines=Numberwords*3;%how many lines in one list
    g=['There are' ' ' num2str(Numberlists) ' ' 'lists.'];
    set(handles.edit2,'String',g);
    for i=1:Numberlists
        for j=1:Numberlines
            voc(j,i)=Voc{1,1}(j+(i-1)*Numberlines,1);% assign Voc into lists
        end
    end
    for i=1:Numberlists
        colnames{i}=['List' num2str(i)];
    end
    g=[50 70 250 300];
    t = uitable(handles.figure1, 'Data', voc,'ColumnName',colnames,'Position',g);
    handles.voc=voc;%define a handle for voc
end
set(handles.Schedule,'Enable','on')
set(handles.View,'Enable','on')
set(handles.Recite,'Enable','on')
guidata(hObject, handles);%don't remember to update hObject in order to make handles include voc in following callback



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


% --------------------------------------------------------------------
function View_Callback(hObject, eventdata, handles)
% hObject    handle to View (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

view(handles);


% --------------------------------------------------------------------
function Recite_Callback(hObject, eventdata, handles)
% hObject    handle to main (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

recite(handles);


% --------------------------------------------------------------------
function Schedule_Callback(hObject, eventdata, handles)
% hObject    handle to Schedule (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
varargin{1}=handles.sch;
schedule(varargin);


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


% --- Executes on scroll wheel click while the figure is in focus.
function figure1_WindowScrollWheelFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	VerticalScrollCount: signed integer indicating direction and number of clicks
%	VerticalScrollAmount: number of lines scrolled for each click
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on figure1 or any of its controls.
function figure1_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Donate_Callback(hObject, eventdata, handles)
% hObject    handle to Donate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
donate(handles)

% --------------------------------------------------------------------
function About_Callback(hObject, eventdata, handles)
% hObject    handle to About (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
about(handles)


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Homepage_Callback(hObject, eventdata, handles)
% hObject    handle to Homepage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
web -browser https://sites.google.com/site/irememberword

