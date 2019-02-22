function varargout = bio_intel_palm(varargin)
% BIO_INTEL_PALM MATLAB code for bio_intel_palm.fig
%      BIO_INTEL_PALM, by itself, creates a new BIO_INTEL_PALM or raises the existing
%      singleton*.
%
%      H = BIO_INTEL_PALM returns the handle to a new BIO_INTEL_PALM or the handle to
%      the existing singleton*.
%
%      BIO_INTEL_PALM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BIO_INTEL_PALM.M with the given input arguments.
%
%      BIO_INTEL_PALM('Property','Value',...) creates a new BIO_INTEL_PALM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before bio_intel_palm_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to bio_intel_palm_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help bio_intel_palm

% Last Modified by GUIDE v2.5 12-Jul-2013 15:00:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @bio_intel_palm_OpeningFcn, ...
                   'gui_OutputFcn',  @bio_intel_palm_OutputFcn, ...
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


% --- Executes just before bio_intel_palm is made visible.
function bio_intel_palm_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to bio_intel_palm (see VARARGIN)

% Choose default command line output for bio_intel_palm
handles.output = hObject;
set(handles.load_image,'enable','on');
set(handles.process_data,'enable','off');
set(handles.match,'enable','off');
axis off;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes bio_intel_palm wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = bio_intel_palm_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



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


% --- Executes on button press in load_image.
function load_image_Callback(hObject, eventdata, handles)
% hObject    handle to load_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
[file, path] = uigetfile('*.jpeg;*.jpg;*.bmp', 'Pick a File');
filea=strcat(path,file);
I=imread(filea);
[handles.Left_Image,handles.Left_Mask,handles.Right_Image,handles.Right_Mask]=segment_palm(I);

axes(handles.axes1);
imshow(handles.Left_Image);

axes(handles.axes2);
imshow(handles.Right_Image);
set(handles.process_data,'enable','on');
handles.output = hObject;
guidata(hObject, handles);



% --- Executes on button press in process_data.
function process_data_Callback(hObject, eventdata, handles)
% hObject    handle to process_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.New_L_features, New_L_valid_corners,handles.New_R_features, New_R_valid_corners]=palm_features(handles.Left_Image,handles.Left_Mask,handles.Right_Image,handles.Right_Mask);
% disp('ok');
handles.New_L_valid_corners=New_L_valid_corners;
handles.New_R_valid_corners=New_R_valid_corners;
axes(handles.axes1);
hold on
for i=1:10:size(New_L_valid_corners,1)
plot(New_L_valid_corners(i));
drawnow;
end

axes(handles.axes2);
hold on
for i=1:10:size(New_R_valid_corners,1)
plot(New_R_valid_corners(i));
drawnow;
end
set(handles.match,'enable','on');
handles.output = hObject;
guidata(hObject, handles);


% --- Executes on button press in match.
function match_Callback(hObject, eventdata, handles)
% hObject    handle to match (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 root='E:\RESEARCH WORK\BIOMETRIC SYSTEM\Multimodal Biometrics\DFeature_mat\';
 root1='E:\RESEARCH WORK\BIOMETRIC SYSTEM\Multimodal Biometrics\D_mat\';
for i=1:21
   
    load(sprintf('%s%iF.mat',root,i));
    load(sprintf('%s%i.mat',root1,i));
% [OLeft_Image,OLeft_Mask,ORight_Image,ORight_Mask]=segment_palm(Palm);
disp('Matching...');
[L_matched_pts1,L_matched_pts2,R_matched_pts1,R_matched_pts2,L_match_score,R_match_score]=palm_matching(L_features, L_valid_corners,R_features, R_valid_corners,handles.New_L_features, handles.New_L_valid_corners,handles.New_R_features, handles.New_R_valid_corners);

count=0;
for lo=1:size(L_match_score,1)
if(L_match_score(lo) == 0 ||L_match_score(lo)==1 || L_match_score(lo)==2|| L_match_score(lo)==3 ||L_match_score(lo)==4 || L_match_score(lo)==5|| L_match_score(lo)==6|| L_match_score(lo)==7|| L_match_score(lo)==8|| L_match_score(lo)==9|| L_match_score(lo)==10)
count=count+1;
end
end
per1 = count*100/size(L_match_score,1);
count=0;
for lo=1:size(R_match_score,1)
if(R_match_score(lo) == 0 ||R_match_score(lo)==1 || R_match_score(lo)==2|| R_match_score(lo)==3 ||R_match_score(lo)==4 || R_match_score(lo)==5|| R_match_score(lo)==6|| R_match_score(lo)==7|| R_match_score(lo)==8|| R_match_score(lo)==9|| R_match_score(lo)==10)
count=count+1;
end
end
per2 = count*100/size(R_match_score,1);
Percent(i)=per1+per2;
end
% if((mode(L_match_score)+mode(R_match_score))<=10)
% Percent{i}=100-(mode(L_match_score)+mode(R_match_score))*10;
% disp(sprintf('Matching Percentage = %i',Percent{i}));

    
    [val indx]=max(Percent);
    val
    load(sprintf('%s%i.mat',root1,indx));
    axes(handles.axes3); imshow(Face);
    set(handles.text4,'String',Name);
    set(handles.text5,'String',indx);
    Percent(indx)=[];
 
     
     [val indx]=max(Percent);
     val
    load(sprintf('%s%i.mat',root1,indx));
    axes(handles.axes4); imshow(Face);
    Percent(indx)=[];
    
    [val indx]=max(Percent);
    val
    load(sprintf('%s%i.mat',root1,indx));
    axes(handles.axes5); imshow(Face);
    Percent(indx)=[];
    
    [val indx]=max(Percent);
    val
    load(sprintf('%s%i.mat',root1,indx));
    axes(handles.axes6);imshow(Face);
    Percent(indx)=[];
%     
%     
% if Percent{i}>90
%     axes(handles.axes3); 
%     imshow(Face);
%     set(handles.text4,'String',Name);
%     set(handles.text5,'String',i);
% 
% elseif Percent{i}>80 && Percent{i}<90
%     axes(handles.axes4); 
%     imshow(Face);
% %     set(handles.text4,'String',Name);
% 
% elseif Percent{i}>70 && Percent{i}<80
%     axes(handles.axes5); 
%     imshow(Face);
% %     set(handles.text4,'String',Name);
% 
% elseif Percent{i}>50 && Percent{i}<60
%    axes(handles.axes6); 
%     imshow(Face);
% %     set(handles.text4,'String',Name);
% 
% elseif Percent{i}>50 && Percent{i}<60
%    axes(handles.axes7); 
%     imshow(Face);
% %     set(handles.text4,'String',Name);
% 
% % else
% %     disp('Not Matched');
% end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
