function [pose,pose2]=continue_nav(pose,pose2,curent_pos_x,curent_pos_y,curent_pos_x2,curent_pos_y2,controller,controller2,controlRate,xTarget,yTarget,xTarget2,yTarget2)
    global stop_var
    global position1
    global position2
    global orientation1
    global orientation2


    
    
    %check if we arrived or the nav is aborted
    if pose(1)>(xTarget-0.1) && pose(2)>(yTarget-0.1) && pose(1)<(xTarget+0.1) && pose(2)<(yTarget+0.1)
        disp('arrived1');
    elseif pose2(1)>(xTarget2-0.1) && pose2(2)>(yTarget2-0.1) && pose2(1)<(xTarget2+0.1) && pose2(2)<(yTarget2+0.1)
        disp('arrived2');
    elseif stop_var==true
        disp('stoped')
    else
        [pose,pose2]=continue_nav(pose,pose2,curent_pos_x,curent_pos_y,curent_pos_x2,curent_pos_y2,controller,controller2,controlRate,xTarget,yTarget,xTarget2,yTarget2);
    end
end

