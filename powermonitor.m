function varargout = powermonitor(varargin)
% POWERMONITOR MATLAB code for powermonitor.fig
%      POWERMONITOR, by itself, creates a new POWERMONITOR or raises the existing
%      singleton*.
%
%      H = POWERMONITOR returns the handle to a new POWERMONITOR or the handle to
%      the existing singleton*.
%
%      POWERMONITOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in POWERMONITOR.M with the given input arguments.
%
%      POWERMONITOR('Property','Value',...) creates a new POWERMONITOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before powermonitor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to powermonitor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help powermonitor

% Last Modified by GUIDE v2.5 03-Oct-2018 10:43:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @powermonitor_OpeningFcn, ...
                   'gui_OutputFcn',  @powermonitor_OutputFcn, ...
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


% --- Executes just before powermonitor is made visible.
function powermonitor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to powermonitor (see VARARGIN)

% Choose default command line output for powermonitor
handles.output = hObject;

% Initialize some variables
handles.data.power = [];
handles.data.times = [];
handles.pyscript = 'GetMffData.py';
handles.freqres = 0.5;
handles.lockthr = false;
handles.channels = 1:256;
handles.watchlist = [];
handles.loglist = [];
handles.regions.front = [2,3,4,5,10,11,12,13,14,15,18,19,20,21,22,25,26,27,28,29,31,32,33,34,35,37,38,39,46,47];
handles.regions.central = [57,50,42,24,16,7,207,206,205,204,64,58,51,43,17,8,198,197,196,195,194,71,65,59,52,44,9,186,185,184,183,182,181,72,66,60,53,45,132,144,155,164,173,76,77,78,79,80,81,131,143,154,163,172,88,89,90,130,142];
handles.regions.posterior = [96,97,98,110,119,128,152,161,170,106,107,108,109,140,151,160,169,114,115,116,117,118,127,139,150,159,168,122,123,124,125,126,138,149,158,167,135,136,137,148,157,147];
handles.regions.l_temporal = [243,242,241,247,246,245,244,251,250,249,248,252,256,255,254,253,67,73,82,68,69,91,92,74,93,83,94,102,103,104,111];
handles.regions.r_temporal = [238,239,240,234,235,236,237,230,226,231,232,225,227,233,219,228,218,210,229,217,202,192,216,191,209,190,201,189,200,208,199];

% Tabs Code
% Settings
TabFontSize = 10;
TabNames = {'Settings','Watch','Data'};
FigWidth = .5;

% Figure resize
set(handles.figure1,'Units','normalized')
pos = get(handles. figure1, 'Position');
set(handles. figure1, 'Position', [pos(1) pos(2) FigWidth pos(4)])

% Tabs Execution
handles = TabsFun(handles,TabFontSize,TabNames);

%Start EEGLab
eeglab
handles.EEG = pop_loadset('EEG_Template.set');
handles.EEG.chanlocs = readlocs('chanlocs_prop256.sfp');

path1 = getenv('PATH');
path1 = ['/anaconda3/bin/:' path1];
setenv('PATH',path1);

figure(handles.figure1)

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes powermonitor wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = powermonitor_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function FilepathTextBox_Callback(hObject, eventdata, handles)
% hObject    handle to FilepathTextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FilepathTextBox as text
%        str2double(get(hObject,'String')) returns contents of FilepathTextBox as a double


% --- Executes during object creation, after setting all properties.
function FilepathTextBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FilepathTextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function OutpathTextBox_Callback(hObject, eventdata, handles)
% hObject    handle to OutpathTextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of OutpathTextBox as text
%        str2double(get(hObject,'String')) returns contents of OutpathTextBox as a double


% --- Executes during object creation, after setting all properties.
function OutpathTextBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OutpathTextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in OutButton.
function OutButton_Callback(hObject, eventdata, handles)
% hObject    handle to OutButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
outpath = uigetdir;
handles.outpath = outpath;
handles.OutpathTextBox.String = outpath;


% --- Executes on button press in LoadButton.
function LoadButton_Callback(hObject, eventdata, handles)
% hObject    handle to LoadButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,filepath]=uigetfile({'*.*','EGI mff files'},'Select MFF File');
handles.filename = filename;
handles.filepath = filepath;
handles.FilepathTextBox.String = [filepath filename];


function RefreshRateTextBox_Callback(hObject, eventdata, handles)
% hObject    handle to RefreshRateTextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RefreshRateTextBox as text
%        str2double(get(hObject,'String')) returns contents of RefreshRateTextBox as a double
refrate = str2num(hObject.String);
lowfreq = str2num(handles.LowFreqTextBox.String);
if isempty(lowfreq)
    hObject.String = '10';
    warndlg('Input must be numeric');
elseif refrate < (1/lowfreq)*10 || refrate < 5 %Ensure we have at least 10 cycles of data
    hObject.String = '10';
    warndlg('Input cannot be less than (1/LowFreq)*10 with an absolute minimum of 5');    
end

% --- Executes during object creation, after setting all properties.
function RefreshRateTextBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RefreshRateTextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function LowFreqTextBox_Callback(hObject, eventdata, handles)
% hObject    handle to LowFreqTextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LowFreqTextBox as text
%        str2double(get(hObject,'String')) returns contents of LowFreqTextBox as a double
lowfreq = hObject.String;
if isempty(str2num(lowfreq))
    hObject.String = '1';
    warndlg('Input must be numeric');
end

% --- Executes during object creation, after setting all properties.
function LowFreqTextBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LowFreqTextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function HighFreqTextBox_Callback(hObject, eventdata, handles)
% hObject    handle to HighFreqTextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of HighFreqTextBox as text
%        str2double(get(hObject,'String')) returns contents of HighFreqTextBox as a double
highfreq = hObject.String;
if isempty(str2num(highfreq))
    hObject.String = '40';
    warndlg('Input must be numeric');
end
if str2num(highfreq) <= str2num(handles.LowFreqTextBox.String)
    warndlg('Upper limit must be larger than lower limit');
    hObject.String = num2str(str2num(handles.LowFreqTextBox.String)+1);
end

% --- Executes during object creation, after setting all properties.
function HighFreqTextBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to HighFreqTextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ThrTextBox_Callback(hObject, eventdata, handles)
% hObject    handle to ThrTextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ThrTextBox as text
%        str2double(get(hObject,'String')) returns contents of ThrTextBox as a double
thr = hObject.String;
if isempty(str2num(thr))
    hObject.String = '80';
    warndlg('Input must be numeric');
end

% --- Executes during object creation, after setting all properties.
function ThrTextBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ThrTextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ThrListBox.
function ThrListBox_Callback(hObject, eventdata, handles)
% hObject    handle to ThrListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ThrListBox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ThrListBox


% --- Executes during object creation, after setting all properties.
function ThrListBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ThrListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
hObject.String = {};

% --- Executes on button press in AddThrButton.
function AddThrButton_Callback(hObject, eventdata, handles)
% hObject    handle to AddThrButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
newthr = handles.ThrTextBox.String;
thrlist_contents = cellstr(handles.ThrListBox.String)';
new_contents = [thrlist_contents newthr];
new_contents = strsplit(num2str(sort(unique(cellfun(@str2num,new_contents)))));
handles.ThrListBox.String = new_contents;

% --- Executes on button press in RemThrButton.
function RemThrButton_Callback(hObject, eventdata, handles)
% hObject    handle to RemThrButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(handles.ThrListBox.String);
contents{handles.ThrListBox.Value} = [];
contents = contents(~cellfun('isempty',contents));
handles.ThrListBox.String = contents;

% --- Executes on button press in LockThrButton.
function LockThrButton_Callback(hObject, eventdata, handles)
% hObject    handle to LockThrButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Lock the current thresholds
selection = questdlg('Lock the current percentile values?','','Yes','No','');
switch selection
    case 'Yes'
        handles.lockthr = true;
        handles.AddThrButton.Enable = 'off';
        handles.RemThrButton.Enable = 'off';
        handles.LockThrButton.Enable = 'off';
                
        handles.LockIdx = length(handles.data.power);
        fprintf(handles.logfile, 'Threshold locked,Threshold locked,Threshold locked\n');
        
        guidata(hObject, handles);
    case 'No'
        return
end

% --- Executes on button press in StartButton.
function StartButton_Callback(hObject, eventdata, handles)
% hObject    handle to StartButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pathname = handles.FilepathTextBox.String;
if(exist(pathname, 'file') == 7 && ~isempty(handles.watchlist))
    handles.PauseButton.Enable = 'on';
    handles.LockThrButton.Enable = 'on';
    handles.StartButton.Enable = 'off';
    handles.LowFreqTextBox.Enable = 'off';
    handles.HighFreqTextBox.Enable = 'off';
    handles.RefreshRateTextBox.Enable = 'off';
    handles.ChanTextBox.Enable = 'off';
    handles.FrontalCheck.Enable = 'off';
    handles.CentralCheck.Enable = 'off';
    handles.LTempCheck.Enable = 'off';
    handles.RTempCheck.Enable = 'off';
    handles.PosteriorCheck.Enable = 'off';    
    handles.RunLoop = true;
    guidata(hObject, handles);
    
    %Monitor function
    freqres = handles.freqres;
    refreshrate = str2num(handles.RefreshRateTextBox.String);
    
    file = dir(handles.FilepathTextBox.String); 
    lastUpdated = file.date;
    startTime = datetime(clock);
    lastTime = datetime(clock);
    while handles.RunLoop
        handles = guidata(hObject);
        currentTime = datetime(clock);
        if (currentTime - lastTime) >= duration(0,0,refreshrate)                     
            commandStr = ['python ' handles.pyscript ' "' handles.FilepathTextBox.String '" ' int2str(refreshrate)];
            [status, commandOut] = system(commandStr);
            lastTime = datetime(clock);
            if status == 0
                loadtime = str2double(commandOut);
                sprintf('Load time was: %f',loadtime)
                if loadtime > refreshrate
                   error('File load-time has exceeded the specified time interval.')
                end
            end
        end
        powerfile = dir('Power.csv');
        if ~isempty(powerfile) && ~strcmp(powerfile.date, lastUpdated)
            disp('Updated') 
            lastUpdated = powerfile.date;
            eegdat = csvread('Power.csv');
            eegtimes = csvread('Times.csv');
            
            %Update EEG object with most recent data
            EEG = handles.EEG;
            EEG.data = eegdat(handles.channels,:);
            EEG.chanlocs = EEG.chanlocs(handles.channels);
            EEG.times = eegtimes;
            EEG = eeg_checkset(EEG); 
            EEG.data = EEG.data * 10^6; %Convert from volts to microvolts
            EEG = pop_eegfiltnew(EEG, 0.5, 40);
            EEG = pop_reref(EEG, []);
            
            %Calculate Power
            [dataPow, ff] = pwelch(EEG.data',round(EEG.srate/freqres),[],round(EEG.srate/freqres),EEG.srate);
            %Update data logs for each watch in watchlist
            for iWatch = 1:length(handles.watchlist)
                watch = handles.watchlist(iWatch);
                lowfreq = watch.low_freq;              
                highfreq = watch.high_freq;  
                Band = round([lowfreq/freqres+1 highfreq/freqres]);

                bandpower = mean(dataPow(Band(1):Band(2),:),1);
                avgpower = mean(bandpower);
                avgpower = log10(avgpower);
               
                %Update data storage variables
                watch.power = [watch.power avgpower];
                watch.times = [watch.power avgpower];
                watch.bandpower = bandpower;
                
                %Calculate percentile
                if(isfield(handles,'LockIdx'))
                    lockidx = handles.LockIdx;
                    lockpow = watch.power(1:lockidx); 

                    nless = sum(lockpow < avgpower);
                    nequal = sum(lockpow == avgpower);
                    percentile = 100*(nless + 0.5*nequal)/length(lockpow);
                else
                    nless = sum(watch.power < avgpower);
                    nequal = sum(watch.power == avgpower);
                    percentile = 100*(nless + 0.5*nequal)/length(watch.power);
                end
                watch.percentiles = [watch.percentiles percentile];
                
                %Update handles
                handles.watchlist(iWatch) = watch;
                guidata(hObject, handles);
            end       
            display_watch = handles.watchlist(handles.WatchListBox.Value);
            
            %Calculate data range to display
            axislims = [median(display_watch.power) - 3*mad(display_watch.power) median(display_watch.power) + 3*mad(display_watch.power)];
            if(axislims(1) >= axislims(2))
                axislims(1) = axislims(1)/2;
                axislims(2) = axislims(2)*2;
            end
            
            %Data table
            prevdata = handles.PrevDataTable;
            
            pow = display_watch.power;
            times = display_watch.times;
                                   
            %Update UI Table
            tab = table(pow, display_watch.percentiles, times);
            tab = sortrows(tab,3,'descend');
            if(size(tab,1) > 30) tab = tab(1:30,:); end %Keep 30 most recent data points in table
            handles.PrevDataTable.Data = tab;           %Equiv. of 5 minutes of data sampled every 10 sec

            %Topoplot
            axes(handles.TopoAxis);
            cla
            topoplot(log10(display_watch.bandpower), EEG.chanlocs); 
            title(sprintf('Power %d - %d Hz',display_watch.lowfreq,display_watch.highfreq));
            colorbar;

            %Histogram
            axes(handles.HistAxis);
            histogram(display_watch.power, 15)
            xlabel('Log10 Power');
            xlim(axislims)

            %Scatter Plot
            thrlist_contents = cellstr(handles.ThrListBox.String)';
            axes(handles.ScatterAxis);
            scatter(display_watch.times, display_watch.power); hold on;
            ylabel('Log10 Power');
            thr_val = Inf;
            for thr_str = thrlist_contents %Add percentile threshold lines to plot
                thr = str2num(cell2mat(thr_str));
                if(isfield(handles,'LockIdx'))
                    thr_val = prctile(lockpow, thr);
                else
                    thr_val = prctile(pow, thr);
                end
                line([min(display_watch.times) max(display_watch.times)],[thr_val thr_val], 'Color', 'black', 'LineStyle', '--');
            end
            %Plot data above threshold as red
            color_points = display_watch.power > thr_val;
            scatter(display_watch.times(color_points), display_watch.power(color_points),'r'); hold off;
            ylim(axislims)

            %Update GUI
            drawnow
            
            %Write output to log file
            for iLog = 1:length(handles.loglist)
               log = handles.loglist(iLog);
               npow = handles.watchlist(iLog).power(end);
               ntime = handles.watchlist(iLog).percentiles(end);
               nperc = handles.watchlist(iLog).times(end);
               fprintf(log, '%d, %d, %d\n',npow, nperc, ntime); 
            end
        end
        handles = guidata(hObject); %Update handles to check if the loop needs to break
    end
else
    warndlg('Select a MFF file and frequency range to monitor');
end


% --- Executes on button press in PauseButton.
function PauseButton_Callback(hObject, eventdata, handles)
% hObject    handle to PauseButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.PauseButton.Enable = 'off';
handles.StartButton.Enable = 'on';
handles.LowFreqTextBox.Enable = 'off';
handles.HighFreqTextBox.Enable = 'off';
handles.RefreshRateTextBox.Enable = 'off';
handles.RunLoop = false;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function ScatterAxis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ScatterAxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function TopoAxis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TopoAxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function HistAxis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to HistAxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% --- Executes during object creation, after setting all properties.
function PrevDataTable_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PrevDataTable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function ChanTextBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ChanTextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ChanTextBox_Callback(hObject, eventdata, handles)
% hObject    handle to ChanTextBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ChanTextBox as text
%        str2double(get(hObject,'String')) returns contents of ChanTextBox as a double
channels = str2num(hObject.String);
if isempty(channels)
    channels = 1:256;
    hObject.String = '1:256';
    warndlg('Input must be numeric');
else
    handles.channels = channels;
    handles.FrontalCheck.Value = double(all(ismember(handles.regions.front,channels)));
    handles.CentralCheck.Value = double(all(ismember(handles.regions.central,channels)));
    handles.PosteriorCheck.Value = double(all(ismember(handles.regions.posterior,channels)));
    handles.LTempCheck.Value = double(all(ismember(handles.regions.l_temporal,channels)));
    handles.RTempCheck.Value = double(all(ismember(handles.regions.r_temporal,channels)));
    guidata(hObject, handles);
end
%Display channels that will be used for power calculation
UpdateChannelPlot(handles);

% --- Executes on button press in FrontalCheck.
function FrontalCheck_Callback(hObject, eventdata, handles)
% hObject    handle to FrontalCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of FrontalCheck
checked = get(hObject,'Value');
if checked
    handles.channels = union(handles.channels, handles.regions.front);
    handles.ChanTextBox.String = regexprep(num2str(handles.channels),' +',' ');
    guidata(hObject, handles);
    UpdateChannelPlot(handles);
else
    handles.channels = setdiff(handles.channels, handles.regions.front);
    handles.ChanTextBox.String = regexprep(num2str(handles.channels),' +',' ');
    guidata(hObject, handles);
    UpdateChannelPlot(handles);
end

% --- Executes on button press in LTempCheck.
function LTempCheck_Callback(hObject, eventdata, handles)
% hObject    handle to LTempCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LTempCheck
checked = get(hObject,'Value');
if checked
    handles.channels = union(handles.channels, handles.regions.l_temporal);
    handles.ChanTextBox.String = regexprep(num2str(handles.channels),' +',' ');
    guidata(hObject, handles);
    UpdateChannelPlot(handles);
else
    handles.channels = setdiff(handles.channels, handles.regions.l_temporal);
    handles.ChanTextBox.String = regexprep(num2str(handles.channels),' +',' ');
    guidata(hObject, handles);
    UpdateChannelPlot(handles);
end

% --- Executes on button press in RTempCheck.
function RTempCheck_Callback(hObject, eventdata, handles)
% hObject    handle to RTempCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of RTempCheck
checked = get(hObject,'Value');
if checked
    handles.channels = union(handles.channels, handles.regions.r_temporal);
    handles.ChanTextBox.String = regexprep(num2str(handles.channels),' +',' ');
    guidata(hObject, handles);
    UpdateChannelPlot(handles);
else
    handles.channels = setdiff(handles.channels, handles.regions.r_temporal);
    handles.ChanTextBox.String = regexprep(num2str(handles.channels),' +',' ');
    guidata(hObject, handles);
    UpdateChannelPlot(handles);
end

% --- Executes on button press in PosteriorCheck.
function PosteriorCheck_Callback(hObject, eventdata, handles)
% hObject    handle to PosteriorCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of PosteriorCheck
checked = get(hObject,'Value');
if checked
    handles.channels = union(handles.channels, handles.regions.posterior);
    handles.ChanTextBox.String = regexprep(num2str(handles.channels),' +',' ');
    guidata(hObject, handles);
    UpdateChannelPlot(handles);
else
    handles.channels = setdiff(handles.channels, handles.regions.posterior);
    handles.ChanTextBox.String = regexprep(num2str(handles.channels),' +',' ');
    guidata(hObject, handles);
    UpdateChannelPlot(handles);
end

% --- Executes on button press in CentralCheck.
function CentralCheck_Callback(hObject, eventdata, handles)
% hObject    handle to CentralCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CentralCheck
checked = get(hObject,'Value');
if checked
    handles.channels = union(handles.channels, handles.regions.central);
    handles.ChanTextBox.String = regexprep(num2str(handles.channels),' +',' ');
    guidata(hObject, handles);
    UpdateChannelPlot(handles);
else
    handles.channels = setdiff(handles.channels, handles.regions.central);
    handles.ChanTextBox.String = regexprep(num2str(handles.channels),' +',' ');
    guidata(hObject, handles);
    UpdateChannelPlot(handles);
end

function UpdateChannelPlot(handles)
axes(handles.TopoAxis);
cla
topoplot([], handles.EEG.chanlocs(handles.channels), 'style','blank','electrodes','labels');

% --- Executes on selection change in WatchListBox.
function WatchListBox_Callback(hObject, eventdata, handles)
% hObject    handle to WatchListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function WatchListBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WatchListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in AddWatchButton.
% Add item to WatchListBox using the values currently set in LowFreqTextBox, HighFreqTextBox, and ChanTextBox
function AddWatchButton_Callback(hObject, eventdata, handles)
% hObject    handle to AddWatchButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
new_watch = [];
new_watch.low_freq = str2num(handles.LowFreqTextBox.String);
new_watch.high_freq = str2num(handles.HighFreqTextBox.String);
new_watch.chans = str2num(handles.ChanTextBox.String);
new_watch.power = [];
new_watch.times = [];
new_watch.bandpower = [];
new_watch.percentiles = [];

%Build entry for watch list
labelvec = ["F","C","L","R","P"];
checkedvec = logical([handles.FrontalCheck.Value, handles.CentralCheck.Value, handles.LTempCheck.Value, handles.RTempCheck.Value, handles.PosteriorCheck.Value]);
labelstr = join(labelvec(checkedvec),', ');
if(ismissing(labelstr))
    if(length(new_watch.chans) >= 5)
        labelstr = [join(num2str(new_watch.chans(1:5))) '...'];       
    else
        labelstr = join(num2str(new_watch.chans(1:length(new_watch.chans))));
    end
end
new_watch_str = sprintf('%d-%d Hz; %s', new_watch.low_freq, new_watch.high_freq, labelstr);

%Create log file
currentTime = datevec(now);
[~,mffname,~] = fileparts(handles.FilepathTextBox.String);
mffname = strrep(mffname,'.mff','');
logname = sprintf('%s_%d-%d_PowerLog_%d-%d-%d_%d-%d-%d.txt', mffname, new_watch.low_freq, new_watch.high_freq, currentTime(1), currentTime(2), currentTime(3), currentTime(4), currentTime(5), round(currentTime(6)));
log = fopen(logname, 'wt');
fprintf(log, 'Average Power (%d-%d Hz; %s),Percentile,Load Time\n', new_watch.low_freq, new_watch.high_freq, labelstr);
fclose(log);

%Update fields
watchlist_contents = cellstr(handles.WatchListBox.String)';
new_contents = [watchlist_contents new_watch_str];
handles.WatchListBox.String = new_contents;
handles.watchlist = [handles.watchlist, new_watch];
handles.loglist = [handles.loglist, log];
guidata(hObject, handles);

% --- Executes on button press in RemWatchButton.
% Remove selected item from WatchListBox
function RemWatchButton_Callback(hObject, eventdata, handles)
% hObject    handle to RemWatchButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
idx = handles.WatchListBox.Value;
handles.WatchListBox.String(idx) = [];
handles.watchlist(idx) = [];
handles.loglist(idx) = [];
guidata(hObject, handles);


function handles = TabsFun(handles,TabFontSize,TabNames)

% Set the colors indicating a selected/unselected tab
handles.selectedTabColor=get(handles.tab1Panel,'BackgroundColor');
handles.unselectedTabColor=handles.selectedTabColor-0.1;

% Create Tabs
TabsNumber = length(TabNames);
handles.TabsNumber = TabsNumber;
TabColor = handles.selectedTabColor;
for i = 1:TabsNumber
    n = num2str(i);
    
    % Get text objects position
    set(handles.(['tab',n,'text']),'Units','normalized')
    pos=get(handles.(['tab',n,'text']),'Position');

    % Create axes with callback function
    handles.(['a',n]) = axes('Units','normalized',...
                    'Box','on',...
                    'XTick',[],...
                    'YTick',[],...
                    'Color',TabColor,...
                    'Position',[pos(1) pos(2) pos(3) pos(4)+0.01],...
                    'Tag',n,...
                    'ButtonDownFcn',[mfilename,'(''ClickOnTab'',gcbo,[],guidata(gcbo))']);
                    
    % Create text with callback function
    handles.(['t',n]) = text('String',TabNames{i},...
                    'Units','normalized',...
                    'Position',[pos(3),pos(2)/2+pos(4)],...
                    'HorizontalAlignment','left',...
                    'VerticalAlignment','middle',...
                    'Margin',0.001,...
                    'FontSize',TabFontSize,...
                    'Backgroundcolor',TabColor,...
                    'Tag',n,...
                    'ButtonDownFcn',[mfilename,'(''ClickOnTab'',gcbo,[],guidata(gcbo))']);

    TabColor = handles.unselectedTabColor;
end
            
% Manage panels (place them in the correct position and manage visibilities)
set(handles.tab1Panel,'Units','normalized')
pan1pos=get(handles.tab1Panel,'Position');
set(handles.tab1text,'Visible','off')
for i = 2:TabsNumber
    n = num2str(i);
    set(handles.(['tab',n,'Panel']),'Units','normalized')
    set(handles.(['tab',n,'Panel']),'Position',pan1pos)
    set(handles.(['tab',n,'Panel']),'Visible','off')
    set(handles.(['tab',n,'text']),'Visible','off')
end

% --- Callback function for clicking on tab
function ClickOnTab(hObject,~,handles)
m = str2double(get(hObject,'Tag'));

for i = 1:handles.TabsNumber;
    n = num2str(i);
    if i == m
        set(handles.(['a',n]),'Color',handles.selectedTabColor)
        set(handles.(['t',n]),'BackgroundColor',handles.selectedTabColor)
        set(handles.(['tab',n,'Panel']),'Visible','on')
    else
        set(handles.(['a',n]),'Color',handles.unselectedTabColor)
        set(handles.(['t',n]),'BackgroundColor',handles.unselectedTabColor)
        set(handles.(['tab',n,'Panel']),'Visible','off')
    end
end

% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
selection = questdlg('Exit Program?','','Yes','No','');
switch selection
    case 'Yes'
        for iLog = 1:length(handles.loglist)
            logname = fopen(handles.loglist(iLog));
            fclose(handles.loglist(iLog));
            try
                [~,msg] = movefile(logname,handles.OutpathTextBox.String);
            catch
                sprintf('Failed to move %s to output directory: %s', logname, msg)
            end
        end
        
        delete(hObject);
    case 'No'
        return
end
