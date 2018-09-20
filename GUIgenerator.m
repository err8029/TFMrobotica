classdef GUIgenerator < handle
    properties
        hfig=[];
        cfig=[];
        img1_handle=[];
        img2_handle=[];
        plan_handle=[];
        enable_bts=[];
        robots=[];
        texts=[];
        stop_bt=[];
        img_rate1=0;
        img_rate2=0;
        generated_map=[];
        map_window=[];
        manual_nav=Manual_nav();
        control_texts=[];
        error=0;
    end
    methods (Access = public)
        function GUI = GUIgenerator()
           %create robots object from class robots()
           if isempty(GUI.robots)
               GUI.robots=Robots();
           end
           %init necesary structs
           if isempty(GUI.enable_bts)
               GUI.enable_bts.enable1=true;
               GUI.enable_bts.enable2=true;
               GUI.enable_bts.enable_nav=true;
           end
           GUI.main_window();

        end
        function ctrl_window(GUI,~,~)
            GUI.cfig = figure;
            set(GUI.cfig,'numbertitle','off');               % erase figure number
            set(GUI.cfig,'name','Control panel');
            set(GUI.cfig,'MenuBar','none');                  % erase menu
            set(GUI.cfig,'doublebuffer','on');               % two graphic buffers
            set(GUI.cfig,'CloseRequestFcn',@GUI.close_control)          % close request function (close window)
            set(GUI.cfig,'tag','control');              % identify figure
            set(GUI.cfig,'Units','Normalized','Position',[0.1,0.1,0.4,0.5]);

            %--------------------------squares GUI-------------------------------
            GUI.draw_square(0.05,0.015,0.45,0.85,0.01);
            GUI.draw_square(0.5,0.015,0.45,0.85,0.01);
            GUI.draw_square(0.5,0.015,0.45,0.25,0.01);
            GUI.draw_square(0.5,0.255,0.45,0.19,0.01);
            
            uicontrol('Style', 'slider','Tag','sensitivity1',...
                'Min',0,'Max',1,'Value',GUI.robots.vel1,...
                'Units','Normalized','Position', [0.075 0.7 0.4 0.05],...
                'Callback', @GUI.adjust_vel1); 
            uicontrol('Style', 'slider','Tag','sensitivity1',...
                'Min',0,'Max',1,'Value',GUI.robots.w1,...
                'Units','Normalized','Position', [0.075 0.5 0.4 0.05],...
                'Callback', @GUI.adjust_w1); 
            uicontrol('Style', 'slider','Tag','sensitivity2',...
                'Min',0,'Max',1,'Value',GUI.robots.vel2,...
                'Units','Normalized','Position', [0.075 0.3 0.4 0.05],...
                'Callback', @GUI.adjust_vel2); 
            uicontrol('Style', 'slider','Tag','sensitivity1',...
                'Min',0,'Max',1,'Value',GUI.robots.w2,...
                'Units','Normalized','Position', [0.075 0.1 0.4 0.05],...
                'Callback', @GUI.adjust_w2); 

            %---------------------texts for box 1----------------------------------
            uicontrol('Style','text','Units','Normalized',...
                'Position',[0.05 0.9 0.9 0.07],'ForegroundColor',[1 1 1],'BackgroundColor',[0.7 0.7 0.7],...
                'String','Control Panel','FontSize',20);
            
            uicontrol('Style','text','Units','Normalized',...
                'Position',[0.09 0.44 0.05 0.05],...
                'String','0','FontSize',12);
            uicontrol('Style','text','Units','Normalized',...
                'Position',[0.39 0.44 0.1 0.05],...
                'String','1','FontSize',12);
            uicontrol('Style','text','Units','Normalized',...
                'Position',[0.075 0.57 0.4 0.05],...
                'String','Angular velocity robot 1','FontSize',15); 
            GUI.texts.w1_text = uicontrol('Style','text','Units','Normalized',...
                'Position',[0.175 0.44 0.2 0.05],...
                'String',GUI.robots.w1,'FontSize',12);

            uicontrol('Style','text','Units','Normalized',...
                'Position',[0.09 0.64 0.05 0.05],...
                'String','0','FontSize',12);
            uicontrol('Style','text','Units','Normalized',...
                'Position',[0.39 0.64 0.1 0.05],...
                'String','1','FontSize',12);
            uicontrol('Style','text','Units','Normalized',...
                'Position',[0.075 0.77 0.4 0.05],...
                'String','Linear velocity robot 1','FontSize',15); 
            GUI.texts.vel1_text = uicontrol('Style','text','Units','Normalized',...
                'Position',[0.175 0.64 0.2 0.05],...
                'String',GUI.robots.vel1,'FontSize',12);

            %labels for the robot 2 sliders
            uicontrol('Style','text','Units','Normalized',...
                'Position',[0.09 0.24 0.05 0.05],...
                'String','0','FontSize',12);
            uicontrol('Style','text','Units','Normalized',...
                'Position',[0.39 0.24 0.1 0.05],...
                'String','1','FontSize',12);
            uicontrol('Style','text','Units','Normalized',...
                'Position',[0.075 0.37 0.4 0.05],...
                'String','Linear velocity robot 2','FontSize',15);
            GUI.texts.vel2_text = uicontrol('Style','text','Units','Normalized',...
                'Position',[0.175 0.24 0.2 0.05],...
                'String',GUI.robots.vel2,'FontSize',12);

            uicontrol('Style','text','Units','Normalized',...
                'Position',[0.09 0.04 0.05 0.05],...
                'String','0','FontSize',12);
            uicontrol('Style','text','Units','Normalized',...
                'Position',[0.39 0.04 0.1 0.05],...
                'String','1','FontSize',12);
            uicontrol('Style','text','Units','Normalized',...
                'Position',[0.075 0.17 0.4 0.05],...
                'String','Angular velocity robot 2','FontSize',15);
            GUI.texts.w2_text = uicontrol('Style','text','Units','Normalized',...
                'Position',[0.175 0.04 0.2 0.05],...
                'String',GUI.robots.w2,'FontSize',12);
            %------------------------texts for box 2------------------------------
            uicontrol('Style','text','Units','Normalized',...
            'Position',[0.55 0.775 0.35 0.05],...
            'String','enable camera for robot 1','FontSize',15);
            uicontrol('Style','text','Units','Normalized',...
            'Position',[0.55 0.65 0.35 0.05],...
            'String','enable camera for robot 2','FontSize',15);
            uicontrol('Style','text','Units','Normalized',...
            'Position',[0.55 0.525 0.35 0.05],...
            'String','Enable mapping methods','FontSize',15);
            uicontrol('Style','text','Units','Normalized',...
            'Position',[0.58 0.375 0.3 0.05],...
            'String','Mapping frequency','FontSize',15);
            %---------------------------checkboxes---------------------------------
             uicontrol('Style','checkbox','Units','Normalized','Value',GUI.enable_bts.enable1,...
            'Position',[0.575 0.725 0.35 0.05],'Callback',@GUI.enable,...
            'String','enable camera 1','FontSize',12,'Tag','enable1');
            uicontrol('Style','checkbox','Units','Normalized','Value',GUI.enable_bts.enable2,...
            'Position',[0.575 0.6 0.35 0.05],'Callback',@GUI.enable,...
            'String','enable camera 2','FontSize',12,'Tag','enable2');   
            uicontrol('Style','checkbox','Units','Normalized','Value',GUI.enable_bts.enable_nav,...
            'Position',[0.575 0.475 0.35 0.05],'Callback',@GUI.enable,...
            'String','enable mapping (experimental)','FontSize',12,'Tag','enable_nav'); 
            %------------------------edit for freq-------------------------------
            uicontrol('Style','edit','Units','Normalized','Value',GUI.robots.freq,'String',num2str(GUI.robots.freq),...
                'Position',[0.67 0.31 0.1 0.05],...
                'FontSize',12,'Callback',@GUI.adjust_freq);
            %-------------------------slider lookahead----------------------------
            uicontrol('Style','text','Units','Normalized',...
                'Position',[0.55 0.04 0.05 0.05],...
                'String','0','FontSize',12);
            uicontrol('Style','text','Units','Normalized',...
                'Position',[0.825 0.04 0.1 0.05],...
                'String','2','FontSize',12);
            uicontrol('Style','text','Units','Normalized',...
                'Position',[0.575 0.17 0.3 0.05],...
                'String','lookahead distance','FontSize',15);
            GUI.texts.l_text = uicontrol('Style','text','Units','Normalized',...
                'Position',[0.66 0.04 0.1 0.05],...
                'String',GUI.robots.lookahead,'FontSize',12);
            uicontrol('Style', 'slider','Tag','lookahead',...
                'Min',0,'Max',2,'Value',GUI.robots.lookahead,...
                'Units','Normalized','Position', [0.55 0.1 0.35 0.05],...
                'Callback', @GUI.adjust_l); 
        end
        function main_window(GUI,~,~)
            GUI.hfig = figure;
            set(GUI.hfig,'numbertitle','off');               % erase figure number
            set(GUI.hfig,'name','Multi robot controller');
            set(GUI.hfig,'MenuBar','none');                  % erase menu
            set(GUI.hfig,'doublebuffer','on');               % two graphic buffers
            set(GUI.hfig,'CloseRequestFcn',@GUI.close)          % close request function (close window)
            set(GUI.hfig,'tag','MOSTRARDADES');              % identify figure
            set(GUI.hfig,'Units','Normalized','Position',[0.1,0.1,0.75,0.75]);
            %------------------------------menu-----------------------------------
            hmenu = uimenu('Label','&Options','Tag','M');       
            uimenu(hmenu,'Label','&exit','Callback',@close,'separator','on','Accelerator','E');
            uimenu(hmenu,'Label','&control panel','Callback',@GUI.ctrl_window,'separator','on','Accelerator','C');
            %---------------------axes----------------
            GUI.img1_handle=axes('Units','Normalized','Position',[0 0.5 0.3 0.3]);
            GUI.img2_handle=axes('Units','Normalized','Position',[0.7 0.5 0.3 0.3]);
            GUI.plan_handle=axes('Units','Normalized','Position',[0.355 0.3 0.3 0.5]);
            %------------------create texts and rectangles------------------------
            %rectangles for robot 1
            GUI.draw_square(0,0.41,0.3,0.49,0.01)
            GUI.draw_square(0,0,0.3,0.43,0.01)
            %rectangles for robot 2
            GUI.draw_square(0.7,0.41,0.3,0.49,0.01)
            GUI.draw_square(0.7,0,0.3,0.43,0.01)
            %square for robot planner
            GUI.draw_square(0.325,0.2,0.35,0.7,0.01);
            %text for robot1
            uicontrol('Style', 'text','String','Robot 1',...
            'Units','Normalized','Position', [0 0.9 0.3 0.07],...
            'BackgroundColor',[0.5 0.5 0.5],'FontSize',20,'ForegroundColor',[1 1 1]);  
            %text for robot2
            uicontrol('Style', 'text','String','Robot 2',...
            'Units','Normalized','Position', [0.7 0.9 0.3 0.07],...
            'BackgroundColor',[0.5 0.5 0.5],'FontSize',20,'ForegroundColor',[1 1 1]); 
            %text for planning
            uicontrol('Style', 'text','String','Planner',...
            'Units','Normalized','Position', [0.325 0.9 0.35 0.07],...
            'BackgroundColor',[0.5 0.5 0.5],'FontSize',20,'ForegroundColor',[1 1 1]); 
            %--------------------arrow buttons robots-----------------------------
            [up,down,left,right]=GUI.read_arrows();
            GUI.arrow_draw(up,down,left,right)
    
            [position1,orientation1]=GUI.robots.odom_obtention(1);    
            text=sprintf('%s\n%s\n%s\n%s','Position',['X: ' num2str(position1(1)) ' m'],['Y: ' num2str(position1(2)) ' m'],['Z: ' num2str(position1(3)) ' m']);
            GUI.texts.position1=uicontrol('Style', 'text','String',text,'Tag','Positon1',...
            'Units','Normalized','Position', [0.18 0.02 0.11 0.1],'HorizontalAlignment','Left',...
            'BackgroundColor',[0.5 0.5 0.5],'FontSize',13,'ForegroundColor',[1 1 1]); 
            text=sprintf('%s\n%s\n%s\n%s','Orientation',['X: ' num2str(orientation1(1)) ' deg'],['Y: ' num2str(orientation1(2)) ' deg'],['Z: ' num2str(orientation1(3)) ' deg']);
            GUI.texts.orientation1=uicontrol('Style', 'text','String',text,'Tag','Orientation1',...
            'Units','Normalized','Position', [0.01 0.02 0.11 0.1],'HorizontalAlignment','Left',...
            'BackgroundColor',[0.5 0.5 0.5],'FontSize',13,'ForegroundColor',[1 1 1]); 

            [position2,orientation2]=GUI.robots.odom_obtention(2);
            text2=sprintf('%s\n%s\n%s\n%s','Position',['X: ' num2str(position2(1)) ' m'],['Y: ' num2str(position2(2)) ' m'],['Z: ' num2str(position2(3)) ' m']);
            GUI.texts.position2=uicontrol('Style', 'text','String',text2,...
            'Units','Normalized','Position', [0.88 0.02 0.11 0.1],'HorizontalAlignment','Left',...
            'BackgroundColor',[0.5 0.5 0.5],'FontSize',13,'ForegroundColor',[1 1 1]); 
            text2=sprintf('%s\n%s\n%s\n%s','Orientation',['X: ' num2str(orientation2(1)) ' deg'],['Y: ' num2str(orientation2(2)) ' deg'],['Z: ' num2str(orientation2(3)) ' deg']);
            GUI.texts.orientation2=uicontrol('Style', 'text','String',text2,...
            'Units','Normalized','Position', [0.71 0.02 0.11 0.1],'HorizontalAlignment','Left',...
            'BackgroundColor',[0.5 0.5 0.5],'FontSize',13,'ForegroundColor',[1 1 1]); 
        
            %----------------create rectangles for speeds-------------------------
            text=sprintf('%s\n%s\n%s','Velocity',['Linear: ' num2str(GUI.robots.vel1) ' m/s'],['Angular: ' num2str(GUI.robots.w1) ' rad/s']);
            GUI.texts.vel1=uicontrol('Style', 'text','String',text,...
            'Units','Normalized','Position', [0.01 0.905 0.1 0.06],'HorizontalAlignment','Left',...
            'BackgroundColor',[0.5 0.5 0.5],'FontSize',10,'ForegroundColor',[1 1 1]); 

            text=sprintf('%s\n%s\n%s','Velocity',['Linear: ' num2str(GUI.robots.vel2) ' m/s'],['Angular: ' num2str(GUI.robots.w2) ' rad/s']);
            GUI.texts.vel2=uicontrol('Style', 'text','String',text,...
            'Units','Normalized','Position', [0.71 0.905 0.1 0.06],'HorizontalAlignment','Left',...
            'BackgroundColor',[0.5 0.5 0.5],'FontSize',10,'ForegroundColor',[1 1 1]); 
            %-------------------display initial images----------------------------
            GUI.robots.display_image(GUI.enable_bts.enable1,GUI.img1_handle,1)
            GUI.robots.display_image(GUI.enable_bts.enable2,GUI.img2_handle,2)
            %---------------------stop navigation bt------------------------------
            GUI.stop_bt = uicontrol('Style', 'pushbutton','String','Stop navigation',...
            'Units','Normalized','Position', [0.4 0.1 0.2 0.05],...
            'Callback', @GUI.stop,'Tag','stop','Interruptible','Off','UserData',0);  
            %---------------------start navigation bt------------------------------
            uicontrol('Style', 'pushbutton','String','Start planning',...
            'Units','Normalized','Position', [0.4 0.05 0.2 0.05],...
            'Callback', @GUI.start,'Tag','start'); 
        end
        function [position,orientation]=odom_update(GUI,rob_num)
            %update odometry for any previous inertia
            if rob_num==1
                [position,orientation]=GUI.robots.odom_obtention(rob_num);
                text=sprintf('%s\n%s\n%s\n%s','Position',['X: ' num2str(position(1)) ' m'],['Y: ' num2str(position(2)) ' m'],['Z: ' num2str(position(3)) ' m']);
                set(GUI.texts.position1,'String',text);
                text=sprintf('%s\n%s\n%s\n%s','Orientation',['X: ' num2str((180/pi)*orientation(1)) ' deg'],['Y: ' num2str(orientation(2)) ' deg'],['Z: ' num2str(orientation(3)) ' deg']);
                set(GUI.texts.orientation1,'String',text);
            else
                [position,orientation]=GUI.robots.odom_obtention(rob_num);
                text=sprintf('%s\n%s\n%s\n%s','Position',['X: ' num2str(position(1)) ' m'],['Y: ' num2str(position(2)) ' m'],['Z: ' num2str(position(3)) ' m']);
                set(GUI.texts.position2,'String',text);
                text=sprintf('%s\n%s\n%s\n%s','Orientation',['X: ' num2str((180/pi)*orientation(1)) ' deg'],['Y: ' num2str(orientation(2)) ' deg'],['Z: ' num2str(orientation(3)) ' deg']);
                set(GUI.texts.orientation2,'String',text);            
            end
        end
        function speed_update(GUI,rob_num)
            if rob_num==1
                text=sprintf('%s\n%s\n%s','Velocity',['Linear: ' num2str(GUI.robots.vel1) ' m/s'],['Angular: ' num2str(GUI.robots.w1) ' rad/s']);
                GUI.texts.vel1.String=text;
            else
                text=sprintf('%s\n%s\n%s','Velocity',['Linear: ' num2str(GUI.robots.vel2) ' m/s'],['Angular: ' num2str(GUI.robots.w2) ' rad/s']);
                GUI.texts.vel2.String=text;
            end
        end
        function draw_square(~,x,y,h,v,w)
        %square drawing funcrion where
        %   (x,y): left down x coordenates for the square
        %   h: horizontal segment
        %   v: vertical segment
        %   w: width

            uicontrol('Style', 'text',...
            'Units','Normalized','Position', [x y w v],...
            'BackgroundColor',[0.7 0.7 0.7]); 
            uicontrol('Style', 'text',...
            'Units','Normalized','Position', [x+h-w y w v],...
            'BackgroundColor',[0.7 0.7 0.7]); 
            uicontrol('Style', 'text',...
            'Units','Normalized','Position', [x y h w*2],...
            'BackgroundColor',[0.7 0.7 0.7]); 
            uicontrol('Style', 'text',...
            'Units','Normalized','Position', [x y+v-w h w*2],...
            'BackgroundColor',[0.7 0.7 0.7]); 
        end
        function close(GUI,~,~)
            delete(GUI.hfig);
        end
        function close_control(GUI,~,~)
            delete(GUI.cfig);
        end
        function start(GUI,~,~)
             axes(GUI.plan_handle)
             cla(GUI.plan_handle)
             grid on;
             grid minor;
             hold on;
             %read the csv, plot it and obtain the paths and execute navigation
             map=csvread('map/map4.csv');
             map_and_nav(map,GUI);
        end
        function stop(GUI,~,~)
            if GUI.error==1
                GUI.error=0;
            else
                GUI.error=1;
            end
        end
        function arrow_draw(GUI,up,down,left,right)
            %arrows for robot1
            uicontrol('Style', 'pushbutton','cdata',up,...
            'Units','Normalized','Position', [0.125 0.3 0.05 0.1],...
            'Callback', @GUI.catch_key,'Tag','up');  
            uicontrol('Style', 'pushbutton','cdata',down,...
            'Units','Normalized','Position', [0.125 0.05 0.05 0.1],...
            'Callback', @GUI.catch_key,'Tag','down');
            uicontrol('Style', 'pushbutton','cdata',left,...
            'Units','Normalized','Position', [0.05 0.18 0.05 0.1],...
            'Callback', @GUI.catch_key,'Tag','left');  
            uicontrol('Style', 'pushbutton','cdata',right,...
            'Units','Normalized','Position', [0.2 0.18 0.05 0.1],...
            'Callback', @GUI.catch_key,'Tag','right');

            %arrows for robot2
            uicontrol('Style', 'pushbutton','cdata',up,...
            'Units','Normalized','Position', [0.825 0.3 0.05 0.1],...
            'Callback', @GUI.catch_key2,'Tag','up2');  
            uicontrol('Style', 'pushbutton','cdata',down,...
            'Units','Normalized','Position', [0.825 0.05 0.05 0.1],...
            'Callback', @GUI.catch_key2,'Tag','down2');
            uicontrol('Style', 'pushbutton','cdata',left,...
            'Units','Normalized','Position', [0.75 0.18 0.05 0.1],...
            'Callback', @GUI.catch_key2,'Tag','left2');  
            uicontrol('Style', 'pushbutton','cdata',right,...
            'Units','Normalized','Position', [0.9 0.18 0.05 0.1],...
            'Callback', @GUI.catch_key2,'Tag','right2');
        end
        function [up,down,left,right]=read_arrows(~,~,~)
            up=imread('img/up.jpg');
            down=imread('img/down.jpg');
            left=imread('img/left.jpg');
            right=imread('img/right.jpg');
        end
        function catch_key(GUI,obj,event)
            %Obtain the tag for the pressed button or the key from keyboard
            if strcmp(event.EventName,'KeyPress')
                key=event.Key;
                ID=1;
            else
                ID=obj.Tag;
                key=1;
            end
            %check which button has been pressed and command speed
            GUI.manual_nav.key_velCommand(GUI,ID,key)
            GUI.hfig.CurrentCharacter=' ';
            %listen to the other robot
            set(GUI.hfig,'KeyPressFcn',@GUI.catch_key2);   
        end
        function catch_key2(GUI,obj,event)
            %Obtain the tag for the pressed button or the key from keyboard
            if strcmp(event.EventName,'KeyPress')
                key=event.Key;
                ID=1;
            else
                ID=obj.Tag;
                key=1;
            end
            %check which button has been pressed and command speed
            GUI.manual_nav.key_velCommand2(GUI,ID,key)
            GUI.hfig.CurrentCharacter=' ';
            %listen to the other robot
            set(GUI.hfig,'KeyPressFcn',@GUI.catch_key);   
        end
        function adjust_freq(GUI,obj,~)
            GUI.robots.freq=obj.Value;
        end
        function adjust_l(GUI,obj,~)
            GUI.texts.l_text.String=num2str(w2);
            GUI.robots.lookahead=obj.Value;
        end
        function adjust_vel1(GUI,obj,~)
            GUI.robots.vel1=obj.Value;
            GUI.texts.vel1_text.String=num2str(GUI.robots.vel1);
            %speed update
            GUI.speed_update(1)
        end
        function adjust_vel2(GUI,obj,~)
            GUI.robots.vel2=obj.Value;
            GUI.texts.vel2_text.String=num2str(GUI.robots.vel2);   
            %speed update
            GUI.speed_update(2)
        end
        function adjust_w1(GUI,obj,~)
            GUI.robots.w1=obj.Value;
            GUI.texts.w1_text.String=num2str(GUI.robots.w1);
            %speed update
            GUI.speed_update(1)
        end
        function adjust_w2(GUI,obj,~)
            GUI.robots.w2=obj.Value;
            GUI.texts.w2_text.String=num2str(GUI.robots.w2);   
            %speed update
            GUI.speed_update(2)
        end
        function enable(GUI,obj,~)
            if strcmp(obj.Tag,'enable1') && obj.Value==1
                GUI.enable_bts.enable1=true;
                set(GUI.img1_handle,'visible', 'on');
            elseif strcmp(obj.Tag,'enable1') && obj.Value==0
                GUI.enable_bts.enable1=false;
                set(GUI.img1_handle,'visible', 'off');
            elseif strcmp(obj.Tag,'enable2') && obj.Value==1
                set(GUI.img1_handle,'visible', 'on');
                GUI.enable_bts.enable2=true;
            elseif strcmp(obj.Tag,'enable2') && obj.Value==0
                GUI.enable_bts.enable2=false;
                set(GUI.img2_handle,'visible', 'off');
                
            elseif strcmp(obj.Tag,'enable_nav') && obj.Value==1
                GUI.enable_bts.enable_nav=true;
            elseif strcmp(obj.Tag,'enable_nav') && obj.Value==0
                GUI.enable_bts.enable_nav=false;
            else
                disp('error, something with checkboxes went wrong');
            end
        end
        function msg(~,~,~)
            title='warning';
            message=({'process stopped'});
            myicon=imread('img/warning.png');
            myicon=imresize(myicon, [64, 64]);
            msgbox(message,title,'custom',myicon)
        end
    end
end
