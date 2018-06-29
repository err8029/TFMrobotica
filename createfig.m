function createfig()
	hfig = figure;
	set(hfig,'numbertitle','off');               % erase figure number
	set(hfig,'name','Multi robot controller');
	set(hfig,'MenuBar','none');                  % erase menu
	set(hfig,'doublebuffer','on');               % two graphic buffers
	set(hfig,'CloseRequestFcn',@close)          % close request function (close window)
	set(hfig,'tag','MOSTRARDADES');              % identify figure
    set(hfig,'Units','Normalized','Position',[0.1,0.1,0.75,0.75]);
    
    %create axes for images
    global img1_handle
    global img2_handle
    img1_handle=axes('Units','Normalized','Position',[0.05 0.55 0.4 0.4]);
    img2_handle=axes('Units','Normalized','Position',[0.55 0.55 0.4 0.4]);
    [up,down,left,right]=read_arrows();
    
    %arrow buttons robots
    arrow_draw(up,down,left,right)
    
end
function close(obj,event)
closereq;
rosshutdown;
end

function move_up1(obj,event)
    global img1_handle
    global img2_sub
    for c=1:1:100
        send_velocity(1,0)
    end
    cam1_msg=img2_sub.LatestMessage;
    display_image(cam1_msg,img1_handle)
end
function move_down1(obj,event)   
    global img1_handle
    global img2_sub
    for c=1:1:100
        send_velocity(-1,0)
    end
    cam1_msg=img2_sub.LatestMessage;
    display_image(cam1_msg,img1_handle)
end
function move_left1(obj,event)
    global img1_handle
    global img2_sub
    for c=1:1:100
        send_velocity(0,1)
    end
    cam1_msg=img2_sub.LatestMessage;
    display_image(cam1_msg,img1_handle)
end
function move_right1(obj,event)
    global img1_handle
    global img2_sub
    for c=1:1:100
        send_velocity(0,-1)
    end
    cam1_msg=img2_sub.LatestMessage;
    display_image(cam1_msg,img1_handle)
end
function move_up2(obj,event)
    global img2_handle
    global img_sub
    for c=1:1:100
        send_velocity2(1,0)
    end
    cam2_msg=img_sub.LatestMessage;
    display_image(cam2_msg,img2_handle)
end
function move_down2(obj,event)
    global img2_handle
    global img_sub
    for c=1:1:100
        send_velocity2(-1,0)
    end
    cam2_msg=img_sub.LatestMessage;
    display_image(cam2_msg,img2_handle)
end
function move_left2(obj,event)
    global img2_handle
    global img_sub
    for c=1:1:100
        send_velocity2(0,1)
    end
    cam2_msg=img_sub.LatestMessage;
    display_image(cam2_msg,img2_handle)
end
function move_right2(obj,event)
    global img2_handle
    global img_sub
    for c=1:1:100
        send_velocity2(0,-1)
    end
    cam2_msg=img_sub.LatestMessage;
    display_image(cam2_msg,img2_handle)
end

function arrow_draw(up,down,left,right)
    %arrows for robot1
    uicontrol('Style', 'pushbutton','cdata',up,...
    'Units','Normalized','Position', [0.225 0.38 0.05 0.1],...
    'Callback', @move_up1,'Tag','up');  
    uicontrol('Style', 'pushbutton','cdata',down,...
    'Units','Normalized','Position', [0.225 0.12 0.05 0.1],...
    'Callback', @move_down1,'Tag','down');
    uicontrol('Style', 'pushbutton','cdata',left,...
    'Units','Normalized','Position', [0.15 0.25 0.05 0.1],...
    'Callback', @move_left1,'Tag','left');  
    uicontrol('Style', 'pushbutton','cdata',right,...
    'Units','Normalized','Position', [0.3 0.25 0.05 0.1],...
    'Callback', @move_right1,'Tag','right');

    %arrows for robot2
    uicontrol('Style', 'pushbutton','cdata',up,...
    'Units','Normalized','Position', [0.725 0.38 0.05 0.1],...
    'Callback', @move_up2,'Tag','up');  
    uicontrol('Style', 'pushbutton','cdata',down,...
    'Units','Normalized','Position', [0.725 0.12 0.05 0.1],...
    'Callback', @move_down2,'Tag','down');
    uicontrol('Style', 'pushbutton','cdata',left,...
    'Units','Normalized','Position', [0.65 0.25 0.05 0.1],...
    'Callback', @move_left2,'Tag','left');  
    uicontrol('Style', 'pushbutton','cdata',right,...
    'Units','Normalized','Position', [0.8 0.25 0.05 0.1],...
    'Callback', @move_right2,'Tag','right');
end
function [up,down,left,right]=read_arrows()
    up=imread('img/up.jpg');
    down=imread('img/down.jpg');
    left=imread('img/left.jpg');
    right=imread('img/right.jpg');
end

