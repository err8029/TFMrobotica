function key_velCommand(ID,key)
    global vel1
    global w1

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
end

