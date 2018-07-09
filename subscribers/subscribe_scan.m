function subscribe_scan()
%creates a gobal scan subscriber
    global scan_sub
    scan_sub = rossubscriber('/robot1/scan', 'BufferSize', 25);
    while isempty(scan_sub.LatestMessage)
        scan_sub = rossubscriber('/robot1/scan', 'BufferSize', 25);
    end
    global scan2_sub
    scan2_sub = rossubscriber('/robot2/scan2', 'BufferSize', 25);
    while isempty(odom2_sub.LatestMessage)
        scan2_sub = rossubscriber('/robot2/scan2', 'BufferSize', 25);
    end

end