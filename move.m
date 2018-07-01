function move(obj,event)
    %Obtain the tag for the pressed button
    ID=obj.Tag;
   
    %check which button has been pressed
    if strcmp('up',ID)%move up robot 1
        for c=1:1:100
            send_velocity(1,0)
        end
    end
    if strcmp('down',ID)%move down robot 1
        for c=1:1:100
            send_velocity(-1,0)
        end
    end
    if strcmp('left',ID)%move left robot 1
        for c=1:1:100
            send_velocity(0,1)
        end
    end
    if strcmp('right',ID)%move right robot 1
        for c=1:1:100
            send_velocity(0,-1)
        end
    end
    if strcmp('up2',ID)%move up robot 2
        for c=1:1:100
            send_velocity2(1,0)
        end    
    end
    if strcmp('down2',ID)%move down robot 2
        for c=1:1:100
            send_velocity2(-1,0)
        end
    end
    if strcmp('left2',ID)%move left robot 2
        for c=1:1:100
            send_velocity2(0,1)
        end
    end
    if strcmp('right2',ID)%move right robot 2
        for c=1:1:100
            send_velocity2(0,-1)
        end
    end
    
    %update images
    display_image()
end