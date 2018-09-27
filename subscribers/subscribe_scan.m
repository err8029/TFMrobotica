
function [scan_sub]=subscribe_scan(rob_num)
%creates a gobal scan subscriber
    if rob_num==1
        scan_sub = rossubscriber('/robot1/scan', 'BufferSize', 5);
        pause(0.25);
    else
        scan_sub = rossubscriber('/robot2/scan', 'BufferSize', 5);
        pause(0.25);
    end
end