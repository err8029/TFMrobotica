function adjust_vel1(obj,event)
    global w1_text
    global w1
    w1=obj.Value;
    w1_text.String=num2str(w1);
    
    %speed update
    speed_update()
end