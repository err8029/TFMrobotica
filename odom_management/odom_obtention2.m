function odom_obtention2()
    global odom2_sub
    global position2
    global orientation2
    
    %position odom for robot 1
    x=odom2_sub.LatestMessage.Pose.Pose.Position.X;
    y=odom2_sub.LatestMessage.Pose.Pose.Position.Y;
    z=odom2_sub.LatestMessage.Pose.Pose.Position.Z;
    %orientation odom for robot 1
    W=odom2_sub.LatestMessage.Pose.Pose.Orientation.W;
    X=odom2_sub.LatestMessage.Pose.Pose.Orientation.X;
    Y=odom2_sub.LatestMessage.Pose.Pose.Orientation.Y;
    Z=odom2_sub.LatestMessage.Pose.Pose.Orientation.Z;
    angles2 = quat2eul([W X Y Z]);
    %put info into arrays
    position2 =[x,y,z];
    orientation2 =  angles2;
end

