function nav(optimal_path,optimal_path2,xTarget,yTarget,xTarget2,yTarget2,xStart,yStart,xStart2,yStart2)
    global position1
    global position2
    global orientation1
    global orientation2
    global stop_bt
    global vel1
    global vel2
    global w1
    global w2

    %init current pos
    odom_obtention();
    curent_pos_x=position1(1)+xStart;
    curent_pos_y=position1(2)+yStart;
    pose=[curent_pos_x curent_pos_y orientation1(1)];
    
    %init current pos2
    odom_obtention();
    curent_pos_x2=position2(1)+xStart2;
    curent_pos_y2=position2(2)+yStart2;
    pose2=[curent_pos_x2 curent_pos_y2 orientation2(1)];

    %init the purepursuit controller
    controller=purePursuit_init(optimal_path,vel1,w1);
    controller2=purePursuit_init(optimal_path2,vel2,w2);
    controlRate = robotics.Rate(10);

    %reached flags for robots
    reached1=false;
    reached2=false;
    
    %NAVIGATION STARTS
    %init nav
    while reached1==false || reached2==false
        %check stop
        pause(0.1);
        if get(stop_bt, 'userdata') % stop condition
            set(stop_bt, 'userdata',0)
            break;
        end
        %%send new speed comands
        % Re-compute speeds
        if reached1==false
            [v, w] = step(controller,pose);
            send_velocity(v,w);
            waitfor(controlRate);
            odom_update();
            display_image();
            pose=[curent_pos_x+position1(1) curent_pos_y+position1(2) orientation1(1)];
        end
        if reached2==false
            [vs2, ws2] = step(controller2,pose2);
            send_velocity2(vs2,ws2);
            waitfor(controlRate);
            odom_update2();
            display_image2();
            pose2=[curent_pos_x2+position2(1) curent_pos_y2+position2(2) orientation2(1)];
        end    
        if pose(1)>(xTarget-0.1) && pose(2)>(yTarget-0.1) && pose(1)<(xTarget+0.1) && pose(2)<(yTarget+0.1)
            send_velocity(0,0)
            reached1=true;
        end
        if pose2(1)>(xTarget2-0.1) && pose2(2)>(yTarget2-0.1) && pose2(1)<(xTarget2+0.1) && pose2(2)<(yTarget2+0.1)
            send_velocity2(0,0)
            reached2=true;
        end
    end
%end of the navigation, so we end counting time
end