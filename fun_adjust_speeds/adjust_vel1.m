function adjust_vel1(obj,event)
    global vel1_text
    global vel1
    vel1=obj.Value;
    vel1_text.String=num2str(vel1);
    
    %speed update
    speed_update()
end

