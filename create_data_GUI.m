function create_data_GUI(obj,event)
    global plan_handle2
    global checker
    global count
    global count2
    
	cfig = figure;
	set(cfig,'numbertitle','off');               % erase figure number
	set(cfig,'name','Control panel');
	set(cfig,'MenuBar','none');                  % erase menu
	set(cfig,'doublebuffer','on');               % two graphic buffers
	set(cfig,'CloseRequestFcn',@close_data)          % close request function (close window)
	set(cfig,'tag','Visual data gathering');              % identify figure
    set(cfig,'Units','Normalized','Position',[0.1,0.1,0.4,0.5]);
    
    %--------------------------squares GUI-------------------------------
    draw_square(0.1,0.2,0.8,0.75,0.01);
    
    %------------------------map-------------------------------
    checker=true;
    plan_handle2=axes('Units','Normalized','Position',[0.2 0.3 0.6 0.6]);
    axes(plan_handle2)
    
    %------------------------texts------------------------------
    uicontrol('Style','text','Units','Normalized',...
    'Position',[0.35 0.125 0.3 0.05],...
    'String','Amount of positions','FontSize',15);
    uicontrol('Style','text','Units','Normalized',...
    'Position',[0.35 0.075 0.3 0.05],...
    'String',['Checker robot 1: ' num2str(count)],'FontSize',12);
    uicontrol('Style','text','Units','Normalized',...
    'Position',[0.35 0.025 0.3 0.05],...
    'String',['Checker robot 2: ' num2str(count2)],'FontSize',12);
    %-----------------------checkers plot-------------------------

    %-------------------------NAV----------------------------------
    raw_map=csvread('map/map4.csv');
    map_and_nav(raw_map)
end
function close_data(obj,event)
closereq;
end

