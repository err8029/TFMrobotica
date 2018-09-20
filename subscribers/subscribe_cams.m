
function [img_sub]=subscribe_cams(rob_num)
%returns the latest message for the cameras of the 2 robots, from there the
%images can be extracted
    if rob_num==1
        img_sub = rossubscriber('/robot1/camera/rgb/image_raw');
        pause(0.01)
    else
        img_sub = rossubscriber('/robot2/camera/rgb/image_raw');
        pause(0.01)
    end
end

