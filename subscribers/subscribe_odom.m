function subscribe_odom()
%creates a goba odom subscriber
    global odom_sub
    global odom2_sub
    
    odom_sub = rossubscriber('/robot1/odom', 'BufferSize', 25);
    while isempty(odom_sub.LatestMessage)
        odom_sub = rossubscriber('/robot1/odom', 'BufferSize', 25);
    end
    odom2_sub = rossubscriber('/robot2/odom', 'BufferSize', 25);
    while isempty(odom2_sub.LatestMessage)
        odom2_sub = rossubscriber('/robot2/odom', 'BufferSize', 25);
    end

end

