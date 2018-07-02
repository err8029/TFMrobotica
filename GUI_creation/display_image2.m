function display_image2()
    %global vars for images
    global img2_sub
    global img2_handle
    %obtain the latest image from the subscriber
    cam2_msg=img2_sub.LatestMessage;
    %change to the axes of robot 2 and show the image
    axes(img2_handle)
    imshow(img_view(cam2_msg))
end

