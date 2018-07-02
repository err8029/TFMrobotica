function speed_update()
    global vel1_rect_main
    global vel2_rect_main
    global vel1
    global vel2
    global w2
    global w1
    
    text=sprintf('%s\n%s\n%s','Velocity',['Linear: ' num2str(vel1) ' m/s'],['Angular: ' num2str(w1) ' rad/s']);
    vel1_rect_main.String=text;
    text=sprintf('%s\n%s\n%s','Velocity',['Linear: ' num2str(vel2) ' m/s'],['Angular: ' num2str(w2) ' rad/s']);
    vel2_rect_main.String=text;
end

