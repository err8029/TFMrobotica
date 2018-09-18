function map_and_nav(raw_map)
    global stop_bt
    global checker
    global enable_nav
    global plotobj
    global map_slam

    %define the total not reachable places counter
    obstacles=0;
    
    %DEFINE THE 2-D MAP ARRAY FROM THE CSV
    % Initialize the MAP with input values
    % Obstacle=-1,Target = 0,Robot=1,Space=2
    dmap=size(raw_map);
    MAX_X=dmap(1);
    MAX_Y=dmap(2);
    %This array stores the coordinates of the map and the 
    %Objects in each coordinate
    MAP=2*(ones(MAX_X,MAX_Y));

    axis([1 MAX_X+1 1 MAX_Y+1])
    grid on;
    grid minor;
    hold on;

    MAP=obstacle_placement(MAP,MAX_X,MAX_Y,raw_map,obstacles);
    %define an empty ocupancy grid
    map_slam = robotics.BinaryOccupancyGrid(dmap(1,1)*2+5,dmap(1,2)*2+5,5);
    
    if checker==true
        %checkboard creation and drawing
        [MAP,pos1,pos2]=checkboard(MAP,MAX_X,MAX_Y);
        disp(pos1)
        disp(pos2)
        MAP2=MAP;
        if enable_nav==true
            plotobj = TurtleBotVisualizer([0,dmap(1,1)+2,0,dmap(1,2)+2]);
        end
        %navigate to 100 sq of the grid
        for num=1:1:101
            if num>1
                %relative inital position
                xStart_rel=xTarget;
                yStart_rel=yTarget;
                xStart_rel2=xTarget2;
                yStart_rel2=yTarget2;
                %goal: reach the next sq of the grid
                xTarget=pos1(1,num);
                yTarget=pos1(2,num);
                xTarget2=pos2(1,num);
                yTarget2=pos2(2,num);
                
                plot(xStart_rel+.5,yStart+.5,'-bo','MarkerSize',5,'MarkerEdgeColor',[.1 1 .1],'MarkerFaceColor',[.1 1 .1]);
                text(xStart_rel+1,yStart+.5,'Robot 1')
                plot(xStart_rel2+.5,yStart2+.5,'-bo','MarkerSize',5,'MarkerEdgeColor',[.1 1 .1],'MarkerFaceColor',[.1 1 .1]);
                text(xStart_rel2+1,yStart2+.5,'Robot 2')

                plot(xTarget+.5,yTarget+.5,'-bo','MarkerSize',5,'MarkerEdgeColor',[.1 1 1],'MarkerFaceColor',[.1 1 1]);
                text(xTarget+1,yTarget+.5,'Target 1')
                plot(xTarget2+.5,yTarget2+.5,'-bo','MarkerSize',5,'MarkerEdgeColor',[.1 1 1],'MarkerFaceColor',[.1 1 1]);
                text(xTarget2+1,yTarget2+.5,'Target 2')
                
                %A* algorithm   
                optimal_path=astar(xTarget,yTarget,xStart_rel,yStart_rel,MAP,MAX_X,MAX_Y);
                optimal_path2=astar(xTarget2,yTarget2,xStart_rel2,yStart_rel2,MAP2,MAX_X,MAX_Y);
            else
                %absolute initial position of the robots
                xStart=5;
                yStart=15;
                xStart2=4;
                yStart2=4;
                %goal: reach the next sq of the grid
                xTarget=pos1(1,num);
                yTarget=pos1(2,num);
                xTarget2=pos2(1,num);
                yTarget2=pos2(2,num);
                
                plot(xStart+.5,yStart+.5,'-bo','MarkerSize',5,'MarkerEdgeColor',[.1 1 .1],'MarkerFaceColor',[.1 1 .1]);
                text(xStart+1,yStart+.5,'Robot 1')
                plot(xStart+.5,yStart2+.5,'-bo','MarkerSize',5,'MarkerEdgeColor',[.1 1 .1],'MarkerFaceColor',[.1 1 .1]);
                text(xStart+1,yStart2+.5,'Robot 2')

                plot(xTarget+.5,yTarget+.5,'-bo','MarkerSize',5,'MarkerEdgeColor',[.1 1 1],'MarkerFaceColor',[.1 1 1]);
                text(xTarget+1,yTarget+.5,'Target 1')
                plot(xTarget2+.5,yTarget2+.5,'-bo','MarkerSize',5,'MarkerEdgeColor',[.1 1 1],'MarkerFaceColor',[.1 1 1]);
                text(xTarget2+1,yTarget2+.5,'Target 2')
                
                %A* algorithm   
                optimal_path=astar(xTarget,yTarget,xStart,yStart,MAP,MAX_X,MAX_Y);
                optimal_path2=astar(xTarget2,yTarget2,xStart2,yStart2,MAP2,MAX_X,MAX_Y);
            end 

            %check stop
            if get(stop_bt, 'userdata') % stop condition
                set(stop_bt, 'userdata',0)
            else
                %analyse the new paths
                %path_analyser(optimal_path,optimal_path2,MAP,MAP2,MAX_X,MAX_Y,xStart,yStart,xTarget,yTarget)

                %navigation
                nav(optimal_path,optimal_path2,xTarget,yTarget,xTarget2,yTarget2,xStart,yStart,xStart2,yStart2,dmap)
            end
        end
        checker=false;         
    else
        %gather start and target for robot 1
        [MAP,xStart,yStart,xTarget,yTarget]=data_gathering(MAP,1);
        %gather start and target for robot 2
        [MAP2,xStart2,yStart2,xTarget2,yTarget2]=data_gathering(MAP,2);
        %init map
        if enable_nav==true
            plotobj = TurtleBotVisualizer([0,dmap(1,1)+2,0,dmap(1,2)+2]);
        end
        %check stop
        if get(stop_bt, 'userdata') % stop condition
            set(stop_bt, 'userdata',0)
        else
            %A* algorithm   
            optimal_path=astar(xTarget,yTarget,xStart,yStart,MAP,MAX_X,MAX_Y);
            optimal_path2=astar(xTarget2,yTarget2,xStart2,yStart2,MAP2,MAX_X,MAX_Y);

            %analyse the new paths
            %path_analyser(optimal_path,optimal_path2,MAP,MAP2,MAX_X,MAX_Y,xStart,yStart,xTarget,yTarget)

            %navigation
            nav(optimal_path,optimal_path2,xTarget,yTarget,xTarget2,yTarget2,xStart,yStart,xStart2,yStart2,dmap)
        end
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
    global plan_handle
    axes(plan_handle)
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
function [MAP,pos1,pos2] = checkboard(MAP,MAX_X,MAX_Y)
       global count
       global count2
       %checker positions for robot1 and 2
       pos1=[];
       pos2=[];
       %counter for total number of points of the checker
       count=1;
       count2=1;
       %checkerboard drawing with a safe perimeter of 1
       for x=3:1:MAX_X-2
           for y=3:1:MAX_Y-2
               if MAP(x,y)~=1 && MAP(x,y)~=-1
                    if mod(x,2)==0
                        if mod(y,2)==0
                            plot(x+.5,y+.5,'-s','MarkerSize',10,'MarkerEdgeColor',[.6 .6 .6],'MarkerFaceColor',[.6 .6 .6]);
                            pos1(:,count)=[x y];
                            count=count+1;
                        else
                            pos2(:,count2)=[x y];
                            count2=count2+1;
                        end
                    end
                    if mod(x,2)~=0
                        if mod(y,2)~=0
                            plot(x+.5,y+.5,'-s','MarkerSize',10,'MarkerEdgeColor',[.6 .6 .6],'MarkerFaceColor',[.6 .6 .6]);
                            pos1(:,count)=[x y];
                            count=count+1;
                        else
                            pos2(:,count2)=[x y];
                            count2=count2+1;
                        end
                    end
               end
           end
       end
end
function [MAP] = obstacle_placement(MAP,MAX_X,MAX_Y,map,obstacles)
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
                    obstacles=obstacles+3;
                    
                end
                if map(x,y)==0 && map(x+1,y)==1 && map(x+1,y+1)==0 && map(x,y+1)==0
                    MAP(x,y)=-1;
                    MAP(x,y+1)=-1;
                    MAP(x+1,y+1)=-1;
                    plot(x+.5,y+.5,'b*');
                    plot(x+.5,y+1+.5,'b*');
                    plot(x+1+.5,y+1+.5,'b*');
                    obstacles=obstacles+3;
                end
                if map(x,y)==0 && map(x+1,y)==0 && map(x+1,y+1)==1 && map(x,y+1)==0
                    MAP(x,y)=-1;
                    MAP(x,y+1)=-1;
                    MAP(x+1,y)=-1;
                    plot(x+1+.5,y+.5,'b*');
                    plot(x+.5,y+1+.5,'b*');
                    plot(x+.5,y+.5,'b*');
                    obstacles=obstacles+3;
                end
                if map(x,y)==0 && map(x+1,y)==0 && map(x+1,y+1)==0 && map(x,y+1)==1
                    MAP(x+1,y+1)=-1;
                    MAP(x,y)=-1;
                    MAP(x+1,y)=-1;
                    plot(x+1+.5,y+1+.5,'b*');
                    plot(x+.5,y+.5,'b*');
                    plot(x+1+.5,y+.5,'b*');
                    obstacles=obstacles+3;
                end
            end
           %obstacle placement
           if map(x,y)==1
                xval=x;
                yval=y;
                MAP(xval,yval)=-1;
                plot(x+.5,y+.5,'-s','MarkerSize',15.5,'MarkerEdgeColor',[.3 .3 .3],'MarkerFaceColor',[1 .1 .1]);
                %plot(xval+.5,yval+.5,'ro');
                obstacles=obstacles+1;
           end       
        end
    end
end
