function varargout = schedule(varargin)
% SCHEDULE M-file for schedule.fig
%      SCHEDULE, by itself, creates a new SCHEDULE or raises the existing
%      singleton*.
%
%      H = SCHEDULE returns the handle to a new SCHEDULE or the handle to
%      the existing singleton*.
%
%      SCHEDULE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SCHEDULE.M with the given input arguments.
%
%      SCHEDULE('Property','Value',...) creates a new SCHEDULE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before schedule_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to schedule_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help schedule

% Last Modified by GUIDE v2.5 07-Sep-2011 14:22:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @schedule_OpeningFcn, ...
                   'gui_OutputFcn',  @schedule_OutputFcn, ...
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


% --- Executes just before schedule is made visible.
function schedule_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to schedule (see VARARGIN)

% Choose default command line output for schedule
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes schedule wait for user response (see UIRESUME)
% uiwait(handles.figure1);

Schedule=varargin{1};
g=[50 20 450 300];
t = uitable(handles.figure1, 'Data', Schedule{1},'Position',g);

% --- Outputs from this function are returned to the command line.
function varargout = schedule_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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
