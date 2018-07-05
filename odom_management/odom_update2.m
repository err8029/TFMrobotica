function odom_update2()
    %update odometry for any previous inertia
    global position2_text
    global orientation2_text
    global position2
    global orientation2
    
    odom_obtention2();
    text=sprintf('%s\n%s\n%s\n%s','Position',['X: ' num2str(position2(1)) ' m'],['Y: ' num2str(position2(2)) ' m'],['Z: ' num2str(position2(3)) ' m']);
    position2_text.String=text;
    text=sprintf('%s\n%s\n%s\n%s','Orientation',['X: ' num2str(orientation2(1)) ' deg'],['Y: ' num2str(orientation2(2)) ' deg'],['Z: ' num2str(orientation2(3)) ' deg']);
    orientation2_text.String=text;
end



