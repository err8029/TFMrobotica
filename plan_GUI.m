function [optimal_path, optimal_path2] = plan_GUI(raw_map)
    dmap=size(raw_map);

    %DEFINE THE 2-D MAP ARRAY FROM THE CSV
    % Initialize the MAP with input values
    % Obstacle=-1,Target = 0,Robot=1,Space=2
    MAX_X=dmap(1);
    MAX_Y=dmap(2);
    %This array stores the coordinates of the map and the 
    %Objects in each coordinate
    MAP=2*(ones(MAX_X,MAX_Y));

    axis([1 MAX_X+1 1 MAX_Y+1])
    grid on;
    grid minor;
    hold on;
    
    MAP=obstacle_placement(MAP,MAX_X,MAX_Y,raw_map);
    %gather start and target for robot 1
    [MAP,xStart,yStart,xTarget,yTarget]=data_gathering(MAP,1);
    %gather start and target for robot 2
    [MAP2,xStart2,yStart2,xTarget2,yTarget2]=data_gathering(MAP,2);
            
    %A* algorithm   
    optimal_path=astar(xTarget,yTarget,xStart,yStart,MAP,MAX_X,MAX_Y);
    optimal_path2=astar(xTarget2,yTarget2,xStart2,yStart2,MAP2,MAX_X,MAX_Y);
    
    %navigation
    nav(optimal_path,optimal_path2,xTarget,yTarget,xTarget2,yTarget2,xStart,yStart,xStart2,yStart2)
    
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
                plot(xval+.5,yval+.5,'ro');
           end
        end
    end
end
