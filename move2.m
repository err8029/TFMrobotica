function move2(obj,event)
    disp('r2')
    disp(event.Key)
    %update image for any previous movement due to inertia
    display_image2()
    %Obtain the tag for the pressed button or the key from keyboard
    if strcmp(event.EventName,'KeyPress')
        key=event.Key;
        ID=[];
    else
        ID=obj.Tag;
        key=[];
    end
    %check which button has been pressed and command speed
    key_velCommand2(ID,key)
    global hfig
    hfig.CurrentCharacter=' ';
    %update images
    display_image2()
    %update odometry
    odom_update2()
    %listen to the other robot
    set(hfig,'KeyPressFcn',@move);   
end