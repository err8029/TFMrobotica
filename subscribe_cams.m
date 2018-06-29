function subscribe_cams()
%returns the latest message for the cameras of the 2 robots, from there the
%images can be extracted
    global img_sub
    img_sub = rossubscriber('/robot1/camera/rgb/image_raw');
    while isempty(img_sub.LatestMessage)
        img_sub = rossubscriber('/robot1/camera/rgb/image_raw');
    end
    global img2_sub
    img2_sub = rossubscriber('/robot2/camera/rgb/image_raw');
    while isempty(img2_sub.LatestMessage)
        img2_sub = rossubscriber('/robot2/camera/rgb/image_raw');
    end

end

