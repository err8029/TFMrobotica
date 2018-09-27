
function [odom_sub]=subscribe_odom(rob_num)
%creates a goba odom subscriber
    if rob_num==1
        odom_sub = rossubscriber('/robot1/odom', 'BufferSize', 25);
        pause(0.01)
    else
        odom_sub = rossubscriber('/robot2/odom', 'BufferSize', 25);
        pause(0.01)
    end
end

