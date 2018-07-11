function createfig()
    global hfig
	hfig = figure;
	set(hfig,'numbertitle','off');               % erase figure number
	set(hfig,'name','Multi robot controller');
	set(hfig,'MenuBar','none');                  % erase menu
	set(hfig,'doublebuffer','on');               % two graphic buffers
	set(hfig,'CloseRequestFcn',@close)          % close request function (close window)
	set(hfig,'tag','MOSTRARDADES');              % identify figure
    set(hfig,'Units','Normalized','Position',[0.1,0.1,0.75,0.75]);
    %------------------------------menu-----------------------------------
    hmenu = uimenu('Label','&Options','Tag','M');       
		uimenu(hmenu,'Label','&exit','Callback',@close,'separator','on','Accelerator','E');
        uimenu(hmenu,'Label','&control panel','Callback',@create_control,'separator','on','Accelerator','C');
    
    %------------------create texts and rectangles------------------------
    %rectangles for robot 1
    draw_square(0,0.41,0.3,0.49,0.01)
    draw_square(0,0,0.3,0.43,0.01)
    %rectangles for robot 2
    draw_square(0.7,0.41,0.3,0.49,0.01)
    draw_square(0.7,0,0.3,0.43,0.01)
    %square for robot planner
    draw_square(0.325,0.2,0.35,0.7,0.01);
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

    %-------------------create axes for images----------------------------
    global img1_handle
    global img2_handle
    global plan_handle
    img1_handle=axes('Units','Normalized','Position',[0 0.5 0.3 0.3]);
    img2_handle=axes('Units','Normalized','Position',[0.7 0.5 0.3 0.3]);
    plan_handle=axes('Units','Normalized','Position',[0.355 0.3 0.3 0.5]);
    [up,down,left,right]=read_arrows();
    
    %--------------------arrow buttons robots-----------------------------
    arrow_draw(up,down,left,right)
    %----------------create rectangles for odom---------------------------
    global position1_text
    global position2_text
    global position1
    global position2
    global orientation1
    global orientation2
    global orientation1_text
    global orientation2_text
    global stop_bt
    
    odom_obtention();    
    text=sprintf('%s\n%s\n%s\n%s','Position',['X: ' num2str(position1(1)) ' m'],['Y: ' num2str(position1(2)) ' m'],['Z: ' num2str(position1(3)) ' m']);
    position1_text=uicontrol('Style', 'text','String',text,'Tag','Positon1',...
    'Units','Normalized','Position', [0.18 0.02 0.11 0.1],'HorizontalAlignment','Left',...
    'BackgroundColor',[0.5 0.5 0.5],'FontSize',13,'ForegroundColor',[1 1 1]); 
    text=sprintf('%s\n%s\n%s\n%s','Orientation',['X: ' num2str(orientation1(1)) ' deg'],['Y: ' num2str(orientation1(2)) ' deg'],['Z: ' num2str(orientation1(3)) ' deg']);
    orientation1_text=uicontrol('Style', 'text','String',text,'Tag','Orientation1',...
    'Units','Normalized','Position', [0.01 0.02 0.11 0.1],'HorizontalAlignment','Left',...
    'BackgroundColor',[0.5 0.5 0.5],'FontSize',13,'ForegroundColor',[1 1 1]); 

    odom_obtention2();
    text2=sprintf('%s\n%s\n%s\n%s','Position',['X: ' num2str(position2(1)) ' m'],['Y: ' num2str(position2(2)) ' m'],['Z: ' num2str(position2(3)) ' m']);
    position2_text=uicontrol('Style', 'text','String',text2,...
    'Units','Normalized','Position', [0.88 0.02 0.11 0.1],'HorizontalAlignment','Left',...
    'BackgroundColor',[0.5 0.5 0.5],'FontSize',13,'ForegroundColor',[1 1 1]); 
    text2=sprintf('%s\n%s\n%s\n%s','Orientation',['X: ' num2str(orientation2(1)) ' deg'],['Y: ' num2str(orientation2(2)) ' deg'],['Z: ' num2str(orientation2(3)) ' deg']);
    orientation2_text=uicontrol('Style', 'text','String',text2,...
    'Units','Normalized','Position', [0.71 0.02 0.11 0.1],'HorizontalAlignment','Left',...
    'BackgroundColor',[0.5 0.5 0.5],'FontSize',13,'ForegroundColor',[1 1 1]); 
    %----------------create rectangles for speeds-------------------------
    global vel1_rect_main
    global vel2_rect_main
    global vel1
    global w1
    global vel2
    global w2
    
    text=sprintf('%s\n%s\n%s','Velocity',['Linear: ' num2str(vel1) ' m/s'],['Angular: ' num2str(w1) ' rad/s']);
    vel1_rect_main=uicontrol('Style', 'text','String',text,...
    'Units','Normalized','Position', [0.01 0.905 0.1 0.06],'HorizontalAlignment','Left',...
    'BackgroundColor',[0.5 0.5 0.5],'FontSize',10,'ForegroundColor',[1 1 1]); 

    text=sprintf('%s\n%s\n%s','Velocity',['Linear: ' num2str(vel2) ' m/s'],['Angular: ' num2str(w2) ' rad/s']);
    vel2_rect_main=uicontrol('Style', 'text','String',text,...
    'Units','Normalized','Position', [0.71 0.905 0.1 0.06],'HorizontalAlignment','Left',...
    'BackgroundColor',[0.5 0.5 0.5],'FontSize',10,'ForegroundColor',[1 1 1]); 
    
    %-------------------display initial images----------------------------
    display_image()
    display_image2()
    
    %---------------------stop navigation bt------------------------------
    stop_bt = uicontrol('Style', 'pushbutton','String','Stop navigation',...
    'Units','Normalized','Position', [0.4 0.1 0.2 0.05],...
    'Callback', @stop,'Tag','stop','Interruptible','Off','UserData',0);  
    %---------------------stop navigation bt------------------------------
    uicontrol('Style', 'pushbutton','String','Start planning',...
    'Units','Normalized','Position', [0.4 0.05 0.2 0.05],...
    'Callback', @start,'Tag','start'); 
end
function close(obj,event)
closereq;
rosshutdown;
end
function start(obj,event)
    %change axes to nav ones
     global plan_handle
     axes(plan_handle)
     cla(plan_handle)
     grid on;
     grid minor;
     hold on;
     %read the csv, plot it and obtain the paths and execute navigation
     map=csvread('map/map4.csv');
     map_and_nav(map);
end

function arrow_draw(up,down,left,right)
    %arrows for robot1
    uicontrol('Style', 'pushbutton','cdata',up,...
    'Units','Normalized','Position', [0.125 0.3 0.05 0.1],...
    'Callback', @move,'Tag','up');  
    uicontrol('Style', 'pushbutton','cdata',down,...
    'Units','Normalized','Position', [0.125 0.05 0.05 0.1],...
    'Callback', @move,'Tag','down');
    uicontrol('Style', 'pushbutton','cdata',left,...
    'Units','Normalized','Position', [0.05 0.18 0.05 0.1],...
    'Callback', @move,'Tag','left');  
    uicontrol('Style', 'pushbutton','cdata',right,...
    'Units','Normalized','Position', [0.2 0.18 0.05 0.1],...
    'Callback', @move,'Tag','right');

    %arrows for robot2
    uicontrol('Style', 'pushbutton','cdata',up,...
    'Units','Normalized','Position', [0.825 0.3 0.05 0.1],...
    'Callback', @move2,'Tag','up2');  
    uicontrol('Style', 'pushbutton','cdata',down,...
    'Units','Normalized','Position', [0.825 0.05 0.05 0.1],...
    'Callback', @move2,'Tag','down2');
    uicontrol('Style', 'pushbutton','cdata',left,...
    'Units','Normalized','Position', [0.75 0.18 0.05 0.1],...
    'Callback', @move2,'Tag','left2');  
    uicontrol('Style', 'pushbutton','cdata',right,...
    'Units','Normalized','Position', [0.9 0.18 0.05 0.1],...
    'Callback', @move2,'Tag','right2');
end
function [up,down,left,right]=read_arrows()
    up=imread('img/up.jpg');
    down=imread('img/down.jpg');
    left=imread('img/left.jpg');
    right=imread('img/right.jpg');
end

