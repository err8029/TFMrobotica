function odom_update()
    %update odometry for any previous inertia
    global position1_text
    global position2_text
    global orientation1_text
    global orientation2_text
    
    [position2,orientation2] = odom_obtention2();
    [position1,orientation1] = odom_obtention();
    text=sprintf('%s\n%s\n%s\n%s','Position',['X: ' num2str(position1(1)) ' m'],['Y: ' num2str(position1(2)) ' m'],['Z: ' num2str(position1(3)) ' m']);
    position1_text.String=text;
    text=sprintf('%s\n%s\n%s\n%s','Orientation',['X: ' num2str(orientation1(1)) ' deg'],['Y: ' num2str(orientation1(2)) ' deg'],['Z: ' num2str(orientation1(3)) ' deg']);
    orientation1_text.String=text;
    text=sprintf('%s\n%s\n%s\n%s','Position',['X: ' num2str(position2(1)) ' m'],['Y: ' num2str(position2(2)) ' m'],['Z: ' num2str(position2(3)) ' m']);
    position2_text.String=text;
    text=sprintf('%s\n%s\n%s\n%s','Orientation',['X: ' num2str(orientation2(1)) ' deg'],['Y: ' num2str(orientation2(2)) ' deg'],['Z: ' num2str(orientation2(3)) ' deg']);
    orientation2_text.String=text;
end

