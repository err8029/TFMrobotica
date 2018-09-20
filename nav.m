function nav(GUI,optimal_path,optimal_path2,xTarget,yTarget,xTarget2,yTarget2,xStart,yStart,xStart2,yStart2,dmap)
    %by default reactive mode is not activated
    reactive2=false;
    reactive=false;
    %counter for mapping
    gmap_c=1;
    %init generated_map
    if isempty(GUI.generated_map)
        GUI.generated_map=robotics.BinaryOccupancyGrid(dmap(1,1)*2+5,dmap(1,2)*2+5,5);
    end
    %define a plot obj for the ocupancy grid
    if GUI.enable_bts.enable_nav==true
        GUI.map_window = TurtleBotVisualizer([0,dmap(1,1)+2,0,dmap(1,2)+2]);
    end
    %init current pos
    [position1, orientation1] = GUI.robots.odom_obtention(1);
    [position2, orientation2] = GUI.robots.odom_obtention(2);

%     orientation_ans=orientation1(1);
%     orientation2_ans=orientation2(1);
    %reset odom but save orientation
    %reset_odom();
    %orientation1(1)=orientation_ans+orientation1(1);
    %orientation2(1)=orientation2_ans+orientation2(1);
    
    curent_pos_x=position1(1)+xStart;
    curent_pos_y=position1(2)+yStart;
    pose=[curent_pos_x curent_pos_y orientation1(1)];

    %init current pos2
    curent_pos_x2=position2(1)+xStart2;
    curent_pos_y2=position2(2)+yStart2;
    pose2=[curent_pos_x2 curent_pos_y2 orientation2(1)];

    %init the purepursuit controller
    controller=GUI.robots.purePursuit_init(optimal_path);
    controller2=GUI.robots.purePursuit_init(optimal_path2);
    controlRate = robotics.Rate(10);

    %reached flags for robots
    reached1=false;
    reached2=false;
    
    %NAVIGATION STARTS
    %init nav
    while reached1==false || reached2==false
        %check stop
        pause(0.1);
        
        %update ocupancy grid
        if GUI.enable_bts.enable_nav==true && gmap_c>GUI.robots.freq
            %occuancy grid for robot 1
            if reached1==false
                laserMsg = receive(GUI.robots.subs.scan1,3);%recieve messages from the subscriber
                laserdata=GUI.robots.read_laser(laserMsg);
                [dis,dir]=GUI.robots.distance_extract(laserdata);
                %if distance is too short reactive mode is activated
                if dis<0.7
                    reactive=true;
                else
                    reactive=false;
                end
                plotData(GUI.map_window,pose,laserdata);
                [dataWorld]=plotData(GUI.map_window,pose,laserdata);
                if ~isempty(laserdata)
                    setOccupancy(GUI.generated_map,dataWorld,1);
                end
            end
            %occuancy grid for robot 2
            if reached2==false
                laserMsg = receive(GUI.robots.subs.scan2,3);
                laserdata=GUI.robots.read_laser(laserMsg);
                [dis2,dir2]=GUI.robots.distance_extract(laserdata);
                %if distance is too short reactive mode is activated
                if dis2<0.7
                    reactive2=true;
                else
                    reactive2=false;
                end
                plotData(GUI.map_window,pose2,laserdata);
                [dataWorld]=plotData(GUI.map_window,pose2,laserdata);
                if ~isempty(laserdata)
                    setOccupancy(GUI.generated_map,dataWorld,1);
                end
            end
        end
        if gmap_c>GUI.robots.freq            
            pause(0.1);
            gmap_c=1;
        end
        %check stop
        if GUI.error==1
            GUI.error=0;
            GUI.msg()
            break;
        end
        %%send new speed comands
        % Re-compute speeds if we r not in reactive mode
        if reached1==false && reactive==false
            [v, w] = step(controller,pose);
            GUI.robots.send_velocity(v,w,1);
            waitfor(controlRate);
            [position1,orientation1]=GUI.odom_update(1);
            GUI.robots.display_image(GUI.enable_bts.enable1,GUI.img1_handle,1);
            pose=[curent_pos_x+position1(1) curent_pos_y+position1(2) orientation1(1)];
            gmap_c=gmap_c+1;
        end
        if reached2==false && reactive==false
            [vs2, ws2] = step(controller2,pose2);
            GUI.robots.send_velocity(vs2,ws2,2);
            waitfor(controlRate);
            [position2,orientation2]=GUI.odom_update(2);%update texts in GUI
            GUI.robots.display_image(GUI.enable_bts.enable2,GUI.img2_handle,2);
            pose2=[curent_pos_x2+position2(1) curent_pos_y2+position2(2) orientation2(1)];
            gmap_c=gmap_c+1;
        end
        

        %reactive control for collision avoidance
        if reactive==true
            disp('reactive')
            %check direction given by distance of the obstacles
            if dir=='l'
                w=0.4;%minus if left
                v=0.2;
            else
                w=-0.4;
                v=0.2;
            end
            GUI.robots.send_velocity(v,w,1);
            reactive=false;
        end
        %spin for robot 2
        if reactive2==true

            %check direction given by distance of the obstacles
            if dir2=='l'
                w=0.4;
                v=0.2;
            else
                w=-0.4;
                v=0.2;
            end
            GUI.robots.send_velocity(v,w,2);
            reactive2=false;
        end
        
        if pose(1)>(xTarget-0.1) && pose(2)>(yTarget-0.1) && pose(1)<(xTarget+0.1) && pose(2)<(yTarget+0.1)
            GUI.robots.send_velocity(0,0,1)
            reached1=true;
        end
        if pose2(1)>(xTarget2-0.1) && pose2(2)>(yTarget2-0.1) && pose2(1)<(xTarget2+0.1) && pose2(2)<(yTarget2+0.1)
            GUI.robots.send_velocity(0,0,2)
            reached2=true;
        end
        if reached1==true && reached2==true
            title='Succesful';
            message=({'Task finished'});
            myicon=imread('img/warning.png');
            myicon=imresize(myicon, [64, 64]);
            msgbox(message,title,'custom',myicon)
        end
    end
%end of the navigation, so we end counting time
end