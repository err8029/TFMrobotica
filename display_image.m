function display_image()
    %global vars for images
    global img_sub
    global img2_sub
    global img2_handle
    global img1_handle
    %obtain the latest image from the subscriber
    cam1_msg=img_sub.LatestMessage;
    cam2_msg=img2_sub.LatestMessage;
    %change to the axes of robot 1 and show the image
    axes(img1_handle)
    imshow(img_view(cam2_msg))
    %change to the axes of robot 2 and show the image
    axes(img2_handle)
    imshow(img_view(cam1_msg))
end