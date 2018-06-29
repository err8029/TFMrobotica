classdef GUI < handle

    
    properties
        FigureHandle = [];      % Handle to the object figure
        AxesHandle1 = [];        % Handle to the object axes
        AxesHandle2 = [];
        Goal = [];              % Matrix of goal points
        PoseHandle = [];        % Handle to the current pose object
        ArrowHandle = [];       % Handle to current direction object
        PoseHistory = [];       % History of all currently plotted robot poses
        DataHistory = [];       % History of all currently plotted laser scans
    end
    
    properties (Constant, Access = private)
        %MaxPoseHistorySize The maximum number of poses that should be stored in PoseHistory
        %   PoseHistory is a FIFO and if it reaches MaxPoseHistorySize, the
        %   oldest element will be deleted.
        MaxPoseHistorySize = 50    
        
        %MaxDataHistorySize The maximum number of laser readings that should be stored in DataHistory
        %   DataHistory is a FIFO and if it reaches MaxDataHistorySize, the
        %   oldest element will be deleted.
        MaxDataHistorySize = 50   
    end
    
    methods (Access = public)
        function obj = GUI(img_rob1,img_rob2)
            %ExampleHelperTurtleBotVisualizer - Constructor sets all the figure properties
            obj.FigureHandle = figure('Name','Robot Position','CloseRequestFcn',@obj.closeFigure);
            set(obj.FigureHandle,'numbertitle','off');               % erase figure number
            set(obj.FigureHandle,'MenuBar','none');                  % erase menu
            set(obj.FigureHandle,'doublebuffer','on');               % two graphic buffers
            set(obj.FigureHandle,'tag','MOSTRARDADES');              % identify figure
            set(obj.FigureHandle,'Units','Normalized','Position',[0.1,0.1,0.75,0.75]);
            
            show_images(img_rob1,img_rob2,obj)
        end
    end
    
    methods (Access = protected)
        
        function closeFigure(obj,~,~)
            %CLOSEFIGURE - Callback function that deletes the figure
            % handle
            
            delete(obj.FigureHandle);
        end
        function show_images(img_rob1,img_rob2,obj)
             obj.AxesHandle1 = axes('Parent',obj.FigureHandle,'XGrid','on','YGrid','on','XLimMode','manual','YLimMode','manual');
             hold(obj.AxesHandle1,'on'); 
             imshow(img_rob1);
             hold(obj.AxesHandle1,'off'); 
             
             obj.AxesHandle2 = axes('Parent',obj.FigureHandle,'XGrid','on','YGrid','on','XLimMode','manual','YLimMode','manual');
             hold(obj.AxesHandle2,'on'); 
             imshow(img_rob2);
             hold(obj.AxesHandle2,'off'); 
        end
    end
    
end

