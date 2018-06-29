function move_up1(obj,event,img_sub)
    for c=1:1:100
        send_velocity(0.5,0,1)
    end
    %unpack the messages
    cam1_msg=img_sub.LatestMessage;
    display_image(cam1_msg,img1_handle)
end