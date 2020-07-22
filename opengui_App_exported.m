classdef opengui_App_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        figure1           matlab.ui.Figure
        plotx             matlab.ui.control.UIAxes
        plotabsx          matlab.ui.control.UIAxes
        pushbutton1       matlab.ui.control.Button
        path              matlab.ui.control.EditField
        FF                matlab.ui.control.EditField
        NSym              matlab.ui.control.EditField
        Replay            matlab.ui.control.Button
        text3             matlab.ui.control.Label
        text4             matlab.ui.control.Label
        ByEditFieldLabel  matlab.ui.control.Label
        ByEditField       matlab.ui.control.EditField
    end

    
    methods (Access = private)
        function content_CreateFcn(app, hObject, eventdata, handles)
            % hObject    handle to content (see GCBO)
            % eventdata  reserved - to be defined in a future version of MATLAB
            % handles    empty - handles not created until after all CreateFcns called
            
            % Hint: edit controls usually have a white background on Windows.
            %       See ISPC and COMPUTER.
            if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
                set(hObject,'BackgroundColor','white');
            end
        end
        
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function opengui_OpeningFcn(app, varargin)
            % Create GUIDE-style callback args - Added by Migration Tool
            [hObject, eventdata, handles] = convertToGUIDECallbackArguments(app); %#ok<ASGLU>
            
            % This function has no output args, see OutputFcn.
            % hObject    handle to figure
            % eventdata  reserved - to be defined in a future version of MATLAB
            % handles    structure with handles and user data (see GUIDATA)
            % varargin   command line arguments to opengui (see VARARGIN)
            
            % Choose default command line output for opengui
            handles.output = hObject;
            
            % Update handles structure
            guidata(hObject, handles);
        end

        % Button pushed function: Replay
        function Replay_Callback(app, event)
            % Create GUIDE-style callback args - Added by Migration Tool
            [hObject, eventdata, handles] = convertToGUIDECallbackArguments(app, event); %#ok<ASGLU>
            
            cplpath=get(handles.path,'string');
            [x,fs]=audioread(cplpath);
            sound(x,fs);
        end

        % Button pushed function: pushbutton1
        function pushbutton1_Callback(app, event)
            % Create GUIDE-style callback args - Added by Migration Tool
            [hObject, eventdata, handles] = convertToGUIDECallbackArguments(app, event); %#ok<ASGLU>
            
            
            [name,path]=uigetfile('.wav','' ,'select your file'); % get the filename and file's path
            cplpath=strcat(path, name); %rearrange for a complete path
            
            [x,fs] = audioread(cplpath); %read the audio file
            [freq, sym] = findtheff(x,fs);%perform fft to get the ff and note symbol
            % also plot the second axes
            FF = [num2str(floor(freq)) ,' Hz'];
            sound(x,fs);
            
            %create string of result
            set(handles.path, 'string', cplpath);%display the path in the path box
            set(handles.FF, 'string', FF);%display the estimated Freq in the FF box
            set(handles.NSym, 'string', sym); %display the note symbol in the NSym box
            
            plot(handles.plotx,x);
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create figure1 and hide until all components are created
            app.figure1 = uifigure('Visible', 'off');
            app.figure1.Color = [1 1 1];
            app.figure1.Position = [952 272 1263 548];
            app.figure1.Name = 'opengui';
            app.figure1.Resize = 'off';
            app.figure1.HandleVisibility = 'callback';
            app.figure1.Tag = 'figure1';

            % Create plotx
            app.plotx = uiaxes(app.figure1);
            app.plotx.AmbientLightColor = [0 0 0];
            app.plotx.FontSize = 14;
            app.plotx.NextPlot = 'replace';
            app.plotx.BackgroundColor = [1 1 1];
            app.plotx.Tag = 'plotx';
            app.plotx.Position = [28 154 495 278];

            % Create plotabsx
            app.plotabsx = uiaxes(app.figure1);
            app.plotabsx.FontSize = 14;
            app.plotabsx.NextPlot = 'replace';
            app.plotabsx.BackgroundColor = [1 1 1];
            app.plotabsx.Tag = 'plotabsx';
            app.plotabsx.Position = [532 154 491 278];

            % Create pushbutton1
            app.pushbutton1 = uibutton(app.figure1, 'push');
            app.pushbutton1.ButtonPushedFcn = createCallbackFcn(app, @pushbutton1_Callback, true);
            app.pushbutton1.Tag = 'pushbutton1';
            app.pushbutton1.BackgroundColor = [1 0.968627450980392 0.92156862745098];
            app.pushbutton1.FontSize = 17;
            app.pushbutton1.Position = [70 77 174 39];
            app.pushbutton1.Text = 'Browse';

            % Create path
            app.path = uieditfield(app.figure1, 'text');
            app.path.Tag = 'path';
            app.path.HorizontalAlignment = 'center';
            app.path.FontSize = 17;
            app.path.BackgroundColor = [1 0.949019607843137 0.866666666666667];
            app.path.Position = [256 76 774 41];
            app.path.Value = 'Path to your file will be displayed here';

            % Create FF
            app.FF = uieditfield(app.figure1, 'text');
            app.FF.Tag = 'FF';
            app.FF.HorizontalAlignment = 'center';
            app.FF.FontSize = 21;
            app.FF.FontColor = [0.247058823529412 0.247058823529412 0.247058823529412];
            app.FF.Position = [1050 301 181 34];
            app.FF.Value = 'Funda. Freq';

            % Create NSym
            app.NSym = uieditfield(app.figure1, 'text');
            app.NSym.Tag = 'NSym';
            app.NSym.HorizontalAlignment = 'center';
            app.NSym.FontSize = 21;
            app.NSym.FontColor = [0.32156862745098 0.188235294117647 0.188235294117647];
            app.NSym.BackgroundColor = [0.972549019607843 0.972549019607843 0.972549019607843];
            app.NSym.Position = [1050 240 181 43];
            app.NSym.Value = 'Note symbol';

            % Create Replay
            app.Replay = uibutton(app.figure1, 'push');
            app.Replay.ButtonPushedFcn = createCallbackFcn(app, @Replay_Callback, true);
            app.Replay.Tag = 'Replay';
            app.Replay.BackgroundColor = [0.972549019607843 0.972549019607843 0.972549019607843];
            app.Replay.FontSize = 21;
            app.Replay.FontColor = [0.870588235294118 0.490196078431373 0];
            app.Replay.Position = [1050 178 181 41];
            app.Replay.Text = 'Replay';

            % Create text3
            app.text3 = uilabel(app.figure1);
            app.text3.Tag = 'text3';
            app.text3.BackgroundColor = [0.992156862745098 0.917647058823529 0.796078431372549];
            app.text3.HorizontalAlignment = 'center';
            app.text3.VerticalAlignment = 'top';
            app.text3.FontSize = 28;
            app.text3.FontColor = [0.6 0.2 0];
            app.text3.Position = [70 486 911 44];
            app.text3.Text = 'Musical notes detection';

            % Create text4
            app.text4 = uilabel(app.figure1);
            app.text4.Tag = 'text4';
            app.text4.BackgroundColor = [0.952941176470588 0.870588235294118 0.733333333333333];
            app.text4.HorizontalAlignment = 'center';
            app.text4.VerticalAlignment = 'top';
            app.text4.FontSize = 17;
            app.text4.FontColor = [0.4 0 0];
            app.text4.Position = [140 447 771 27];
            app.text4.Text = 'Group no:  GA305 ';

            % Create ByEditFieldLabel
            app.ByEditFieldLabel = uilabel(app.figure1);
            app.ByEditFieldLabel.HorizontalAlignment = 'right';
            app.ByEditFieldLabel.Position = [87 28 25 22];
            app.ByEditFieldLabel.Text = 'By';

            % Create ByEditField
            app.ByEditField = uieditfield(app.figure1, 'text');
            app.ByEditField.Position = [127 28 305 22];
            app.ByEditField.Value = 'Jay Patil, Kunal Kale, Jatin Lanje, Kimaya Kulkarni';

            % Show the figure after all components are created
            app.figure1.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = opengui_App_exported(varargin)

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.figure1)

            % Execute the startup function
            runStartupFcn(app, @(app)opengui_OpeningFcn(app, varargin{:}))

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.figure1)
        end
    end
end