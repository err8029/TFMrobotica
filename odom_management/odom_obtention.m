function odom_obtention()
    global odom_sub
    global position1
    global orientation1
    
    %position odom for robot 1
    x=odom_sub.LatestMessage.Pose.Pose.Position.X;
    y=odom_sub.LatestMessage.Pose.Pose.Position.Y;
    z=odom_sub.LatestMessage.Pose.Pose.Position.Z;
    %orientation odom for robot 1
    W=odom_sub.LatestMessage.Pose.Pose.Orientation.W;
    X=odom_sub.LatestMessage.Pose.Pose.Orientation.X;
    Y=odom_sub.LatestMessage.Pose.Pose.Orientation.Y;
    Z=odom_sub.LatestMessage.Pose.Pose.Orientation.Z;
    angles = quat2eul([W X Y Z]);
    %put info into arrays
    position1 =[x,y,z];
    orientation1 =  angles;
end

