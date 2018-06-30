function varargout = view(varargin)
% VIEW M-file for view.fig
%      VIEW, by itself, creates a new VIEW or raises the existing
%      singleton*.
%
%      H = VIEW returns the handle to a new VIEW or the handle to
%      the existing singleton*.
%
%      VIEW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIEW.M with the given meaning1 arguments.
%
%      VIEW('Property','Value',...) creates a new VIEW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before view_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to view_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help view

% Last Modified by GUIDE v2.5 07-Sep-2011 14:52:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @view_OpeningFcn, ...
                   'gui_OutputFcn',  @view_OutputFcn, ...
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
function view_OpeningFcn(hObject, eventdata, handles, varargin)
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
% uiwait(handles.figure2);
mainhandles=varargin{1,1};
handles.mainFigureHandles=mainhandles;
guidata(hObject,handles);
set(handles.word1,'String',handles.mainFigureHandles.voc{1,handles.mainFigureHandles.cur});
set(handles.meaning1,'String',handles.mainFigureHandles.voc{2,handles.mainFigureHandles.cur});
set(handles.sentence,'String',handles.mainFigureHandles.voc{3,handles.mainFigureHandles.cur});

NumberWord=1;
[Numberlines,Numberlists]=size(handles.mainFigureHandles.voc);
wrong=zeros(1,Numberlines/3);
handles.Numberlines=Numberlines;%每个list的行数
handles.wrong=wrong;
handles.NW=NumberWord;%the sequence number of word in the list

handles.cur=handles.mainFigureHandles.cur;% 

handles.day=handles.mainFigureHandles.day;% 当前天
handles.list=handles.mainFigureHandles.list;%
handles.sch=handles.mainFigureHandles.sch;% 日程
handles.daytask=handles.mainFigureHandles.daytask;% 要背诵的所有list
handles.voc=handles.mainFigureHandles.voc;% 

w=1;m=1;r=1;
for i=1:Numberlines % 将每个list的所有行按 拼写,词义,注释 进行分类
    if mod(i,3)==1
        handles.word(w,:)=handles.voc(i,:);
        w=w+1;
    elseif mod(i,3)==2
        handles.meaning(m,:)=handles.voc(i,:);
        m=m+1;
    elseif mod(i,3)==0
        handles.remark(r,:)=handles.voc(i,:);
        r=r+1;
    end
end
guidata(hObject,handles);

% --- Outputs from this function are returned to the command line.
function varargout = view_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function word1_Callback(hObject, eventdata, handles)
% hObject    handle to word1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of word1 as text
%        str2double(get(hObject,'String')) returns contents of word1 as a double


% --- Executes during object creation, after setting all properties.
function word1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to word1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function meaning1_Callback(hObject, eventdata, handles)
% hObject    handle to meaning1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of meaning1 as text
%        str2double(get(hObject,'String')) returns contents of meaning1 as a double




% --- Executes during object creation, after setting all properties.
function meaning1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to meaning1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sentence_Callback(hObject, eventdata, handles)
% hObject    handle to sentence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sentence as text
%        str2double(get(hObject,'String')) returns contents of sentence as a double


% --- Executes during object creation, after setting all properties.
function sentence_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sentence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function display2_Callback(hObject, eventdata, handles)
% hObject    handle to display2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of display2 as text
%        str2double(get(hObject,'String')) returns contents of display2 as a double


% --- Executes during object creation, after setting all properties.
function display2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to display2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rightanswer_Callback(hObject, eventdata, handles)
% hObject    handle to rightanswer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rightanswer as text
%        str2double(get(hObject,'String')) returns contents of rightanswer as a double


% --- Executes during object creation, after setting all properties.
function rightanswer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rightanswer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in next.
function next_Callback(hObject, eventdata, handles) 
% hObject    handle to next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.NW=handles.NW+1;   
if handles.NW<=handles.Numberlines/3
    set(handles.word1,'String',handles.word(handles.NW,handles.cur));
    set(handles.meaning1,'String',handles.meaning(handles.NW,handles.cur));
    set(handles.sentence,'String',handles.remark(handles.NW,handles.cur));
    guidata(hObject,handles);
else
    set(handles.review,'Enable','On');
    set(handles.gotorecite,'Enable','On');
    set(handles.quit,'Enable','On');
    set(handles.next,'Enable','Off');
end
guidata(hObject,handles);




% --- Executes on button press in quit.
function quit_Callback(hObject, eventdata, handles) % 退出
% hObject    handle to quit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
quit


% --- Executes on button press in review.
function review_Callback(hObject, eventdata, handles) % 
% hObject    handle to review (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.quit,'Enable','Off');
set(handles.gotorecite,'Enable','Off');
set(handles.review,'Enable','Off');
set(handles.next,'Enable','On');
set(handles.word1,'String',handles.mainFigureHandles.voc{1,handles.mainFigureHandles.cur});
set(handles.meaning1,'String',handles.mainFigureHandles.voc{2,handles.mainFigureHandles.cur});
set(handles.sentence,'String',handles.mainFigureHandles.voc{3,handles.mainFigureHandles.cur});
handles.NW=1;
guidata(hObject,handles);


% --- Executes on key press with focus on meaning1 and none of its controls.
function meaning1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to meaning1 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over meaning1.
function meaning1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to meaning1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over next.
function next_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on next and none of its controls.
function next_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to next (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over quit.
function quit_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to quit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
quit


% --- Executes on button press in gotorecite.
function gotorecite_Callback(hObject, eventdata, handles)
% hObject    handle to gotorecite (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    set(handles.review,'Enable','Off');
    set(handles.gotorecite,'Enable','Off');
    set(handles.quit,'Enable','Off');
    set(handles.next,'Enable','On');
delete(handles.figure2);
recite(handles)