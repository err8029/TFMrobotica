function subscribe_scan()
%creates a gobal scan subscriber
    global scan_sub
    global scan2_sub
    
    scan_sub = rossubscriber('/robot1/scan');
    while isempty(scan_sub.LatestMessage)
        scan_sub = rossubscriber('/robot1/scan');
    end
    scan2_sub = rossubscriber('/robot2/scan');
    while isempty(scan2_sub.LatestMessage)
        scan2_sub = rossubscriber('/robot2/scan');
    end

end