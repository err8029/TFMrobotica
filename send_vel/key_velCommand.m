function key_velCommand(ID,key)
    global vel2
    global vel1
    global w1
    global w2
    disp(key)
    if strcmp('up',ID)|| strcmp('w',key)%move up robot 1
        for c=1:1:1
            send_velocity(vel1,0)
        end
    end
    if strcmp('down',ID) || strcmp('s',key)%move down robot 1
        for c=1:1:1
            send_velocity(-vel1,0)
        end
    end
    if strcmp('left',ID) || strcmp('a',key)%move left robot 1
        for c=1:1:1
            send_velocity(0,w1)
        end
    end
    if strcmp('right',ID) || strcmp('d',key)%move right robot 1
        for c=1:1:1
            send_velocity(0,-w1)
        end
    end
    if strcmp('up2',ID) || strcmp('uparrow',key)%move up robot 2
        for c=1:1:1
            send_velocity2(vel2,0)
        end    
    end
    if strcmp('down2',ID) || strcmp('downarrow',key)%move down robot 2
        for c=1:1:1
            send_velocity2(-vel2,0)
        end
    end
    if strcmp('left2',ID) || strcmp('leftarrow',key)%move left robot 2
        for c=1:1:1
            send_velocity2(0,w2)
        end
    end
    if strcmp('right2',ID) || strcmp('rightarrow',key)%move right robot 2
        for c=1:1:1
            send_velocity2(0,-w2)
        end
    end
end

