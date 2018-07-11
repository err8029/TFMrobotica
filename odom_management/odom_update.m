function odom_update()
    %update odometry for any previous inertia
    global position1_text
    global orientation1_text
    global position1
    global orientation1
    
    odom_obtention();
    text=sprintf('%s\n%s\n%s\n%s','Position',['X: ' num2str(position1(1)) ' m'],['Y: ' num2str(position1(2)) ' m'],['Z: ' num2str(position1(3)) ' m']);
    position1_text.String=text;
    text=sprintf('%s\n%s\n%s\n%s','Orientation',['X: ' num2str((180/pi)*orientation1(1)) ' deg'],['Y: ' num2str(orientation1(2)) ' deg'],['Z: ' num2str(orientation1(3)) ' deg']);
    orientation1_text.String=text;
end

