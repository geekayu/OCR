function varargout = ocr_start(varargin)
%ocr_start M-file for ocr_start.fig
%      ocr_start, by itself, creates a new ocr_start or raises the existing
%      singleton*.
%
%      H = ocr_start returns the handle to a new ocr_start or the handle to
%      the existing singleton*.
%
%      ocr_start('Property','Value',...) creates a new ocr_start using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to ocr_start_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      ocr_start('CALLBACK') and ocr_start('CALLBACK',hObject,...) call the
%      local function named CALLBACK in ocr_start.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ocr_start

% Last Modified by GUIDE v2.5 31-Aug-2017 22:07:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ocr_start_OpeningFcn, ...
                   'gui_OutputFcn',  @ocr_start_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before ocr_start is made visible.
function ocr_start_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for ocr_start
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ocr_start wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ocr_start_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

        %---Create New Template Button---
% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
          '*.*','All Files' });
if filename
    filename = fullfile(pathname, filename)
    set(handles.uipanel5,'Visible','on')
    addpath('template')
    imshow(filename,'Parent',handles.axes1)
    [x,y] = imread(filename);
    assignin('base','y',y)
    assignin('base','x',x)
    run('generate_template')    
    rmpath('template')
    cla(handles.axes1)
    set(handles.uipanel5,'Visible','off')
    
    
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
          '*.*','All Files' });
if filename
    filename = fullfile(pathname, filename)
    set(handles.uipanel5,'Visible','on')
    imshow(filename,'Parent',handles.axes1)
    addpath(pathname)
    [x,y] = imread(filename);
    assignin('base','y',y)
    assignin('base','x',x)
    run('ocr')
    rmpath(pathname)
    cla(handles.axes1)
    set(handles.uipanel5,'Visible','off')
    
end
