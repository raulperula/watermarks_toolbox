function varargout = modeloSecuencia(varargin)
% MODELOSECUENCIA M-file for modeloSecuencia.fig
%      MODELOSECUENCIA, by itself, creates a new MODELOSECUENCIA or raises the existing
%      singleton*.
%
%      H = MODELOSECUENCIA returns the handle to a new MODELOSECUENCIA or the handle to
%      the existing singleton*.
%
%      MODELOSECUENCIA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MODELOSECUENCIA.M with the given input arguments.
%
%      MODELOSECUENCIA('Property','Value',...) creates a new MODELOSECUENCIA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before modeloSecuencia_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to modeloSecuencia_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help modeloSecuencia

% Last Modified by GUIDE v2.5 08-Sep-2009 15:25:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @modeloSecuencia_OpeningFcn, ...
                   'gui_OutputFcn',  @modeloSecuencia_OutputFcn, ...
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


% --- Executes just before modeloSecuencia is made visible.
function modeloSecuencia_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to modeloSecuencia (see VARARGIN)

% Choose default command line output for modeloSecuencia
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes modeloSecuencia wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = modeloSecuencia_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


