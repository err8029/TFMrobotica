function subscribe_odom()
%creates a goba odom subscriber
    global odom_sub
    odom_sub = rossubscriber('/robot1/odom');
    while isempty(odom_sub.LatestMessage)
        odom_sub = rossubscriber('/robot1/odom');
    end
    global odom2_sub
    odom2_sub = rossubscriber('/robot2/odom');
    while isempty(odom2_sub.LatestMessage)
        odom2_sub = rossubscriber('/robot2/odom');
    end

end

