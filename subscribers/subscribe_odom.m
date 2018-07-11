function subscribe_odom()
%creates a goba odom subscriber
    global odom_sub
    global odom2_sub
    
    odom_sub = rossubscriber('/robot1/odom', 'BufferSize', 25);
    pause(0.01)
    odom2_sub = rossubscriber('/robot2/odom', 'BufferSize', 25);
    pause(0.01)
end

