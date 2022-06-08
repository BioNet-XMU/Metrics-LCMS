function varargout = DataFilter(varargin)
% DATAFILTER MATLAB code for DataFilter.fig
%      DATAFILTER, by itself, creates a new DATAFILTER or raises the existing
%      singleton*.
%
%      H = DATAFILTER returns the handle to a new DATAFILTER or the handle to
%      the existing singleton*.
%
%      DATAFILTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DATAFILTER.M with the given input arguments.
%
%      DATAFILTER('Property','Value',...) creates a new DATAFILTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DataFilter_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DataFilter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DataFilter

% Last Modified by GUIDE v2.5 07-Jul-2020 17:09:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DataFilter_OpeningFcn, ...
                   'gui_OutputFcn',  @DataFilter_OutputFcn, ...
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


% --- Executes just before DataFilter is made visible.
function DataFilter_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DataFilter (see VARARGIN)

% Choose default command line output for DataFilter
set(handles.chkSepr,'Value',1);
set(handles.chkMax,'Value',0);
handles.matAdducts = [];
handles.matIsotope = [];
handles.nIsotope = 0;
handles.nAdducts = 0;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DataFilter wait for user response (see UIRESUME)
% uiwait(handles.fitDataFilter);


% --- Outputs from this function are returned to the command line.
function varargout = DataFilter_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
%delete(handles.fitDataFilter);


% --- Executes on button press in chkSepr.
function chkSepr_Callback(hObject, eventdata, handles)
% hObject    handle to chkSepr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkSepr


% --- Executes on button press in chkMax.
function chkMax_Callback(hObject, eventdata, handles)
% hObject    handle to chkMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkMax


% --- Executes on button press in pBtnRead.
function pBtnRead_Callback(hObject, eventdata, handles)
% hObject    handle to pBtnRead (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% 启动读取文件对话框
[FileName,PathName]=uigetfile('*.csv','Select Progenesis QI files');

% 没有'MultiSelect'选项，因此FileName不是cell型数据，可以用 == 操作
if FileName==0, return; end

% 改变当前的工作目录
cd(PathName);

[handles.matAdducts,handles.matIsotope,handles.nTotal] = ReadRawData([PathName,FileName]);
if isempty(handles.matAdducts)
    handles.nAdducts = 0;
else
    handles.nAdducts = size(handles.matAdducts,1)-1;
end
set(handles.editAdd,'String',sprintf('%d',handles.nAdducts));
if isempty(handles.matIsotope)
    handles.nIsotope = 0;
else
    handles.nIsotope = size(handles.matIsotope,1)-1;
end
set(handles.editIso,'String',sprintf('%d',handles.nIsotope));

guidata(hObject, handles);


% --- Executes on button press in pBtnSave.
function pBtnSave_Callback(hObject, eventdata, handles)
% hObject    handle to pBtnSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(handles.matAdducts) && isempty(handles.matIsotope)
    msgbox('Please Read Raw Data File first!');
    return;
end

nMax = str2double(get(handles.editMax,'String'));
if get(handles.chkMax,'Value')==1
    if isnan(nMax)
        msgbox('Input Number is incorrect!');
        return;
    elseif nMax<1
        msgbox('Input Number is incorrect!');
        return;
    else
    end
end
nMax = nMax-1;
[filename, pathname] = uiputfile({'*.xlsx'}, 'Save Data File (*.xlsx)');
if filename==0, return;end
strFile = [pathname filename];
clear filename pathname;

matTitle = handles.matAdducts(1,:);
if get(handles.chkSepr,'Value')==0
    if get(handles.chkMax,'Value')==0
        xlswrite(strFile,[handles.matAdducts;handles.matIsotope(2:end,:)]);
    else
        matData  = [handles.matAdducts(2:end,:);handles.matIsotope(2:end,:)];
        nTotal = handles.nAdducts + handles.nIsotope;
        iCount = 1;
        nIndex = 0;
        while (iCount <= nTotal)
            nIndex = nIndex + 1;            
            iEnd = min(iCount + nMax,nTotal);            
            xlswrite([strFile(1:end-5),sprintf('_%d.xlsx',nIndex)],[matTitle;matData(iCount:iEnd,:)]);            
            iCount = iEnd + 1;
        end
    end
else
    if get(handles.chkMax,'Value')==0
        xlswrite([strFile(1:end-5),'-Adducts.xlsx'],handles.matAdducts);
        xlswrite([strFile(1:end-5),'-Isotope.xlsx'],handles.matIsotope);
    else
        matData  = handles.matAdducts(2:end,:);
        nTotal =  handles.nAdducts;
        iCount = 1;
        nIndex = 0;
        while (iCount <= nTotal)
            nIndex = nIndex + 1;            
            iEnd = min(iCount + nMax,nTotal);            
            xlswrite([strFile(1:end-5),sprintf('-Adducts_%d.xlsx',nIndex)],[matTitle;matData(iCount:iEnd,:)]);            
            iCount = iEnd + 1;
        end
        
        matTitle = handles.matIsotope(1,:);
        matData  = handles.matIsotope(2:end,:);
        nTotal = handles.nIsotope;
        iCount = 1;
        nIndex = 0;
        while (iCount <= nTotal)
            nIndex = nIndex + 1;
            iEnd = min(iCount + nMax,nTotal);
            xlswrite([strFile(1:end-5),sprintf('-Isotope_%d.xlsx',nIndex)],[matTitle;matData(iCount:iEnd,:)]);            
            iCount = iEnd + 1;
        end
    end
end
clear matData matTitle nTotal iCout nIndex iEnd nMax;


% --- Executes on button press in pBtnOK.
function pBtnOK_Callback(hObject, eventdata, handles)
% hObject    handle to pBtnOK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.fitDataFilter);


function editMax_Callback(hObject, eventdata, handles)
% hObject    handle to editMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editMax as text
%        str2double(get(hObject,'String')) returns contents of editMax as a double


% --- Executes during object creation, after setting all properties.
function editMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editAdd_Callback(hObject, eventdata, handles)
% hObject    handle to editAdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editAdd as text
%        str2double(get(hObject,'String')) returns contents of editAdd as a double


% --- Executes during object creation, after setting all properties.
function editAdd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editAdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editIso_Callback(hObject, eventdata, handles)
% hObject    handle to editIso (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editIso as text
%        str2double(get(hObject,'String')) returns contents of editIso as a double


% --- Executes during object creation, after setting all properties.
function editIso_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editIso (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
