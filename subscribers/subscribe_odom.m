function subscribe_odom()
%creates a goba odom subscriber
    global odom_sub
    global odom2_sub
    global odom_pub_reset
    global odom_pub_reset2
    
    odom_sub = rossubscriber('/robot1/odom', 'BufferSize', 25);
    pause(0.01)
    odom2_sub = rossubscriber('/robot2/odom', 'BufferSize', 25);
    pause(0.01)
    
    odom_pub_reset = rospublisher('/robot1/mobile_base/commands/reset_odometry');
    pause(0.01)
    odom_pub_reset2 = rospublisher('/robot2/mobile_base/commands/reset_odometry');
    pause(0.01)

end

