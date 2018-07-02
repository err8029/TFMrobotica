function [position2,orientation2] = odom_obtention2()
    global odom2_sub
    %position odom for robot 1
    x=odom2_sub.LatestMessage.Pose.Pose.Position.X;
    y=odom2_sub.LatestMessage.Pose.Pose.Position.Y;
    z=odom2_sub.LatestMessage.Pose.Pose.Position.Z;
    %orientation odom for robot 1
    q1=odom2_sub.LatestMessage.Pose.Pose.Orientation.X;
    q2=odom2_sub.LatestMessage.Pose.Pose.Orientation.Y;
    q3=odom2_sub.LatestMessage.Pose.Pose.Orientation.Z;
    q4=odom2_sub.LatestMessage.Pose.Pose.Orientation.W;
    [yaw, pitch, roll] =  quaternions2deg(q1,q2,q3,q4);
    %put info into arrays
    position2 =[x,y,z];
    orientation2 =  [yaw, pitch, roll];
end

