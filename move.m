function move(obj,event)
    %update image for any previous movement due to inertia
    display_image()
    %Obtain the tag for the pressed button or the key from keyboard
    if strcmp(event.EventName,'KeyPress')
        key=event.Key;
        ID=[];
    else
        ID=obj.Tag;
        key=[];
    end
    %check which button has been pressed and command speed
    key_velCommand(ID,key)
    %update images
    display_image()
    %update odometry
    odom_update()
end