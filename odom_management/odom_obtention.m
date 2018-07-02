function [position1,orientation1] = odom_obtention()
    global odom_sub
    %position odom for robot 1
    x=odom_sub.LatestMessage.Pose.Pose.Position.X;
    y=odom_sub.LatestMessage.Pose.Pose.Position.Y;
    z=odom_sub.LatestMessage.Pose.Pose.Position.Z;
    %orientation odom for robot 1
    q1=odom_sub.LatestMessage.Pose.Pose.Orientation.X;
    q2=odom_sub.LatestMessage.Pose.Pose.Orientation.Y;
    q3=odom_sub.LatestMessage.Pose.Pose.Orientation.Z;
    q4=odom_sub.LatestMessage.Pose.Pose.Orientation.W;
    [yaw, pitch, roll] =  quaternions2deg(q1,q2,q3,q4);
    %put info into arrays
    position1 =[x,y,z];
    orientation1 =  [yaw, pitch, roll];
end

