function display_image()
    %global vars for images
    global img_sub
    global img1_handle
    %obtain the latest image from the subscriber
    cam1_msg=img_sub.LatestMessage;
    %change to the axes of robot 1 and show the image
    axes(img1_handle)
    imshow(img_view(cam1_msg))
end