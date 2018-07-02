function key_velCommand2(ID,key)
    global vel2
    global w2

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

