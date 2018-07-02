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
    draw_rectangles(0);
    %rectangles for robot 2
    draw_rectangles(0.5);
    %text for robot1
    uicontrol('Style', 'text','String','Robot 1',...
    'Units','Normalized','Position', [0.05 0.9 0.4 0.07],...
    'BackgroundColor',[0.5 0.5 0.5],'FontSize',20,'ForegroundColor',[1 1 1]);  
    %text for robot2
    uicontrol('Style', 'text','String','Robot 2',...
    'Units','Normalized','Position', [0.55 0.9 0.4 0.07],...
    'BackgroundColor',[0.5 0.5 0.5],'FontSize',20,'ForegroundColor',[1 1 1]); 

    %-------------------create axes for images----------------------------
    global img1_handle
    global img2_handle
    img1_handle=axes('Units','Normalized','Position',[0.05 0.45 0.4 0.4]);
    img2_handle=axes('Units','Normalized','Position',[0.55 0.45 0.4 0.4]);
    [up,down,left,right]=read_arrows();
    
    %--------------------arrow buttons robots-----------------------------
    arrow_draw(up,down,left,right)
    %----------------create rectangles for odom---------------------------
    global position1_text
    global position2_text
    global orientation1_text
    global orientation2_text
    
    [position1,orientation1] = odom_obtention();    
    text=sprintf('%s\n%s\n%s\n%s','Position',['X: ' num2str(position1(1)) ' m'],['Y: ' num2str(position1(2)) ' m'],['Z: ' num2str(position1(3)) ' m']);
    position1_text=uicontrol('Style', 'text','String',text,'Tag','Positon1',...
    'Units','Normalized','Position', [0.29 0.03 0.15 0.1],'HorizontalAlignment','Left',...
    'BackgroundColor',[0.5 0.5 0.5],'FontSize',13,'ForegroundColor',[1 1 1]); 
    text=sprintf('%s\n%s\n%s\n%s','Orientation',['X: ' num2str(orientation1(1)) ' deg'],['Y: ' num2str(orientation1(2)) ' deg'],['Z: ' num2str(orientation1(3)) ' deg']);
    orientation1_text=uicontrol('Style', 'text','String',text,'Tag','Orientation1',...
    'Units','Normalized','Position', [0.06 0.03 0.15 0.1],'HorizontalAlignment','Left',...
    'BackgroundColor',[0.5 0.5 0.5],'FontSize',13,'ForegroundColor',[1 1 1]); 

    [position2,orientation2] = odom_obtention2();
    text2=sprintf('%s\n%s\n%s\n%s','Position',['X: ' num2str(position2(1)) ' m'],['Y: ' num2str(position2(2)) ' m'],['Z: ' num2str(position2(3)) ' m']);
    position2_text=uicontrol('Style', 'text','String',text2,...
    'Units','Normalized','Position', [0.79 0.03 0.15 0.1],'HorizontalAlignment','Left',...
    'BackgroundColor',[0.5 0.5 0.5],'FontSize',13,'ForegroundColor',[1 1 1]); 
    text2=sprintf('%s\n%s\n%s\n%s','Orientation',['X: ' num2str(orientation2(1)) ' deg'],['Y: ' num2str(orientation2(2)) ' deg'],['Z: ' num2str(orientation2(3)) ' deg']);
    orientation2_text=uicontrol('Style', 'text','String',text2,...
    'Units','Normalized','Position', [0.56 0.03 0.15 0.1],'HorizontalAlignment','Left',...
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
    'Units','Normalized','Position', [0.06 0.905 0.15 0.06],'HorizontalAlignment','Left',...
    'BackgroundColor',[0.5 0.5 0.5],'FontSize',10,'ForegroundColor',[1 1 1]); 

    text=sprintf('%s\n%s\n%s','Velocity',['Linear: ' num2str(vel2) ' m/s'],['Angular: ' num2str(w2) ' rad/s']);
    vel2_rect_main=uicontrol('Style', 'text','String',text,...
    'Units','Normalized','Position', [0.56 0.905 0.15 0.06],'HorizontalAlignment','Left',...
    'BackgroundColor',[0.5 0.5 0.5],'FontSize',10,'ForegroundColor',[1 1 1]); 
    
    %-------------------display initial images----------------------------
    display_image()
    display_image2()
end
function close(obj,event)
closereq;
rosshutdown;
end

function arrow_draw(up,down,left,right)
    %arrows for robot1
    uicontrol('Style', 'pushbutton','cdata',up,...
    'Units','Normalized','Position', [0.225 0.3 0.05 0.1],...
    'Callback', @move,'Tag','up');  
    uicontrol('Style', 'pushbutton','cdata',down,...
    'Units','Normalized','Position', [0.225 0.05 0.05 0.1],...
    'Callback', @move,'Tag','down');
    uicontrol('Style', 'pushbutton','cdata',left,...
    'Units','Normalized','Position', [0.15 0.18 0.05 0.1],...
    'Callback', @move,'Tag','left');  
    uicontrol('Style', 'pushbutton','cdata',right,...
    'Units','Normalized','Position', [0.3 0.18 0.05 0.1],...
    'Callback', @move,'Tag','right');

    %arrows for robot2
    uicontrol('Style', 'pushbutton','cdata',up,...
    'Units','Normalized','Position', [0.725 0.3 0.05 0.1],...
    'Callback', @move,'Tag','up2');  
    uicontrol('Style', 'pushbutton','cdata',down,...
    'Units','Normalized','Position', [0.725 0.05 0.05 0.1],...
    'Callback', @move,'Tag','down2');
    uicontrol('Style', 'pushbutton','cdata',left,...
    'Units','Normalized','Position', [0.65 0.18 0.05 0.1],...
    'Callback', @move,'Tag','left2');  
    uicontrol('Style', 'pushbutton','cdata',right,...
    'Units','Normalized','Position', [0.8 0.18 0.05 0.1],...
    'Callback', @move,'Tag','right2');
end
function [up,down,left,right]=read_arrows()
    up=imread('img/up.jpg');
    down=imread('img/down.jpg');
    left=imread('img/left.jpg');
    right=imread('img/right.jpg');
end

