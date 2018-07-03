function [controller] = purePursuit_init(Optimal_path,lin)
controller = robotics.PurePursuit;
controller.Waypoints = Optimal_path;
controller.DesiredLinearVelocity = lin;
controller.MaxAngularVelocity = lin*3;
controller.LookaheadDistance = lin/4;
end

