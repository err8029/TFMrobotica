function [controller] = purePursuit_init(optimal_path)
    controller = robotics.PurePursuit;
    controller.Waypoints = optimal_path;
    controller.DesiredLinearVelocity = 0.3;
    controller.MaxAngularVelocity = 0.5;
    controller.LookaheadDistance = 1;
end

