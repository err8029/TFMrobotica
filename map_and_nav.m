
function map_and_nav(raw_map,GUI)  
    %DEFINE THE 2-D MAP ARRAY FROM THE CSV
    % Initialize the MAP with input values
    % Obstacle=-1,Target = 0,Robot=1,Space=2
    error=0;%var to control error in data gathering
    
    %DEFINE THE 2-D MAP ARRAY FROM THE CSV
    % Initialize the MAP with input values
    % Obstacle=-1,Target = 0,Robot=1,Space=2
    dmap=size(raw_map);
    MAX_X=dmap(1);
    MAX_Y=dmap(2);
    %This array stores the cost map for A* and all obstacles
    MAP=2*(ones(MAX_X,MAX_Y));
    %plot and save map
    axes(GUI.plan_handle);
    MAP=obstacle_placement(MAP,MAX_X,MAX_Y,raw_map);
    MAP2=MAP;
    
    axis([1 MAX_X+1 1 MAX_Y+1])
    grid on;
    grid minor;
    hold on;
    
    if isempty(GUI.robots.xStart)==true
        try
            axes(GUI.plan_handle);
            %gather start and target for robot 1
            [MAP,GUI.robots.xStart,GUI.robots.yStart,GUI.robots.xTarget,GUI.robots.yTarget]=data_gathering(MAP,1);
            %gather start and target for robot 2
            [MAP2,GUI.robots.xStart2,GUI.robots.yStart2,GUI.robots.xTarget2,GUI.robots.yTarget2]=data_gathering(MAP2,2);
        catch
            error=1;
        end
        %init generated_map and mapping class as map_window obj
        if GUI.enable_bts.enable_nav==true
            GUI.map_window = TurtleBotVisualizer([0,dmap(1,1)+2,0,dmap(1,2)+2]);
        end
        if isempty(GUI.generated_map)
            GUI.generated_map=robotics.BinaryOccupancyGrid(dmap(1,1)*2+5,dmap(1,2)*2+5,5);
        end
    else
        GUI.robots.reset_odom();
        GUI.robots.xStart=GUI.robots.xTarget+1;
        GUI.robots.yStart=GUI.robots.yTarget;
        GUI.robots.yStart2=GUI.robots.yTarget2;
        GUI.robots.xStart2=GUI.robots.xTarget2+1;
        GUI.robots.xTarget=5;
        GUI.robots.yTarget=15+1;
        GUI.robots.yTarget2=4+1;
        GUI.robots.xTarget2=4;
        %init new MAPs for A* algotihm with targets for the new task
        MAP(GUI.robots.xTarget,GUI.robots.yTarget)=0;
        MAP2(GUI.robots.xTarget2,GUI.robots.yTarget2)=0;
    end
    %check stop
    if  GUI.error==1
        GUI.error=0;
    end
    if error==1%stop the process completly
        GUI.msg()
    end
    if error==0 && GUI.error==0
        %when navigation starts delete any previous messages
        delete(GUI.warn_msg)
        axes(GUI.plan_handle);
        %A* algorithm   
        optimal_path=astar(GUI.robots.xTarget,GUI.robots.yTarget,GUI.robots.xStart,GUI.robots.yStart,MAP,MAX_X,MAX_Y);
        optimal_path2=astar(GUI.robots.xTarget2,GUI.robots.yTarget2,GUI.robots.xStart2,GUI.robots.yStart2,MAP2,MAX_X,MAX_Y);
    
        %analyse the new paths
        %path_analyser(optimal_path,optimal_path2,MAP,MAP2,MAX_X,MAX_Y,GUI.xStart,GUI.yStart,GUI.xTarget,GUI.yTarget)
        
        %navigation
        nav(GUI,optimal_path,optimal_path2,GUI.robots.xTarget,GUI.robots.yTarget,GUI.robots.xTarget2,GUI.robots.yTarget2,...
            GUI.robots.xStart,GUI.robots.yStart,GUI.robots.xStart2,GUI.robots.yStart2)
    end   
end
function [MAP,xStart,yStart,xTarget,yTarget]=data_gathering(MAP,rob_num)
    % BEGIN Interactive Obstacle, Target, Start Location selection
    pause(1);
    h=msgbox(['Select the target for robot ' num2str(rob_num)]);
    uiwait(h,3)
    if ishandle(h) == 1
        delete(h);
    end
    but=0;
    while (but ~= 1) %Repeat until the Left button is not clicked
        [xval,yval,but]=ginput(1);
    end

    xval=floor(xval);
    yval=floor(yval);
    xTarget=xval;%X Coordinate of the Target
    yTarget=yval;%Y Coordinate of the Target

    MAP(xval,yval)=0;%Initialize MAP with location of the target
    plot(xval+.5,yval+.5,'gd');
    text(xval+1,yval+.5,['Target' num2str(rob_num)])

    %ask the user for the current position of the robot
    prompt1='enter the start x position';
    title1='pos_x';
    pos_x = inputdlg(prompt1,title1);

    prompt2='enter the start y position';
    title2='pos_y';
    pos_y = inputdlg(prompt2,title2);

    %save and plot the start position
    xStart=floor(str2double(pos_x));%Starting Position
    yStart=floor(str2double(pos_y));%Starting Position
    plot(xStart+.5,yStart+.5,'bo');
    text(xStart+1,yStart+.5,['Robot' num2str(rob_num)])
end
function MAP = obstacle_placement(MAP,MAX_X,MAX_Y,map)
    %detect obstacles in the CSV and store in the map also checks for
    %corners and puts an * in their sorroundings, all following the criteria
    %specified upwards
    for x=1:1:MAX_X
        for y=1:1:MAX_Y
           plot(x+.5,y+.5,'-s','MarkerSize',15.5,'MarkerEdgeColor',[.3 .3 .3]);
           %corner placement
            if x<MAX_X && y<MAX_Y
                if map(x,y)==1 && map(x+1,y)==0 && map(x+1,y+1)==0 && map(x,y+1)==0
                    MAP(x+1,y+1)=-1;
                    MAP(x,y+1)=-1;
                    MAP(x+1,y)=-1;
                    plot(x+1+.5,y+1+.5,'b*');
                    plot(x+.5,y+1+.5,'b*');
                    plot(x+1+.5,y+.5,'b*');
                end
                if map(x,y)==0 && map(x+1,y)==1 && map(x+1,y+1)==0 && map(x,y+1)==0
                    MAP(x,y)=-1;
                    MAP(x,y+1)=-1;
                    MAP(x+1,y+1)=-1;
                    plot(x+.5,y+.5,'b*');
                    plot(x+.5,y+1+.5,'b*');
                    plot(x+1+.5,y+1+.5,'b*');          
                end
                if map(x,y)==0 && map(x+1,y)==0 && map(x+1,y+1)==1 && map(x,y+1)==0
                    MAP(x,y)=-1;
                    MAP(x,y+1)=-1;
                    MAP(x+1,y)=-1;
                    plot(x+1+.5,y+.5,'b*');
                    plot(x+.5,y+1+.5,'b*');
                    plot(x+.5,y+.5,'b*');        

                end
                if map(x,y)==0 && map(x+1,y)==0 && map(x+1,y+1)==0 && map(x,y+1)==1
                    MAP(x+1,y+1)=-1;
                    MAP(x,y)=-1;
                    MAP(x+1,y)=-1;
                    plot(x+1+.5,y+1+.5,'b*');
                    plot(x+.5,y+.5,'b*');
                    plot(x+1+.5,y+.5,'b*');          
                end
            end
           %obstacle placement
           if map(x,y)==1
                xval=x;
                yval=y;
                MAP(xval,yval)=-1;
                plot(x+.5,y+.5,'-s','MarkerSize',15.5,'MarkerEdgeColor',[.3 .3 .3],'MarkerFaceColor',[1 .1 .1]);
           end
        end
    end
end
