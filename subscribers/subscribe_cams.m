function subscribe_cams()
%returns the latest message for the cameras of the 2 robots, from there the
%images can be extracted
    global img_sub
    global img2_sub
    
    img_sub = rossubscriber('/robot1/camera/rgb/image_raw');
    pause(0.01)
    img2_sub = rossubscriber('/robot2/camera/rgb/image_raw');
    pause(0.01)
end

