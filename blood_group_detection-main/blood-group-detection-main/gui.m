function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 16-Apr-2023 13:27:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im im2
[path,user_cance]=imgetfile();
if user_cance
    msgbox(sprintf('Error'),'Error','Error');
    return
end
im=imread(path);
im=im2double(im);
im2=im;
axes(handles.axes2);
imshow(im);

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global imbinary img1 img2 img3
[r, c, d]=size(imbinary);
img1=imbinary(:,(1:c/3),:);
axes(handles.axes4);
imshow(img1);
img2=imbinary(:,(c/3)+1:2*c/3,:);
axes(handles.axes5);
imshow(img2);
img3=imbinary(:,(2*c/3)+1:c,:);
axes(handles.axes6);
imshow(img3);

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im imbinary
imbinary=im2bw(im);
axes(handles.axes2);
imshow(imbinary);

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img1 img2 img3
x1 = 30;
y1 = 30;
width = 600;
height = 600;

crop1 = imcrop(img1, [x1, y1, width, height]);
numBlackPixels(1) = sum(crop1(:) == 0);
disp(['Number of Black pixels:' num2str(numBlackPixels(1))]);

crop2 = imcrop(img2, [x1, y1, width, height]);
numBlackPixels(2) = sum(crop2(:) == 0);
disp(['Number of Black pixels:' num2str(numBlackPixels(2))]);


crop3 = imcrop(img3, [x1, y1, width, height]);
numBlackPixels(3) = sum(crop3(:) == 0);
disp(['Number of Black pixels:' num2str(numBlackPixels(3))]);

for i=1:3
    if (numBlackPixels(i)<40000)
        anti(i)=1
    else
        anti(i)=0
    end
end

if (anti(1)==0 && anti(2)==0 && anti(3)==1)
    c='O+';
elseif (anti(1)==0 &&anti(2)==0 && anti(3)==0)
   c='O-';
elseif (anti(1)==1 &&anti(2)==0 && anti(3)==1)
   c='A+';
elseif (anti(1)==1 &&anti(2)==0 && anti(3)==0)
   c='A-';
elseif (anti(1)==0 &&anti(2)==1 && anti(3)==1)
   c='B+';
elseif (anti(1)==0 &&anti(2)==1 && anti(3)==0)
   c='B-';
elseif (anti(1)==1 &&anti(2)==1 && anti(3)==1)
   c='AB+';
elseif (anti(1)==1 &&anti(2)==1 && anti(3)==0)
   c='AB-';
end

set(handles.edit1,'string',c);

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
