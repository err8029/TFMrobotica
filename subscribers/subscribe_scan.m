function subscribe_scan()
%creates a gobal scan subscriber
    global scan_sub
    global scan2_sub
    
    scan_sub = rossubscriber('/robot1/scan', 'BufferSize', 5);
    pause(0.25);
    scan2_sub = rossubscriber('/robot2/scan', 'BufferSize', 5);
    pause(0.25);
    disp(scan2_sub)
end