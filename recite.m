function varargout = recite(varargin)
% RECITE M-file for recite.fig
%      RECITE, by itself, creates a new RECITE or raises the existing
%      singleton*.
%
%      H = RECITE returns the handle to a new RECITE or the handle to
%      the existing singleton*.
%
%      RECITE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RECITE.M with the given input arguments.
%
%      RECITE('Property','Value',...) creates a new RECITE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before recite_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to recite_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help recite

% Last Modified by GUIDE v2.5 10-Sep-2011 11:23:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @recite_OpeningFcn, ...
    'gui_OutputFcn',  @recite_OutputFcn, ...
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





% --- Executes just before recite is made visible.
function recite_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to recite (see VARARGIN)

% Choose default command line output for recite
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes recite wait for user response (see UIRESUME)
% uiwait(handles.figure2);
mainhandles=varargin{1,1};
handles.mainFigureHandles=mainhandles;
guidata(hObject,handles);
set(handles.display1,'String',handles.mainFigureHandles.voc{2,handles.mainFigureHandles.cur});
set(handles.display2,'String',' ');
set(handles.sentence,'String',' ');
set(handles.rightanswer,'String',' ');
NumberWord=1;
[Numberlines,Numberlists]=size(handles.mainFigureHandles.voc);
wrong=zeros(1,Numberlines/3);
handles.Numberlines=Numberlines;%每个list的行数
handles.wrong=wrong;
handles.NW=NumberWord;%the sequence number of word in the list
handles.cur=handles.mainFigureHandles.cur;% 当前list
handles.day=handles.mainFigureHandles.day;% 当前天
handles.list=handles.mainFigureHandles.list;% 当前list
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
function varargout = recite_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function display1_Callback(hObject, eventdata, handles)
% hObject    handle to display1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of display1 as text
%        str2double(get(hObject,'String')) returns contents of display1 as a double


% --- Executes during object creation, after setting all properties.
function display1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to display1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function input_Callback(hObject, eventdata, handles)
% hObject    handle to input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input as text
%        str2double(get(hObject,'String')) returns contents of input as a double

set(handles.display1,'String',handles.meaning(handles.NW,handles.cur));
set(handles.ok,'Enable','Off');
set(handles.goon,'Enable','Off');
handles.answer{handles.NW}=get(handles.input,'String');%get the answer
flag=strcmpi(handles.word(handles.NW,handles.cur),handles.answer(1,handles.NW));
set(handles.input,'Enable','Off');
if flag==0
    %wrong(NW)=NW;
    handles.wrong(handles.NW)=handles.NW;
    set(handles.display2,'String','Wrong!');
    set(handles.rightanswer,'String',handles.word(handles.NW,handles.cur));
    set(handles.sentence,'String',handles.remark(handles.NW,handles.cur));
else
    set(handles.display2,'String','Right!');
    set(handles.rightanswer,'String',handles.word(handles.NW,handles.cur));
    set(handles.sentence,'String',handles.remark(handles.NW,handles.cur));
end
set(handles.next,'Enable','On');
uiwait(gcf)
handles.NW=handles.NW+1; disp(handles.NW); 
set(handles.input,'String','');
set(handles.display2,'String',' ');
set(handles.rightanswer,'String',' ');
set(handles.sentence,'String',' ');
if handles.NW<=handles.Numberlines/3
    set(handles.display1,'String',handles.meaning(handles.NW,handles.cur));
    set(handles.input,'Enable','on');
else %if reach the end of list    
    if any(handles.wrong)%check if there are wrong answers to go over
        set(handles.sentence,'String','Go over wrong words?');
        set(handles.ok,'Enable','On');
    else%to display the completion of current list
        
        g=['List ' num2str(handles.cur) 'Completed!'];
        set(handles.rightanswer,'String', g);
        g=handles.list+1;
        save Current_List.txt g -ASCII
        g=size(handles.daytask);
        if handles.list>=g(2)%to check if reach the end of today's task
            g=['Day' num2str(handles.day) 'Completed!'];
            set(handles.rightanswer,'String', g);
            g=handles.day+1;
            save Current_Day.txt g -ASCII
            g=1;
            save Current_List.txt g -ASCII
            set(handles.display1,'String','')
            
            g=size(handles.sch);
            if handles.day==g(1)%to check if reach the end of schedule
                say='Schedule Completed!';
                set(handles.rightanswer,'String', say);
                say='You can quit and rebuid another schedule';
                set(handles.sentence,'String', say);
                set(handles.display1,'String','')
            else
                say='You can quit and reopen the program for the next day''s task';
                set(handles.sentence,'String', say);
            end
            
        else
            set(handles.sentence,'String','Go to today''s next list?');
            set(handles.goon,'Enable','On');
        end
    end
end
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input (see GCBO)
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


% --- Executes on button press in ok.
function ok_Callback(hObject, eventdata, handles) % 重复错的单词
% hObject    handle to ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.ok,'Enable','Off');
set(handles.goon,'Enable','Off');
set(handles.sentence,'String','');
set(handles.input,'Enable','On');
g=find(handles.wrong);
g1=size(g);
for i=1:g1(2)
    handles.word(i,handles.cur)=handles.word(handles.wrong(g(i)),handles.cur);
    handles.meaning(i,handles.cur)=handles.meaning(handles.wrong(g(i)),handles.cur);
    handles.remark(i,handles.cur)=handles.remark(handles.wrong(g(i)),handles.cur);
end

handles.NW=1;
handles.wrong=zeros(1,20);% 20 words each list
handles.Numberlines=g1(2)*3;
set(handles.sentence,'String','');
set(handles.display1,'String',handles.meaning(handles.NW,handles.cur));
guidata(hObject,handles);




% --- Executes on button press in quit.
function quit_Callback(hObject, eventdata, handles) % 退出
% hObject    handle to quit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
quit


% --- Executes on button press in goon.
function goon_Callback(hObject, eventdata, handles) % 继续当天的剩余list
% hObject    handle to goon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.list=handles.list+1;
handles.cur=handles.daytask(1,handles.list);
handles.NW=1;
[Numberlines,Numberlists]=size(handles.mainFigureHandles.voc);
wrong=zeros(1,Numberlines/3);
handles.wrong=wrong;
handles.Numberlines=Numberlines;

w=1;m=1;r=1;
for i=1:Numberlines
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
set(handles.goon,'Enable','Off');
set(handles.display1,'String',handles.voc{2,handles.cur});
set(handles.display2,'String',' ');
set(handles.sentence,'String',' ');
set(handles.rightanswer,'String',' ');
set(handles.input,'Enable','On');
delete(handles.figure2);
view(handles)


% --- Executes on key press with focus on input and none of its controls.
function input_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to input (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
% if eventdata.Character=='1'
%     uiresume(gcbf)
% end

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over input.
function input_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over ok.
function ok_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on ok and none of its controls.
function ok_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ok (see GCBO)
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


% --- Executes on button press in next.
function next_Callback(hObject, eventdata, handles)
% hObject    handle to next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.next,'Enable','Off');
uicontrol(handles.input);
uiresume(gcbf)


